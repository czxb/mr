*! 程振兴 2018年6月12日：根据姓名学号查询图书馆数据
*! 用法：libdata 姓名 学号 [, use(1/2/3) save(111)]
*! 例如：libdata 程振兴 2015050024
*! 选项： 
*! 		use(num)：该命令会下载三个数据文件，分别是图书馆数据、借阅列表和推荐列表
*! 				如果该同学没有借过书，只能显示基本的数据，不会产生数据文件
*! 				use(1)表示最终会打开图书馆数据文件
*! 				use(2)表示最终会打开借阅列表
*! 				use(3)表示最终会打开推荐列表
*! 		save(num+num+num)：该命令用于选择保存的数据文件
*! 				111：表示三个文件都保存
*! 				100：只保存第一个文件
*! 				101：不保存第二个文件
*! 				······
*! 返回值：ret list
*! 			返回值中有基本数据的局部宏
*! 有问题欢迎mailto: czx@czxa.top
cap prog drop libdata
prog define libdata, rclass
version 14.0
	syntax anything [, Use(string) Save(string)]
	if "`use'" == "" local use = 1
	clear all
	tokenize `anything'
	local name = "`1'"
	local id = "`2'"
	if "`save'" == "" local save = "111"
	tokenize `save'
	local save1 = "`1'"
	local save2 = "`2'"
	local save3 = "`3'"
	qui{
		percentencode `name'
		copy "http://119.23.200.141:7782/Track/track_ifc_Info_JNU_GetData.ashx?userid=`id'&username=`r(percentencode)'&datatype=byj&y=14&x=jQuery17201800964343785949_1528732453437&_=1528732453466" temp.txt, replace
		cap unicode encoding set gb18030
		cap unicode translate temp.txt, transutf8
		cap unicode erasebackups, badidea
		clear
		set obs 1
		gen v = ""
		replace v = fileread("temp.txt")
		split v, parse([ ])
		drop v
		sxpose, clear
		format _var1 %100s
	}
	if `=_N' < 4{
		gen firstGateEnterTime = ustrregexs(1) if ustrregexm(_var1, `"firstGateEnterTime":(.*),"totalGateEnterTimes""')
		local time = firstGateEnterTime[1]
		local time = `time' + tc(1 jan 1970 08:00:00)
		qui replace firstGateEnterTime = "`date'" in 1
		qui replace firstGateEnterTime = string(`time', "%tCCCYY-NN-DD_HH:MM:SS") in 1
		gen totalGateEnterTimes = ustrregexs(1) if ustrregexm(_var1, `"totalGateEnterTimes":(.*),"gateEnterTimesRankingInDept""')
		gen gateEnterTimesRankingInDept = ustrregexs(1) if ustrregexm(_var1, `"gateEnterTimesRankingInDept":(.*),"preferredGateEnterTimePeriod""')
		gen preferredGateEnterTimePeriod = ustrregexs(1) if ustrregexm(_var1, `"preferredGateEnterTimePeriod":"(.*)","tlkjReservedTimes""')
		gen tlkjReservedTimes = ustrregexs(1) if ustrregexm(_var1, `"tlkjReservedTimes":(.*),"hzwReservedTimes""')
		gen hzwReservedTimes = ustrregexs(1) if ustrregexm(_var1, `"hzwReservedTimes":(.*),"chzfReservedTimes""')
		gen ldtReservedTimes = ustrregexs(1) if ustrregexm(_var1, `"ldtReservedTimes":(.*),"firstBorrowedBookTitle""')
		gen firstBorrowedBookTitle = ustrregexs(1) if ustrregexm(_var1, `"firstBorrowedBookTitle":(.*),"totalBorrowedBookNum""')
		gen totalBorrowedBookNum = ustrregexs(1) if ustrregexm(_var1, `"totalBorrowedBookNum":(.*),"totalRenewedBookNum""')
		gen totalRenewedBookNum = ustrregexs(1) if ustrregexm(_var1, `"totalRenewedBookNum":(.*),"totalHoldBookNum""')
		gen totalHoldBookNum = ustrregexs(1) if ustrregexm(_var1, `"totalHoldBookNum":(.*),"totalEBookReaderBorrowedTimes""')
		gen totalEBookReaderBorrowedTimes = ustrregexs(1) if ustrregexm(_var1, `"totalEBookReaderBorrowedTimes":(.*),"bookBorrowNumRankingInDept""')
		gen bookBorrowNumRankingInDept = ustrregexs(1) if ustrregexm(_var1, `"bookBorrowNumRankingInDept":(.*),"preferredBookBorrowTimePeriod""')
		gen preferredBookBorrowTimePeriod = ustrregexs(1) if ustrregexm(_var1, `"preferredBookBorrowTimePeriod":(.*),"myBorrowedBookList""')
		drop _var1
		di in green "第一次进馆时间是" in red "`=firstGateEnterTime[1]'"
		di in green "总进馆" in red "`=totalGateEnterTimes[1]'次"
		di in green "进馆次数全院排名" in red "`=gateEnterTimesRankingInDept[1]'"
		di in green "最喜欢进馆的时间" in red "`=preferredGateEnterTimePeriod[1]'"
		di in green "预约个人研修室" in red "`=tlkjReservedTimes[1]'次"
		di in green "预约学术研修室" in red "`=hzwReservedTimes[1]'次"
		di in green "预约朗读亭" in red "`=ldtReservedTimes[1]'次"
		di in green "第一次借阅的图书" in red "《`=firstBorrowedBookTitle[1]'》"
		di in green "总借阅图书的数量" in red "`=totalBorrowedBookNum[1]'"
		di in green "续借图书的数量" in red "`=totalRenewedBookNum[1]'"
		di in green "总预约图书的数量" in red "`=totalHoldBookNum[1]'"
		di in green "借阅kindle的次数" in red "`=totalEBookReaderBorrowedTimes[1]'"
		di in green "借书数量全院排名" in red "`=bookBorrowNumRankingInDept[1]'"
		di in green "最喜欢借书的时间" in red "`=preferredBookBorrowTimePerio[1]'"
		ret local 第一次进馆时间 = firstGateEnterTime[1]
		ret local 总进馆次数 = totalGateEnterTimes[1]
		ret local 进馆次数全院排名 = gateEnterTimesRankingInDept[1]
		ret local 最喜欢进馆的时间 = preferredGateEnterTimePeriod[1]
		ret local 预约个人研修室 = tlkjReservedTimes[1]
		ret local 预约学术研修室 = hzwReservedTimes[1]
		ret local 预约朗读亭次数 = ldtReservedTimes[1]
		ret local 第一次借阅的图书 = firstBorrowedBookTitle[1]
		ret local 总借阅图书的数量 = totalBorrowedBookNum[1]
		ret local 续借图书的数量 = totalRenewedBookNum[1]
		ret local 总预约图书的数量 = totalHoldBookNum[1]
		ret local 借阅kindle的次数 = totalEBookReaderBorrowedTimes[1]
		ret local 借书数量全院排名 = bookBorrowNumRankingInDept[1]
		ret local 最喜欢借书的时间 = preferredBookBorrowTimePerio[1]
		clear
	}
	else{
		qui{
			* 借阅列表
			keep in 2
			ren _var1 v
			split v, parse("},{")
			drop v
			sxpose, clear
			ren _var1 v
			replace v = subinstr(v, "{", "", .)
			replace v = subinstr(v, "}", "", .)
			split v, parse(,)
			drop v
			replace v1 = subinstr(v1, `""bookTitle":""', "", .)
			replace v1 = subinstr(v1, `"""', "", .)
			format v1 %20s
			ren v1 书名
			replace v2 = subinstr(v2, `""callNumber":""', "", .)
			replace v2 = subinstr(v2, `"""', "", .)
			format v2 %20s
			ren v2 编号
			label var 编号 "在图书馆可以用这个编号找到书"
			replace v3 = subinstr(v3, `""bookAuthor":""', "", .)
			replace v3 = subinstr(v3, `"""', "", .)
			format v3 %10s
			ren v3 作者
			replace v4 = subinstr(v4, `""bookClass":"', "", .)
			replace v4 = subinstr(v4, `"""', "", .)
			format v4 %10s
			ren v4 类别
			replace v5 = subinstr(v5, `""bookIsbn":"', "", .)
			replace v5 = subinstr(v5, `"""', "", .)
			format v5 %15s
			ren v5 ISBN 
			replace v6 = subinstr(v6, `""checkTimes":"', "", .)
			format v6 %10s
			ren v6 检查次数
			label data "`name'的借阅列表"
			if "`save2'" == "1" save "`name'的借阅列表", replace
			* 推荐购书列表
			clear
			set obs 1
			gen v = ""
			replace v = fileread("temp.txt")
			split v, parse([ ])
			drop v
			sxpose, clear
			keep in 4
			ren _var1 v
			split v, parse("},{")
			drop v
			sxpose, clear
			ren _var1 v
			replace v = subinstr(v, "{", "", .)
			replace v = subinstr(v, "}", "", .)
			split v, parse(,)
			drop v
			replace v1 = subinstr(v1, `""bookTitle":""', "", .)
			replace v1 = subinstr(v1, `"""', "", .)
			format v1 %20s
			ren v1 书名
			replace v2 = subinstr(v2, `""callNumber":""', "", .)
			replace v2 = subinstr(v2, `"""', "", .)
			format v2 %20s
			ren v2 编号
			label var 编号 "在图书馆可以用这个编号找到书"
			replace v3 = subinstr(v3, `""bookAuthor":""', "", .)
			replace v3 = subinstr(v3, `"""', "", .)
			format v3 %10s
			ren v3 作者
			replace v4 = subinstr(v4, `""bookClass":"', "", .)
			replace v4 = subinstr(v4, `"""', "", .)
			format v4 %10s
			ren v4 类别
			replace v5 = subinstr(v5, `""bookIsbn":"', "", .)
			replace v5 = subinstr(v5, `"""', "", .)
			format v5 %15s
			ren v5 ISBN 
			replace v6 = subinstr(v6, `""checkTimes":"', "", .)
			format v6 %10s
			ren v6 检查次数
			label data "`name'的推荐列表"
			if "`save3'" == "1" save "`name'的推荐列表", replace
			* 第三个是其他的信息
			clear
			set obs 1
			gen v = ""
			replace v = fileread("temp.txt")
			split v, parse([ ])
			drop v
			sxpose, clear
			keep in 1
			ren _var1 v
			split v, parse(,)
			drop v v1 v2
			sxpose, clear
			ren _var1 v
			drop if index(v, "null")
			drop if index(v, "myBorrowedBookList")
			replace v = subinstr(v, `""objdata":{""', "", .)
			split v, parse(`"":"')
			drop v
			replace v1 = "第一次进馆时间" if index(v1, "firstGateEnterTime")
			replace v1 = "总进馆次数" if index(v1, "totalGateEnterTimes")
			replace v1 = "进馆次数在全院的排名" if index(v1, "gateEnterTimesRankingInDept")
			replace v1 = "最喜欢进馆的时间" if index(v1, "preferredGateEnterTimePeriod")
			replace v1 = "预约个人研修室次数" if index(v1, "tlkjReservedTimes")
			replace v1 = "预约学术研修室次数" if index(v1, "hzwReservedTimes")
			replace v1 = "预约朗读亭次数" if index(v1, "ldtReservedTimes")
			replace v1 = "第一次借阅的图书" if index(v1, "firstBorrowedBookTitle")
			replace v1 = "总共借阅图书的数量" if index(v1, "totalBorrowedBookNum")
			replace v1 = "续借图书的数量" if index(v1, "totalRenewedBookNum")
			replace v1 = "总共预约图书的数量" if index(v1, "totalHoldBookNum")
			replace v1 = "借阅电子阅读器的次数" if index(v1, "totalEBookReaderBorrowedTimes")
			replace v1 = "借书数量在全院的排名" if index(v1, "bookBorrowNumRankingInDept")
			replace v1 = "最喜欢借书的时间" if index(v1, "preferredBookBorrowTimePeriod")
			drop if index(v1, "ReservedTimes")
			replace v2 = subinstr(v2, `"""', "", .)
			format v1 %-20s
			ren v1 item
			format v2 %-20s
			ren v2 score
			* 最后再把时间戳变成时间
			local time = score[1]
			local time = `time' + tc(1 jan 1970 08:00:00)
			replace score = "`date'" if item == "第一次进馆时间"
			replace score = string(`time', "%tCCCYY-NN-DD_HH:MM:SS") in 1
			if "`save1'" == "1" save "`name'的图书馆数据", replace
			ret local 第一次进馆时间 =	"`=score[1]'"
			ret local 总进馆次数 = `=score[2]'
			ret local 进馆次数全院排名 = `=score[3]'
			ret local 最喜欢进馆的时间 = "`=score[4]'"
			ret local 预约个人研修室 = `=score[5]'
			ret local 预约学术研修室 = `=score[6]'
			ret local 预约朗读亭次数 = `=score[7]'
			ret local 第一次借阅的图书 = "`=score[8]'"
			ret local 总借阅图书的数量 = `=score[9]'
			ret local 续借图书的数量 = `=score[10]'
			ret local 总预约图书的数量 = `=score[11]'
			ret local 借阅kindle的次数 = `=score[12]'
			ret local 借书数量全院排名 = `=score[13]'
			ret local 最喜欢借书的时间 = "`=score[14]'"
		}
		if "`use'" == "1" {
			use "`name'的图书馆数据", clear
		}
		if "`use'" == "2" {
			use "`name'的借阅列表", clear
		}
		if "`use'" == "3" {
			use "`name'的推荐列表", clear
		}
		di in green "第一次进馆时间是" in red "`=score[1]'"
		di in green "总进馆" in red "`=score[2]'次"
		di in green "进馆次数全院排名" in red "`=score[3]'"
		di in green "最喜欢进馆的时间" in red "`=score[4]'"
		di in green "预约个人研修室" in red "`=score[5]'次"
		di in green "预约学术研修室" in red "`=score[6]'次"
		di in green "预约朗读亭" in red "`=score[7]'次"
		di in green "第一次借阅的图书" in red "《`=score[8]'》"
		di in green "总借阅图书的数量" in red "`=score[9]'"
		di in green "续借图书的数量" in red "`=score[10]'"
		di in green "总预约图书的数量" in red "`=score[11]'"
		di in green "借阅kindle的次数" in red "`=score[12]'"
		di in green "借书数量全院排名" in red "`=score[13]'"
		di in green "最喜欢借书的时间" in red "`=score[14]'"
		qui cap erase temp.txt
	}
end 

