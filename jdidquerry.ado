*! 根据提供的学号爬取该学号主人的基本身份信息
*! 程振兴 2018年6月14日
*! query 2015050001
cap prog drop jdidquery
prog def jdidquery, rclass
	version 13.0
	syntax anything
	cap preserve
	clear all
	qui{
		!curl 'https://tzcs.jnu.edu.cn/student/studentInfo.jsp?userName=`anything'&passwd=`anything'' -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Referer: https://tzcs.jnu.edu.cn/servlet/adminservlet' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8' -H 'Cookie: JSESSIONID=FF7B49D8294B8C001478F2446518C0F4' --compressed -o temp.txt
		infix strL v 1-2000 using temp.txt, clear
		keep if index(v, "&nbsp;")
		replace v = ustrregexs(1) if ustrregexm(v, "&nbsp;(.*)<")
		replace v = ustrregexs(1) if ustrregexm(v, "&nbsp;(.*)&nbsp;")
		replace v = subinstr(v, "&nbsp;", "", . )
		replace v = subinstr(v, `"<td bgcolor="#FFFFFF">"', "", . )
		replace v = subinstr(v, `" "', "", . )
		drop if v == ""
		ret local 学号 = v[2]
		ret local 姓名 = v[4]
		ret local 性别 = v[6]
		ret local 身份证号 = v[8]
		ret local 民族 = v[10]
		ret local 年级 = v[12]
		ret local 行政班级 = v[14]
	}
	di in green "学号:" in red "`=v[2]'"
	di in green "姓名:" in red "`=v[4]'"
	di in green "性别:" in red "`=v[6]'"
	di in green "身份证号:" in red "`=v[8]'"
	di in green "民族:" in red "`=v[10]'"
	di in green "年级:" in red "`=v[12]'"
	di in green "行政班级:" in red "`=v[14]'"
	clear 
end