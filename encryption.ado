*! 字符串加密
*! 程振兴 2018年9月12日
*! 该命令是使用 https://tool.lu/ 网站提供的借口进行字符串加密和解密的。
*! 【用法】：
*! 	encryption string, [PATtern(string)]
*! string是要加密的字符串。
*! 【选项】：
*! 	pattern：选择加密模式，默认为md5，除此之外还可以选择：
*!		+ base64_encode
*!		+ base64_decode
*!		+ urlencode
*!		+ urldecode
*!		+ addslashes
*!		+ stripslashes
*!		+ md5
*! 【返回值】：
*! 加密得到的字符串会被存入返回值中，运行ret list可以看到。
*! 【示例】
*!		* 默认使用MD5加密
*!		encryption 你好
*!		* base64_encode
*!		encryption 你好, pat(base64_encode)
*!		* base64_decode，注意返回的是unicode码
*!		encryption 5L2g5aW9, pat(base64_decode)
*!		* urlencode
*!		encryption 你好, pat(urlencode)
*!		* urldecode，注意返回的是unicode码
*!		encryption %E4%BD%A0%E5%A5%BD, pat(urldecode)
*!		* addslashes
*!		encryption 你好, pat(addslashes)
*!		* stripslashes
*!		encryption 你好, pat(stripslashes)
*!		* MD5:默认值
*!		encryption 你好, pat(md5)
cap prog drop encryption
prog def encryption, rclass
	syntax anything [, PATtern(string)]
	cap preserve
	qui{
		if "`pattern'" == "" local pattern = "md5"
		!curl 'https://tool.lu/encdec/ajax.html' --data 'code=`anything'&operate=`pattern'' --compressed -o temp.txt
		infix strL v 1-20000 using temp.txt, clear
		erase temp.txt
		gen encryption = ustrregexs(1) if ustrregexm(v, `""text":"(.*)""')
		if index(encryption, "\u") replace encryption = ustrunescape(encryption)
	}
		di in green "`pattern'：" in yellow "`=encryption[1]'"
		ret local encryption = encryption[1]
end
