*! 跟据学号查询该学生所在班级的成绩单并打印出该同学的绩点和排名
*! 注意由于cookies的实效性，这个命令可能需要重新调整curl部分才能运行，而且这个命令需要等待较长的时间。
*! 示例：cjdquery 2015050001
cap prog drop cjdquery
prog def cjdquery
	version 13.0
	syntax anything
	clear all
	qui !curl 'https://sis.jnu.edu.cn/sis/Cjcx/Cjcx.action?method=getKhtxcjStuOfListByKhlx' -H 'workitemid: null' -H 'Origin: https://sis.jnu.edu.cn' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8' -H 'render: unieap' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36' -H 'ajaxRequest: true' -H 'Content-Type: multipart/form-data' -H 'Accept: */*' -H 'Referer: https://sis.jnu.edu.cn/sis/forward.action?path=/sis/kh/khcjcx/tbtxcx.jsp?khlx=1' -H 'resourceid: null' -H 'Cookie: JSESSIONID=Jn7yblmWlBDn2b7zGgPJDJl4hS3f1GGhyLbTTjnylhWWz4hjrvp3!1853759784' -H 'Connection: keep-alive' --data-binary '{header:{"code": -100, "message": {"title": "", "detail": ""}},body:{dataStores:{khtxStuDetailStore:{rowSet:{"primary":[],"filter":[],"delete":[]},name:"khtxStuDetailStore",pageNumber:1,pageSize:200,recordCount:0,rowSetName:"pojo_com.neusoft.education.sis.model.zzgl.kh.khcjcx.KhcjcxStuModel",order:"c.khtxmc,b.yxsh,b.zyh,b.nj,b.bh,b.xh,a.khcj"}},parameters:{"args": ["1", "`anything'"]}}}' --compressed -o temp.txt
	qui{
		clear
		set obs 1
		gen v = fileread("temp.txt")
		split v, parse("},{" "primary:[")
		drop v v1
		sxpose, clear
		ren _var1 v
		replace v =subinstr(v, "]}}}}}", "", .)
		replace v = subinstr(v, `"""', "", .)
		replace v = subinstr(v, `"{"', "", .)
		replace v = subinstr(v, `"}"', "", .)
		split v, parse(,)
		foreach i of varlist _all{
			replace `i' = ustrregexs(1) if ustrregexm(`i', ":(.*)")
			replace `i' = subinstr(`i', "\", "", .)
		}
		compress
		keep v6 v7 v10 v16 v17 v18
		ren v6 学号
		ren v7 姓名
		ren v10 年度
		ren v16 绩点
		ren v17 班级排名
		ren v18 专业排名
		destring, replace
		format 学号 %12.0f
	}
	forval i = 1/`=_N'{
		if 学号[`i'] == `anything'{
			local name = "`=姓名[`i']'"
			display in green "年度：" in red "`=年度[`i']'"
			display in green "姓名：" in red "`=姓名[`i']'"
			display in green "学号：" in red "`=学号[`i']'"
			display in green "班级排名：" in red "`=班级排名[`i']'"
			display in green "专业排名：" in red "`=专业排名[`i']'"
			display in yellow "------------------------------"
		}
	}
	save `name'_成绩单, replace
end



