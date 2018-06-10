*! 判断给定的关键词是否为酷狗收录的歌手
*! kugou 程振兴
*! kugou 周杰伦
cap prog drop kugou
prog def kugou, rclass
syntax anything
	qui{
		cap preserve
		clear all
		local name = "`anything'"
		percentencode "`name'"
		copy "http://so.service.kugou.com/get/complex?callback=jQuery112405110215310589978_1528549487656&word=`r(percentencode)'&_=1528549487659" temp.txt, replace
		utrans temp.txt
		set obs 1
		gen v = fileread("temp.txt")
		split v, parse(,)
		sxpose, clear
		ren _var1 v
		drop in 1
		keep if index(v, "singerid")
		cap keep in 1
	}
	if _rc == 198{
		di in red "未发现名为`name'的歌手！"
	}
	else{
		qui replace v = subinstr(v, `""singerid":"', "", .)
		local singerid = v[1]
		di "歌手`name'的id为`singerid'"
		di `"`name'的酷狗主页网址为{bf:{browse "http://www.kugou.com/singer/`singerid'.html": `name'的酷狗主页}}"'
		ret local singerid "www.kugou.com/singer/`singerid'"
	}
end
