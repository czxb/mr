*! 把工作目录快速的设置为桌面或其子文件夹
*! 程振兴 2018年7月13日
*! cpd /
*! cap mkdir temp
*! cpd temp
cap prog drop cpd
prog define cpd
	version 14.0
	syntax anything
	if "`anything'" == "/"{
		cd "~/Desktop"
		di as yellow "已经将桌面设置为工作目录！"
	}
	else{
		cd "~/Desktop/`anything'"
		di as yellow "已经将~/Desktop/`anything'设置为工作目录！"	
	}
end
