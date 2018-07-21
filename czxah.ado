capture program drop czxah
program define czxah
	version 12.0
	clear
	syntax anything(name = name), [path(string) Type(string) Period(string) Savefile Graph GRaphtype(string)]
	if "`graphtype'" != ""{
		local graph = "graph"
	}
	if "`graphtype'" == ""{
		local graphtype = "line"
	}
	local name = "导出"
	if "`name'" == "en"{
		local name = "export"
	}
	if "`path'" != "" {
		capture mkdir `path'
	}
	else {
		local path `c(pwd)'
	}
	qui cd "`path'"
	qui copy "`name'.xml" temptxtfile.txt, replace
	local type = "st"
	if "`type'" == "stepcount" | "`type'" == "st"{
		qui{
			if c(stata_version) >= 14 {
				clear
				cap unicode encoding set gb18030
				qui unicode translate temptxtfile.txt
				cap unicode erasebackups, badidea
			}	
			qui insheet using temptxtfile.txt, clear
			if `=_N' == 0 {
				disp as error `"错误！：无数据"'
				clear
				cap erase temptxtfile.txt
				if _rc != 0 {
					! del temptxtfile.txt /F
				}
				exit 601
			}
			clear
			infix strL v 1-20000 using temptxtfile.txt
			keep if index(v, "StepCount")
			if `=_N' == 0 {
				disp as error `"错误！：无步数数据"'
				exit 601
			}
			gen v1 = ustrregexs(0) if ustrregexm(v,"\d\d:\d\d:\d\d")
			gen v2 = ustrregexs(0) if ustrregexm(v,"\d\d\d\d-\d\d-\d\d")
			gen v3 = ustrregexs(0) if ustrregexm(v,`"value=\"([\d]+)\""')
			replace v3 = ustrregexs(0) if ustrregexm(v3, `"(\d+)"')
			drop v
			destring v3, force replace
			gen time = v2 + " " + v1
			gen clock = clock(time, "YMDhms")
			gen date = date(v2, "YMD")
			format clock %tcCCYY-NN-DD_HH:MM:SS
			format date %dCY-N-D
			order clock date v3
			drop v1 v2 time
			rename v3 clock_step
			label var clock "该数据记录的时刻"
			label var date "日期"
			label var clock_step "时刻步数"
		}
			if "`period'" == "day"{
				gen dow = dow(date)
				gen week = week(date)
				bysort date: egen day_step = sum(clock_step)
				qui drop if date[_n] == date[_n-1]
				qui drop clock clock_step
				label var dow "星期"
				label var week "周数（从每年的前七天为第一周开始）"
				label var day_step "每日步数"
			}
			if "`period'" == "week"{
				gen week = week(date)
				gen dow = dow(date)
				bysort week: egen week_step = sum(clock_step)
				sort date
				qui drop if week[_n] == week[_n-1]
				qui drop clock clock_step
				label var date "日期"
				label var dow "星期"
				label var week_step "每周步数"
				label var week "周数（从每年的前七天为第一周开始）"
			}
			if "`period'" == "month"{
				gen dow = dow(date)
				gen month = month(date)
				bysort month: egen month_step = sum(clock_step)
				sort date
				qui drop if month[_n] == month[_n-1]
				qui drop clock clock_step
				label var date "日期"
				label var dow "星期"
				label var month_step "每月步数"
				label var month "月份"
			}
			if "`period'" == "year"{
				gen year = year(date)
				bysort year: egen year_step = sum(clock_step)
				sort date
				qui drop if year[_n] == year[_n-1]
				qui drop clock clock_step
				label var date "日期"
				label var year_step "每年步数"
				label var year "年份"
			}
			if "`period'" == "clock"{
				if "`save'" != ""{
					compress
					save "分时步数数据.dta", replace
				}
				if "`graph'" != ""{
					if "`graphtype'" == "line"{
						line clock_step date, xlabel(#4, angle(20)) ylabel(, angle(0))
					}
					if "`graphtype'" == "hist"{
						hist clock_step, freq ylabel(, angle(0))
					}
					if "`graphtype'" == "kdensity"{
						kdensity clock_step, ylabel(, angle(0))
					}
				}
			}
			if "`period'" == "day"{
				if "`save'" != ""{
					compress
					save "每日步数数据.dta", replace
				}
				if "`graph'" != ""{
					if "`graphtype'" == "line"{
						line day_step date, xlabel(#4, angle(20)) ylabel(, angle(0))
					}
					if "`graphtype'" == "hist"{
						hist day_step, freq ylabel(, angle(0))
					}
					if "`graphtype'" == "kdensity"{
						kdensity day_step, ylabel(, angle(0))
					}
				}
			}
			if "`period'" == "week"{
				if "`save'" != ""{
					compress
					save "每周步数数据.dta", replace
				}
				if "`graph'" != ""{
					if "`graphtype'" == "line"{
						line week_step date, xlabel(#4, angle(20)) ylabel(, angle(0))
					}
					if "`graphtype'" == "hist"{
						hist week_step, freq ylabel(, angle(0))
					}
					if "`graphtype'" == "kdensity"{
						kdensity week_step, ylabel(, angle(0))
					}
				}
			}
			if "`period'" == "month"{
				if "`save'" != ""{
					compress
					save "每月步数数据.dta", replace
				}
				if "`graph'" != ""{
					if "`graphtype'" == "line"{
						line month_step date, xlabel(#4, angle(20)) ylabel(, angle(0))
					}
					if "`graphtype'" == "hist"{
						hist month_step, freq ylabel(, angle(0))
					}
					if "`graphtype'" == "kdensity"{
						kdensity month_step, ylabel(, angle(0))
					}
				}
			}
			if "`period'" == "year"{
				if "`save'" != ""{
					compress
					save "每年步数数据.dta", replace
				}
				if "`graph'" != ""{
					if "`graphtype'" == "line"{
						line year_step date, xlabel(#4, angle(20)) ylabel(, angle(0))
					}
					if "`graphtype'" == "hist"{
						hist year_step, freq ylabel(, angle(0))
					}
					if "`graphtype'" == "kdensity"{
						kdensity year_step, ylabel(, angle(0))
					}
				}
			}
	}
	if "`type'" == "distance" | "`type'" == "di"{
		qui{
			if c(stata_version) >= 14 {
			clear
			cap unicode encoding set gb18030
			qui unicode translate temptxtfile.txt
			cap unicode erasebackups, badidea
			}	
			qui insheet using temptxtfile.txt, clear
			if `=_N' == 0 {
				disp as error `"错误！：无数据"'
				clear
				cap erase temptxtfile.txt
				if _rc != 0 {
					! del temptxtfile.txt /F
				}
				exit 601
			}
			clear
			infix strL v 1-20000 using temptxtfile.txt
			keep if index(v, "DistanceWalkingRunning")
			if `=_N' == 0 {
				disp as error `"错误！：无运动距离数据"'
				exit 601
			}
			gen v1 = ustrregexs(0) if ustrregexm(v,"\d\d:\d\d:\d\d")
			gen v2 = ustrregexs(0) if ustrregexm(v,"\d\d\d\d-\d\d-\d\d")
			gen v3 = ustrregexs(0) if ustrregexm(v,`"value=\"([\d.\d]+)\""')
			replace v3 = ustrregexs(0) if ustrregexm(v3, `"(\d.\d+)"')
			drop v
			destring v3, force replace
			format v3 %6.2f
			gen time = v2 + " " + v1
			gen clock = clock(time, "YMDhms")
			gen date = date(v2, "YMD")
			format clock %tcCCYY-NN-DD_HH:MM:SS
			format date %dCY-N-D
			order clock date v3
			drop v1 v2 time
			rename v3 clock_distance
			label var clock "该数据记录的时刻"
			label var date "日期"
			label var clock_distance "时刻距离"
		}
			if "`period'" == "day"{
				gen dow = dow(date)
				gen week = week(date)
				bysort date: egen day_distance = sum(clock_distance)
				qui drop if date[_n] == date[_n-1]
				qui drop clock clock_distance
				label var dow "星期"
				label var week "周数（从每年的前七天为第一周开始）"
				label var day_step "每日运动距离"
			}
			if "`period'" == "week"{
				gen week = week(date)
				gen dow = dow(date)
				bysort week: egen week_distance = sum(clock_distance)
				sort date
				qui drop if week[_n] == week[_n-1]
				qui drop clock clock_distance
				label var date "日期"
				label var dow "星期"
				label var week_distance "每周运动距离"
				label var week "周数（从每年的前七天为第一周开始）"
			}
			if "`period'" == "month"{
				gen dow = dow(date)
				gen month = month(date)
				bysort month: egen month_distance = sum(clock_distance)
				sort date
				qui drop if month[_n] == month[_n-1]
				qui drop clock clock_distance
				label var date "日期"
				label var dow "星期"
				label var month_distance "每月运动距离"
				label var month "月份"
			}
			if "`period'" == "year"{
				gen year = year(date)
				bysort year: egen year_distance = sum(clock_distance)
				sort date
				qui drop if year[_n] == year[_n-1]
				qui drop clock clock_distance
				label var date "日期"
				label var year_distance "每年运动距离"
				label var year "年份"
			}
			if "`period'" == "clock"{
				if "`save'" != ""{
					compress
					save "分时运动距离数据.dta", replace
				}
				if "`graph'" != ""{
					if "`graphtype'" == "line"{
						line clock_distance date, xlabel(#4, angle(20)) ylabel(, angle(0))
					}
					if "`graphtype'" == "hist"{
						hist clock_distance, freq ylabel(, angle(0))
					}
					if "`graphtype'" == "kdensity"{
						kdensity clock_distance, ylabel(, angle(0))
					}
				}
			}
			if "`period'" == "day"{
				if "`save'" != ""{
					compress
					save "每日运动距离数据.dta", replace
				}
				if "`graph'" != ""{
					if "`graphtype'" == "line"{
						line day_distance date, xlabel(#4, angle(20)) ylabel(, angle(0))
					}
					if "`graphtype'" == "hist"{
						hist day_distance, freq ylabel(, angle(0))
					}
					if "`graphtype'" == "kdensity"{
						kdensity day_distance, ylabel(, angle(0))
					}
				}
			}
			if "`period'" == "week"{
				if "`save'" != ""{
					compress
					save "每周运动距离数据.dta", replace
				}
				if "`graph'" != ""{
					if "`graphtype'" == "line"{
						line week_distance date, xlabel(#4, angle(20)) ylabel(, angle(0))
					}
					if "`graphtype'" == "hist"{
						hist week_distance, freq ylabel(, angle(0))
					}
					if "`graphtype'" == "kdensity"{
						kdensity week_distance, ylabel(, angle(0))
					}
				}
			}
			if "`period'" == "month"{
				if "`save'" != ""{
					compress
					save "每月运动距离数据.dta", replace
				}
				if "`graph'" != ""{
					if "`graphtype'" == "line"{
						line month_distance date, xlabel(#4, angle(20)) ylabel(, angle(0))
					}
					if "`graphtype'" == "hist"{
						hist month_distance, freq ylabel(, angle(0))
					}
					if "`graphtype'" == "kdensity"{
						kdensity month_distance, ylabel(, angle(0))
					}
				}
			}
			if "`period'" == "year"{
				if "`save'" != ""{
					compress
					save "每年运动距离数据.dta", replace
				}
				if "`graph'" != ""{
					if "`graphtype'" == "line"{
						line year_distance date, xlabel(#4, angle(20)) ylabel(, angle(0))
					}
					if "`graphtype'" == "hist"{
						hist year_distance, freq ylabel(, angle(0))
					}
					if "`graphtype'" == "kdensity"{
						kdensity year_distance, ylabel(, angle(0))
					}
				}
			}
	}
	if "`type'" == "climb" | "`type'" == "cl"{
		qui{
			if c(stata_version) >= 14 {
				clear
				cap unicode encoding set gb18030
				qui unicode translate temptxtfile.txt
				cap unicode erasebackups, badidea
			}	
			qui insheet using temptxtfile.txt, clear
			if `=_N' == 0 {
				disp as error `"错误！：无数据"'
				clear
				cap erase temptxtfile.txt
				if _rc != 0 {
					! del temptxtfile.txt /F
				}
				exit 601
			}
			clear
			infix strL v 1-20000 using temptxtfile.txt
			keep if index(v, "FlightsClimbed")
			if `=_N' == 0 {
				disp as error `"错误！：无楼层数据"'
				exit 601
			}
			gen v1 = ustrregexs(0) if ustrregexm(v,"\d\d:\d\d:\d\d")
			gen v2 = ustrregexs(0) if ustrregexm(v,"\d\d\d\d-\d\d-\d\d")
			gen v3 = ustrregexs(0) if ustrregexm(v,`"value=\"([\d]+)\""')
			replace v3 = ustrregexs(0) if ustrregexm(v3, `"(\d+)"')
			drop v
			destring v3, force replace
			gen time = v2 + " " + v1
			gen clock = clock(time, "YMDhms")
			gen date = date(v2, "YMD")
			format clock %tcCCYY-NN-DD_HH:MM:SS
			format date %dCY-N-D
			order clock date v3
			drop v1 v2 time
			rename v3 clock_climb
			label var clock "该数据记录的时刻"
			label var date "日期"
			label var clock_climb "时刻楼层数"
		}
			if "`period'" == "day"{
				gen dow = dow(date)
				gen week = week(date)
				bysort date: egen day_climb = sum(clock_climb)
				qui drop if date[_n] == date[_n-1]
				qui drop clock clock_climb
				label var dow "星期"
				label var week "周数（从每年的前七天为第一周开始）"
				label var day_climb "每日楼层数"
			}
			if "`period'" == "week"{
				gen week = week(date)
				gen dow = dow(date)
				bysort week: egen week_climb = sum(clock_climb)
				sort date
				qui drop if week[_n] == week[_n-1]
				qui drop clock clock_climb
				label var date "日期"
				label var dow "星期"
				label var week_climb "每周楼层数"
				label var week "周数（从每年的前七天为第一周开始）"
			}
			if "`period'" == "month"{
				gen dow = dow(date)
				gen month = month(date)
				bysort month: egen month_climb = sum(clock_climb)
				sort date
				qui drop if month[_n] == month[_n-1]
				qui drop clock clock_step
				label var date "日期"
				label var dow "星期"
				label var month_climb "每月楼层数"
				label var month "月份"
			}
			if "`period'" == "year"{
				gen year = year(date)
				bysort year: egen year_climb = sum(clock_climb)
				sort date
				qui drop if year[_n] == year[_n-1]
				qui drop clock clock_climb
				label var date "日期"
				label var year_climb "每年楼层数"
				label var year "年份"
			}
			if "`period'" == "clock"{
				if "`save'" != ""{
					compress
					save "分时楼层数数据.dta", replace
				}
				if "`graph'" != ""{
					if "`graphtype'" == "line"{
						line clock_climb date, xlabel(#4, angle(20)) ylabel(, angle(0))
					}
					if "`graphtype'" == "hist"{
						hist clock_climb, freq ylabel(, angle(0))
					}
					if "`graphtype'" == "kdensity"{
						kdensity clock_climb, ylabel(, angle(0))
					}
				}
			}
			if "`period'" == "day"{
				if "`save'" != ""{
					compress
					save "每日楼层数数据.dta", replace
				}
				if "`graph'" != ""{
					if "`graphtype'" == "line"{
						line day_climb date, xlabel(#4, angle(20)) ylabel(, angle(0))
					}
					if "`graphtype'" == "hist"{
						hist day_climb, freq ylabel(, angle(0))
					}
					if "`graphtype'" == "kdensity"{
						kdensity day_climb, ylabel(, angle(0))
					}
				}
			}
			if "`period'" == "week"{
				if "`save'" != ""{
					compress
					save "每周楼层数数据.dta", replace
				}
				if "`graph'" != ""{
					if "`graphtype'" == "line"{
						line week_climb date, xlabel(#4, angle(20)) ylabel(, angle(0))
					}
					if "`graphtype'" == "hist"{
						hist week_climb, freq ylabel(, angle(0))
					}
					if "`graphtype'" == "kdensity"{
						kdensity week_climb, ylabel(, angle(0))
					}
				}
			}
			if "`period'" == "month"{
				if "`save'" != ""{
					compress
					save "每月楼层数数据.dta", replace
				}
				if "`graph'" != ""{
					if "`graphtype'" == "line"{
						line month_climb date, xlabel(#4, angle(20)) ylabel(, angle(0))
					}
					if "`graphtype'" == "hist"{
						hist month_climb, freq ylabel(, angle(0))
					}
					if "`graphtype'" == "kdensity"{
						kdensity month_climb, ylabel(, angle(0))
					}
				}
			}
			if "`period'" == "year"{
				if "`save'" != ""{
					compress
					save "每年楼层数数据.dta", replace
				}
				if "`graph'" != ""{
					if "`graphtype'" == "line"{
						line year_climb date, xlabel(#4, angle(20)) ylabel(, angle(0))
					}
					if "`graphtype'" == "hist"{
						hist year_climb, freq ylabel(, angle(0))
					}
					if "`graphtype'" == "kdensity"{
						kdensity year_climb, ylabel(, angle(0))
					}
				}
			}
	}
	if "`type'" == "sleep" | "`type'" == "sl"{
		qui{
			if c(stata_version) >= 14 {
				clear
				cap unicode encoding set gb18030
				qui unicode translate temptxtfile.txt
				cap unicode erasebackups, badidea
			}	
			qui insheet using temptxtfile.txt, clear
			if `=_N' == 0 {
				disp as error `"错误！：无数据"'
				clear
				cap erase temptxtfile.txt
				if _rc != 0 {
					! del temptxtfile.txt /F
				}
				exit 601
			}
			clear
			infix strL v 1-20000 using temptxtfile.txt
			keep if index(v, "SleepAnalysis")
			if `=_N' == 0 {
				disp as error `"错误！：无睡眠数据"'
				exit 601
			}
			gen v1 = ustrregexs(0) if ustrregexm(v,`"creationDate=\"(\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d+)"')
			gen v2 = ustrregexs(0) if ustrregexm(v,`"startDate=\"(\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d+)"')
			gen v3 = ustrregexs(0) if ustrregexm(v,`"endDate=\"(\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d+)"')
			replace v1 = ustrregexs(0) if ustrregexm(v1, "\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d")
			replace v2 = ustrregexs(0) if ustrregexm(v2, "\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d")
			replace v3 = ustrregexs(0) if ustrregexm(v3, "\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d")
			gen tempdate = ustrregexs(0) if ustrregexm(v, "\d\d\d\d-\d\d-\d\d")
			drop v
			gen creationDate = clock(v1, "YMDhms")
			gen startDate = clock(v2, "YMDhms")
			gen endDate = clock(v3, "YMDhms")
			gen sleeptime = endDate - startDate
			replace sleeptime = sleeptime/(1000*3600)
			format creationDate %tcCCYY-NN-DD_HH:MM:SS
			format endDate %tcCCYY-NN-DD_HH:MM:SS
			format startDate %tcCCYY-NN-DD_HH:MM:SS
			gen date = date(tempdate, "YMD")
			drop tempdate
			format date %dCY-N-D
			drop v1 v2 v3
			label var creationDate "创建该数据的时刻"
			label var startDate "入睡时刻"
			label var endDate "起床时刻"
			label var date "日期"
			label var sleeptime "睡眠时间"
		}
			if "`period'" == "day"{
				gen dow = dow(date)
				gen week = week(date)
				bysort date: egen day_sleep = sum(sleeptime)
				qui drop if date[_n] == date[_n-1]
				label var dow "星期"
				label var week "周数（从每年的前七天为第一周开始）"
				label var day_sleep "每日睡眠时间"
			}
			if "`period'" == "week"{
				gen week = week(date)
				gen dow = dow(date)
				bysort week: egen week_sleep = sum(sleeptime)
				sort date
				qui drop if week[_n] == week[_n-1]
				label var date "日期"
				label var dow "星期"
				label var week_sleep "每周睡眠总时间"
				label var week "周数（从每年的前七天为第一周开始）"
			}
			if "`period'" == "month"{
				gen dow = dow(date)
				gen month = month(date)
				bysort month: egen month_sleep = sum(sleeptime)
				sort date
				qui drop if month[_n] == month[_n-1]
				label var date "日期"
				label var dow "星期"
				label var month_sleep "每月睡眠总时间"
				label var month "月份"
			}
			if "`period'" == "year"{
				gen year = year(date)
				bysort year: egen year_sleep = sum(sleeptime)
				sort date
				qui drop if year[_n] == year[_n-1]
				label var date "日期"
				label var year_sleep "每年睡眠总时间"
				label var year "年份"
			}
			if "`period'" == "clock"{
				if "`save'" != ""{
					compress
					save "分时睡眠数据.dta", replace
				}
				if "`graph'" != ""{
					if "`graphtype'" == "line"{
						line sleeptime date, xlabel(#4, angle(20)) ylabel(, angle(0))
					}
					if "`graphtype'" == "hist"{
						hist sleeptime, freq ylabel(, angle(0))
					}
					if "`graphtype'" == "kdensity"{
						kdensity sleeptime, ylabel(, angle(0))
					}
				}
			}
			if "`period'" == "day"{
				if "`save'" != ""{
					compress
					save "每日睡眠数据.dta", replace
				}
				if "`graph'" != ""{
					if "`graphtype'" == "line"{
						line day_sleep date, xlabel(#4, angle(20)) ylabel(, angle(0))
					}
					if "`graphtype'" == "hist"{
						hist day_sleep, freq ylabel(, angle(0))
					}
					if "`graphtype'" == "kdensity"{
						kdensity day_sleep, ylabel(, angle(0))
					}
				}
			}
			if "`period'" == "week"{
				if "`save'" != ""{
					compress
					save "每周睡眠数据.dta", replace
				}
				if "`graph'" != ""{
					if "`graphtype'" == "line"{
						line week_sleep date, xlabel(#4, angle(20)) ylabel(, angle(0))
					}
					if "`graphtype'" == "hist"{
						hist week_sleep, freq ylabel(, angle(0))
					}
					if "`graphtype'" == "kdensity"{
						kdensity week_sleep, ylabel(, angle(0))
					}
				}
			}
			if "`period'" == "month"{
				if "`save'" != ""{
					compress
					save "每月睡眠数据.dta", replace
				}
				if "`graph'" != ""{
					if "`graphtype'" == "line"{
						line month_sleep date, xlabel(#4, angle(20)) ylabel(, angle(0))
					}
					if "`graphtype'" == "hist"{
						hist month_sleep, freq ylabel(, angle(0))
					}
					if "`graphtype'" == "kdensity"{
						kdensity month_sleep, ylabel(, angle(0))
					}
				}
			}
			if "`period'" == "year"{
				if "`save'" != ""{
					compress
					save "每年睡眠数据.dta", replace
				}
				if "`graph'" != ""{
					if "`graphtype'" == "line"{
						line year_sleep date, xlabel(#4, angle(20)) ylabel(, angle(0))
					}
					if "`graphtype'" == "hist"{
						hist year_sleep, freq ylabel(, angle(0))
					}
					if "`graphtype'" == "kdensity"{
						kdensity year_sleep, ylabel(, angle(0))
					}
				}
			}	
		}
	cap erase temptxtfile.txt
end
