*! 0.0.0.9000 程振兴 2018年1月19日
*! 查询中文姓氏的各种拼音拼法
prog drop _all
prog define cname
	version 14.0
	syntax anything(name = query), [Split]
	foreach word in `query'{
		qui{
			clear all
			percentencode `word'
			local query = lower(r(percentencode))
			copy "https://www.chineseinhi.com/index3.php?option=com_lastname&task=key&key=`query'" temp.txt, replace
			unicode encoding set gb18030
			cap unicode translate temp.txt
			cap unicode erasebackups, badidea
			infix strL v 1-20000 using temp.txt, clear
			keep if index(v, "<tr><td>")
			split v, parse(</a></td><td> <tr><td> </a></td>)
			sxpose, clear
			rename _var1 v
			drop in 1
			replace v = subinstr(v, "<td>", "", .)
			replace v = ustrregexs(0) if ustrregexm(v, "[\u4e00-\u9fa5]+")
			replace v = ustrregexs(1) if ustrregexm(v, ">(.*)")
			split v, parse(</a> </a></td>)
			drop v
			foreach i of varlist _all{
				replace `i' = subinstr(`i', "<br/>", "", .)
				replace `i' = ustrregexs(1) if ustrregexm(`i', ">(.*)")
			}
			foreach i of varlist _all{
				if "`i'" != "v1" replace v1 = v1 + " " + `i'
			}
			drop in 1
			drop in -1
		}
		di as text "【中文】：" v1[1]
		di as text "【大陆拼法】：" v1[2]
		di as text "【台湾拼法】：" v1[3]
		di as text "【香港拼法】：" v1[4]
		di as text "【澳门拼法】：" v1[5]
		di as text "【新加坡拼法】：" v1[6]
		di as text "【韩国拼法】：" v1[7]
		di as text "【马来西亚拼法】：" v1[8]
		if "`split'" != ""{
			di as yellow "----------------------------------------------------------"
		}
	}
	erase temp.txt
end
