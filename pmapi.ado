*! 获取一个城市所有监测点的pm2_5/pm10/co/no2/so2/o3数据
*! 程振兴 2018年7月21日
cap prog drop pmapi
prog def pmapi
version 14.0
	syntax anything
	clear all
	tokenize `anything'
	local city = "`1'"
	local ptype = "`2'"
	di in green"获取中···"
	qui{
		percentencode `city'
		copy "http://www.pm25.in/api/querys/`ptype'.json?city=`r(percentencode)'&token=aHqp6yQJ7WQkdPFXZNbn" temp.txt, replace
		utrans temp.txt
		set obs 1
		gen v = fileread("temp.txt")
		split v, parse("},{")
		drop v
		sxpose, clear
		ren _var1 v
		gen aqi = ustrregexs(1) if ustrregexm(v,`""aqi":(.*),"area""')
		gen area = ustrregexs(1) if ustrregexm(v,`""area":"(.*)","`ptype'""')
		gen `ptype' = ustrregexs(1) if ustrregexm(v,`""`ptype'":(.*),"`ptype'_24h""')
		gen `ptype'_24h = ustrregexs(1) if ustrregexm(v,`""`ptype'_24h":(.*),"position_name""')
		gen position_name = ustrregexs(1) if ustrregexm(v,`""position_name":"(.*)","primary_pollutant""')
		gen primary_pollutant = ustrregexs(1) if ustrregexm(v,`""primary_pollutant":"(.*)","quality""')
		gen quality = ustrregexs(1) if ustrregexm(v,`""quality":"(.*)","station_code""')
		gen station_code = ustrregexs(1) if ustrregexm(v,`""station_code":"(.*)","time_point""')
		gen time_point = ustrregexs(1) if ustrregexm(v,`""time_point":"(.*)""')
		drop v
		label var aqi "空气质量指数"
		label var area "城市名称"
		cap label var `ptype' "`ptype'_1小时平均"
		cap label var `ptype'_24h "`ptype'_24小时滑动平均"
		label var position_name "监测点名称"
		label var primary_pollutant "首要污染物"
		label var quality "空气质量指数类别，有“优、良、轻度污染、中度污染、重度污染、严重污染”6类"
		label var station_code "监测点编码"
		label var time_point "数据发布的时间"
		erase temp.txt
	}
	br
	di in green"获取完成！"
end 
