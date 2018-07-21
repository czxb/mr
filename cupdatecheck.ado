*!cupdateCheck
*!version 0.0.0.9000
*!程振兴
*!中国广州·暨南大学经济学院
*!功能：Stata更新检查
*!https://www.stata.com/support/updates/stata14/stata14update_win.zip
*!https://www.stata.com/support/updates/stata14/stata14update_mac.zip
prog drop _all
prog define cupdatecheck
	if "`path'" ~= "" {
		capture mkdir `path'
		cd `path'
	} 
	else {
		local path `c(pwd)'
	}
	update
	qui{
		local version = int(c(stata_version))
		copy "https://www.stata.com/support/updates/stata`version'.html" temp.txt, replace
		cap unicode encoding set gb18030
		cap unicode translate temp.txt
		cap unicode erasebackups, badidea
		infix strL v 1-20000 using temp.txt, clear
		keep if index(v, "date earlier than")
		replace v = ustrregexs(1) if ustrregexm(v, `"\"(.*)\""')
		local date = v[1]
	}
	di as text "{bf: 1.} 最近版本更新发布时间为: {bf: `date'}"
	di as yellow `"{bf: 2.} 你也可以从{bf:{browse "https://www.stata.com/support/updates/stata`version'.html": Stata官网}}上下载离线更新版解压后运行{stata db update:db update}然后选择解压后的文件夹进行更新。"'
	di as red "{bf: 3.} {stata cupdate install:你也可以点击这里直接进行更新。}"
	cap erase temp.txt
	clear
end







