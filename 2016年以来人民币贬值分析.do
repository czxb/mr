* 下载数据
clear all
rcall: setwd("~/Desktop"); library(messyr); df <- get_gdp(); write.table(df, file = "GDP.csv", sep = ',', row.name = F) 
import delimited "~/Desktop/GDP.csv", encoding(utf8) clear varn(1)
erase GDP.csv
save GDP_temp, replace

* 整理数据
use GDP_temp, clear
keep if index(数据日期, "一至四季度")
replace 数据日期 = subinstr(数据日期, "年一至四季度", "", .)
replace gdp绝对额 = subinstr(gdp绝对额, ",", "", .)
replace gdp同比增减 = subinstr(gdp同比增减, "%", "", .)
replace 第一产业gdp绝对额 = subinstr(第一产业gdp绝对额, ",", "", .)
replace 第一产业gdp同比增减 = subinstr(第一产业gdp同比增减, "%", "", .)
replace 第二产业gdp绝对额 = subinstr(第二产业gdp绝对额, ",", "", .)
replace 第二产业gdp同比增减 = subinstr(第二产业gdp同比增减, "%", "", .)
replace 第三产业gdp绝对额 = subinstr(第三产业gdp绝对额, ",", "", .)
replace 第三产业gdp同比增减 = subinstr(第三产业gdp同比增减, "%", "", .)
destring, replace force
save GDP, replace

* 绘制年度GDP的走势图
use GDP, clear
replace gdp绝对额 = gdp绝对额 / 10000
ren gdp绝对额 gdp 
ren 数据日期 date
ren gdp同比增减 gdprate
tw ///
line gdp date, ///
	xti(年份) yti(GDP绝对额(亿元人民币)) ///
	xla(1952(5)2019) yla(0(10)90) ///
	xline(2017) yline(82.71217) || ///
pcarrowi 65 2000 82.7 2017, ///
	leg(off) ///
	lc(red*0.8) lw(*2) ///
	mlw(*2) mfc(red*0.8) mc(red*0.8) ///
	text(60 1997 "2017年GDP总额为""82.71万亿(RMB)")
gre gdptrend

* GDP同比增速的走势图
tw ///
line gdprate date if date >= 1990, 		///
	xti(年份) yti(GDP同比增速(%)) 			///
	xla(1990(5)2020) yla(3(2)15) 		///
	xline(1991) yline(7.0) || 			///
scatteri 6.9 2015, m(D) mc(red*0.8) ||, ///
text(5 1993 "1991年""9.2%") leg(off)|| 	///
pcarrowi 11 2015 7 2015, 				///
	leg(off) 							///
	lc(red*0.8) lw(*1.5) 				///
	mlw(*1.2) mfc(red*0.8) mc(red*0.8) 	///
	text(12 2015 "2015年GDP增速为6.9%""自1991年以来首次低于7%")
gre gdpratetrend

* 外贸进出口变化
clear all
rcall: setwd("~/Desktop"); library(messyr); df <- get_custom(); write.table(df, file = "custom.csv", sep = ',', row.name = F) 
import delimited "~/Desktop/custom.csv", encoding(utf8) clear varn(1)
erase custom.csv
save custom_temp, replace

use custom_temp, clear
replace 当月进口额总金额 = subinstr(当月进口额总金额, ",", "", .)
replace 当月进口额同比增长 = subinstr(当月进口额同比增长, "%", "", .)
replace 当月出口额总金额 = subinstr(当月出口额总金额, ",", "", .)
replace 当月出口额同比增长 = subinstr(当月出口额同比增长, "%", "", .)
replace 累计进口额总金额 = subinstr(累计进口额总金额, ",", "", .)
replace 累计进口额同比增长 = subinstr(累计进口额同比增长, "%", "", .)
replace 累计出口额总金额 = subinstr(累计出口额总金额, ",", "", .)
replace 累计出口额同比增长 = subinstr(累计出口额同比增长, "%", "", .)
gen date = date(数据日期, "YM")
drop 数据日期
order date
destring, replace force
format date %tdCY-N
gen year = year(date)
order year
bysort year: egen import = total(当月进口额总金额)
bysort year: egen export = total(当月出口额总金额)
keep year import export
duplicates drop year, force
tw line import export year if year < 2018, ///
	xla(2001(3)2017) ///
	xline(2009) ///
	xti("年份") yti(进口总额和出口总额) || ///
