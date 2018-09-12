*! Stata调用百度API
*! 程振兴 2018年9月12日
*! APPID和key可以从在百度翻译开放平台申请，网址：http://api.fanyi.baidu.com/api/trans/product/index
*! 【用法】：
*! 		bdtrans string, [From(string) To(string) APPID(string) KEY(string)]
*! 【选项】：
*! 	From: 翻译源语言，默认为auto
*! 	to: 译文语言，默认为auto
*! 	APPID: APP ID，默认为我自己的
*! 	KEY: 百度密钥，默认为我自己的
*! 【示例】：
*! 	bdtrans 你好
*! 	bdtrans 你好 苹果
cap prog drop bdtrans
prog def bdtrans
	syntax anything, [From(string) To(string) APPID(string) KEY(string)]
	tokenize `anything'
	local num = wordcount("`anything'")
	cap preserve
	qui di "`num'"
	forval word = 1/`num'{
		local input = "``word''"
		qui percentencode `input'
		local q = "`r(percentencode)'"
		if "`from'" == "" local from = "auto"
		if "`to'" == "" local to = "auto"
		local salt = "string(int(runiform()*1000000))"
		if "`appid'" == "" local appid = "20171205000102469"
		if "`key'" == "" local key = "8PHPDzkGMr_kWd5rIhRc"
		qui{
			encryption `appid'`q'`salt'`key'
			local sign = "`r(encryption)'"
			di "`sign'"
			!curl 'http://api.fanyi.baidu.com/api/trans/vip/translate?q=`q'&from=`from'&to=`to'&appid=`appid'&salt=`salt'&sign=`sign'' --compressed -o temp.txt
			infix strL v 1-20000 using temp.txt, clear
			gen dst = ustrregexs(1) if ustrregexm(v, `""dst":"(.*)""')
		}
		qui if index(dst, "\u") replace dst = ustrunescape(dst)
		di in green "``word'': " in yellow "`=dst[1]'"
		erase temp.txt
	}
end
