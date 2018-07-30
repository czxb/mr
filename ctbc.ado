*! 国债收益率期限结构获取和可视化
*! 程振兴 2018年7月30日
*! ctbc, p s("20180101") yla(2(1)6)
*! ctbc, p
*! ctbc
*! ctbc, res
cap prog drop ctbc
prog def ctbc
	version 14.0
	syntax, [Start(string) End(string) SHELLpath(string) REShape Plot YLAbel(string)]
	clear all
	if "`start'" == "" local start = "19900101"
	if "`end'" == "" local end: disp %dCYND date("`c(current_date)'","DMY")
	if "`ylabel'" == "" local ylabel = "0(2)10"
	if "`shellpath'" == "" local shellpath "/Users/mr.cheng/anaconda3/bin"
	di "正在下载和整理数据······"
	qui{
		!`shellpath'/cn-treasury-curve -f zipline treasury-curve.csv
	}
	di "下载完成······"
	di "开始导入数据······"
	qui import delimited treasury-curve.csv, varnames(nonames) clear
	ren v1 date
	ren v2 m1
	ren v3 m3
	ren v4 m6
	ren v5 y1
	ren v6 y2
	ren v7 y3
	ren v8 y5
	ren v9 y7
	ren v10 y10
	ren v11 y20
	ren v12 y30
	label var m1 "1 Month"
	label var m3 "3 Month"
	label var m6 "6 Month"
	label var y1 "1 Year"
	label var y2 "2 Year"
	label var y3 "3 Year"
	label var y5 "5 Year"
	label var y7 "7 Year"
	label var y10 "10 Year"
	label var y20 "20 Year"
	label var y30 "30 Year"
	qui drop in 1
	gen date1 = date(date, "YMD")
	format date1 %tdCY-N-D
	order date1
	drop date
	ren date1 date
	label var date "Date"
	qui destring, replace
	if "`plot'" != ""{
		di "开始绘图······"
		local d1 = date("`start'", "YMD")
		local d2 = date("`end'", "YMD")
		preserve
		qui keep if inrange(date, `d1', `d2')
		cap which colorscheme
		if _rc != 0{
			di "因为你是第一次使用，所以需要安装调色板命令colorscheme，即将安装······"
			net install colorscheme.pkg, from("https://github.com/matthieugomez/stata-colorscheme/raw/master/")
		}
		colorscheme 5, palette(Set1)
		local c1 = `"`r(colors)'"'
		colorscheme 5, palette(Set2)
		local c2 = `"`r(colors)'"'
		colorscheme 5, palette(Set3)
		local c3 = `"`r(colors)'"'
		line m1 m3 m6 y1 y2 y3 y5 y7 y10 y20 y30 date, ///
			xlabel(,ang(20)) xti("日期") yti("国债到期收益率(%)") ///
			leg(order(	1 "1month" 	///
						2 "3month" 	///
						3 "6month" 	///
						4 "1year" 	///
						5 "2year" 	///
						6 "3year" 	///
						7 "5year" 	///
						8 "7year" 	///
						9 "10year" 	///
						10 "20year" ///
						11 "30year") ///
						pos(1) ring(0) col(3)) ///
			lc(`c1' `c2' `c3') ///
			lp(solid solid solid solid solid ///
			solid solid solid solid solid solid) ///
			yla(`ylabel')
		restore
	}
	if "`reshape'" != ""{
		qui import delimited treasury-curve.csv, varnames(nonames) clear
		di "开始变长转换······"
		qui drop in 1
		ren v1 date
		qui{
			reshape long v, i(date) j(j)
			gen date1 = date(date, "YMD")
			format date1 %tdCY-N-D
			order date1
			drop date
			ren date1 date
			destring, replace
			ren j term
			ren v ytm
			replace term = term - 1
			label var date "Date"
			label var term "Term"
			label var ytm "YTM(%)"
		}
		label def term ///
			1 "1month" ///
			2 "3month" ///
			3 "6month" ///
			4 "1year" ///
			5 "2year" ///
			6 "3year" ///
			7 "5year" ///
			8 "7year" ///
			9 "10year" ///
			10 "20year" ///
			11 "30year"
		label val term term
		di "转换完成！"
	}
	erase treasury-curve.csv
	di "数据来源：chinabond.com.cn"
end 