scatteri 16807.9 2015 || ///
scatteri 22824.5 2015 ||, ///
leg(order(1 "进口" 2 "出口")) ///
text(20000 2005 "2015年""进口总额和出口""总额均下降") leg(off)|| 	///
pcarrowi 20000 2007 16807.9 2015, 				///
	leg(off) 							///
	lc(red*0.8) lw(*1.5) 				///
	mlw(*1.2) mfc(red*0.8) mc(red*0.8) || ///
pcarrowi 20000 2007 22824.5 2015, 				///
	leg(off) 							///
	lc(red*0.8) lw(*1.5) 				///
	mlw(*1.2) mfc(red*0.8) mc(red*0.8) ///
text(7000 2010 "2009年")
gre imex


* 汇率变化
* 调用美联储的数据需要预先设置好从FRED申请到的token，下面的是我的：
set fredkey ee68c644abe109ecaadaa3cfcf92ab41, permanently
import fred DEXCHUS, clear
format daten %tdCY/N/D
tw line DEXCHUS daten, ///
	xla(#8) yla(0(2)10) ///
	xti(日期) yti(人民币汇率) ///
	caption("注：美元标价法""上升表示人民币贬值，下降表示人民币贬值")
gre exrate

* 外汇储备（美元储备）
import fred TRESEGCNM052N, clear
replace TRESEGCNM052N = TRESEGCNM052N/1000000000000
format daten %tdCY/N/D
gen temp_date = daten
tw line TRESEGCNM052N daten, ///
	xla(#8) yla(0(0.5)4.5) ///
	xti(日期) yti(中国美元储备(万亿美元)) || ///
pcarrowi 4.0108337 16741 4.0108337 19875, ///
	leg(off) 							///
	lc(red*0.8) lw(*1.5) 				///
	mlw(*1.2) mfc(red*0.8) mc(red*0.8) ///
	text(4 14741 "2014年6月1日达""到最高点4.01万亿")
gre dollorreserve

* 出境人数
cuse tourism, clear 
tw line 国内居民出境总人数 年份 if 年份 > 1993, ///
	xla(1993(2)2015) ///
	yla(0(3000)15000) ///
	yti(国内居民出境总人数(万人次))
gre tourism

* 中美利差
clear all
rcall: setwd("~/Desktop"); library(messyr); df <- iborpro("SHIBOR-CNY-1W"); write.table(df, file = "shibor.csv", sep = ',', row.name = F) 
import delimited "~/Desktop/shibor.csv", encoding(utf8) clear varn(1)
erase shibor.csv
save shibor_temp, replace
gen date = date(日期, "YMD")
format date %tdCY-N-D
drop 日期 涨跌幅
ren 利率 shibor
save shibor, replace

import fred DFF, clear
ren daten date
format date %tdCY-N-D
drop datestr
merge 1:1 date using shibor
keep if _m == 3
drop _m

tw line shibor DFF date, leg(order(1 "1周SHIBOR" 2 "联邦基金利率") pos(2) ring(0)) xti(日期) yti(利率%) yla(0(2)14)
gre shiborvsDFF

* M2
clear all
rcall: setwd("~/Desktop");library(messyr); df <- get_money(); write.table(df, file = "money.csv", sep = ',', row.name = F)
import delimited "~/Desktop/money.csv", encoding(utf8) clear varn(1)
erase money.csv
gen date = date(数据日期, "YM")
keep date m2数量 m2同比 m2环比 
replace m2数量 = subinstr(m2数量, ",", "", .)
replace m2环比 = subinstr(m2环比, "%", "", .)
replace m2同比 = subinstr(m2同比, "%", "", .)
destring, replace force
format date %tdCY-N
order date
gen date_temp = date
replace m2数量 = m2数量/10000
tw line m2数量 date if date > 13118, ///
	xti("月份") yti("M2数量(万亿)") || ///
pcarrowi 100 16437 47.51666 17867, ///
	leg(off) ///
	lc(red*0.8) lw(*1.5) 				///
	mlw(*1.2) mfc(red*0.8) mc(red*0.8) ///
	text(120 15837 "2008年12月""M2总量为47.5万亿") || ///
pcarrowi 170 18167 139.2278 20423, ///
	leg(off) ///
	lc(red*0.8) lw(*1.5) 				///
	mlw(*1.2) mfc(red*0.8) mc(red*0.8) ///
	text(180 17167 "2015年12月""M2总量为139.2万亿") || ///
pci 47.51666 17867 47.51666 21867, ///
	lp(dash) lc(black)|| ///
pci 139.2278 20423 139.2278 21867, ///
	lp(dash) lc(black)|| ///
pcarrowi 47.51666 21467 80 21467, ///
	lp(solid) lc(black) mc(black)|| ///
pcarrowi 139.2278 21467 105 21467, ///
	lp(solid) lc(black) mc(black)||, ///
text(95 21067 "6年间M2增加193%！") 
gre m2

* M2增速
tw line m2同比 date if date > 13118 || ///
pcarrowi 29.74 16202 29.74 18202, ///
	leg(off) ///
	lc(red*0.8) lw(*1.5) 				///
	mlw(*1.2) mfc(red*0.8) mc(red*0.8) ///
	text(29.74 15202 "2009年11月""M2环比增速为29.74%") ||, ///
xti(月份) yti(M2环比增速(%))
gre m2rate

* M2/GDP
* 先要把月度数据转变成年度数据
gen month = month(date)
keep if month == 12
replace date = year(date)
format date %6.0f
keep date m2数量
save m2, replace
use GDP, clear
ren 数据日期 date
keep date gdp绝对额
replace gdp绝对额 = gdp绝对额 / 10000
merge 1:1 date using m2
keep if _m == 3
drop _m
drop if m2 == .
gen m2gdprate = m2/gdp
tw line m2gdprate date, ///
	xti(年份) yti(M2/GDP) ///
	xla(1990(3)2017) yla(0.8(0.2)2.2, format(%6.1f)) || ///
pcarrowi 1.2 2005 1.513051 2008, ///
	leg(off) ///
	lc(red*0.8) lw(*1.5) ///
	mlw(*1.2) mfc(red*0.8) mc(red*0.8) ///
	text(1.1 2003 "2008年M2/GDP""倍率为1.51") || ///
pcarrowi 2.027234 2005 2.027234 2017, ///
	leg(off) ///
	lc(red*0.8) lw(*1.5) ///
	mlw(*1.2) mfc(red*0.8) mc(red*0.8) ///
	text(2.027234 2003 "2017年M2/GDP""倍率为2.02")
gre m2gdprate

* 外商直接投资
clear all
rcall: setwd("~/Desktop");library(messyr); df <- get_fdi(); write.table(df, file = "fdi.csv", sep = ',', row.name = F)
import delimited "~/Desktop/fdi.csv", encoding(utf8) clear varn(1)
erase fdi.csv
keep 数据日期 当月实际使用外资亿美元 当月实际使用外资同比增减
gen date = date(数据日期, "YM")
gen fdi = subinstr(当月实际使用外资亿美元, ",", "", .)
gen fdirate = subinstr(当月实际使用外资同比增减, "%", "", .)
keep date fdi fdirate
destring, replace force
format date %tdCY-N
tw line fdi date, xti(月份) yti(当月实际使用外资(亿美元))
gre fdimonth

tw line fdirate date, xti(月份) yti(当月实际使用外资同比增减(%))
gre fdirate

gen year = year(date)
bysort year: egen fdiyear = total(fdi)
duplicates drop year, force
tw line fdiyear year, xti(年份) yti(当年实际使用外资(亿美元))
gre fdiyear

* 工资
cuse pjw, c
* 查看城市的数量
codebook 城市代码
* 计算各市按照全部职工年均人数的加权平均工资
* 需要安装一个计算加权平均的egen命令
* net install _gwtmean.pkg, from("http://fmwww.bc.edu/RePEc/bocode/_/")
keep 年度 全部职工年均人数 职工平均工资
bysort 年度标识: egen avgwage = wtmean(职工平均工资), weight(全部职工年均人数)
duplicates drop 年度标识, force
keep 年度标识 avgwage
tw line avgwage 年度标识, xti("年份") yti("299个城市的职工平均工资")
gre avgwage







