*! 微信推文图片下载
*! 程振兴 2018年6月15日
*! 用法：downpic urls, Ignore(string) Path(string)
*! 			urls: 表示一个链接或者用空格分隔的多条链接；
*! 			ignore(string): 选择项忽略某种格式的图片，可以缩写为i；
*! 			path(string): 选择下载文件夹，如果没有会被自动创建，可以缩写为p。
*! 用法示例：
*! downpic `"https://mp.weixin.qq.com/s?__biz=MjM5MzIyODY1NA==&mid=2653889621&idx=1&sn=b513d479b5b132d7b2b832ff8c286c65&chksm=bd41b6548a363f427affabf983fd0a69db2122d28336e6cd2018def97839a089b5ebd9bb6841&scene=0#rd"' `"https://mp.weixin.qq.com/s?__biz=MzA5NjIzNjgxNw==&mid=2653071676&idx=5&sn=81cc83ae876b5012027086f46974d63a&chksm=8b652d42bc12a45412303e83813a8011b76b216429a7ddaf5678b3d305deb8259d9367fa4e83&mpshare=1&scene=1&srcid=06148NGZ2TXpPnSmkmQ9ynCc#rd"'
*! downpic `"https://mp.weixin.qq.com/s?__biz=MjM5MzIyODY1NA==&mid=2653889621&idx=1&sn=b513d479b5b132d7b2b832ff8c286c65&chksm=bd41b6548a363f427affabf983fd0a69db2122d28336e6cd2018def97839a089b5ebd9bb6841&scene=0#rd"' 
*! downpic `"https://mp.weixin.qq.com/s?__biz=MzA5NjIzNjgxNw==&mid=2653071676&idx=5&sn=81cc83ae876b5012027086f46974d63a&chksm=8b652d42bc12a45412303e83813a8011b76b216429a7ddaf5678b3d305deb8259d9367fa4e83&mpshare=1&scene=1&srcid=06148NGZ2TXpPnSmkmQ9ynCc#rd"'
prog drop _all
prog define downpic
	version 14.0
	syntax anything(name = urls),[ Path(string) Ignore(string)]
	clear all
	if index("`path'", " "){
		local path = subinstr("`path'", " ", "_")
		cap mkdir `path'
	}
	if "`path'" != ""{
		cap mkdir `path'
	}
	if "`path'" != ""{
		local path = "`c(pwd)'"
		di "你当前的工作目录为`path'。"
	}
	local m = 1
	foreach name in `urls'{
		qui{
			cap copy "`name'" temp.txt, replace
			cap unicode encoding set gb18030
			cap unicode translate temp.txt
			cap unicode erasebackups, badidea
			infix strL v 1-20000 using temp.txt, clear
			keep if index(v, "https") & (index(v, "png") | index(v, "jpeg") | index(v, "jpg") | index(v, "gif") | index(v, "bmp") | index(v, "svg") | index(v, "eps") | index(v, "PNG") | index(v, "JPEG") | index(v, "JPG") | index(v, "GIF") | index(v, "BMP") | index(v, "SVG") | index(v, "EPS") | index(v, "gph"))
			if index(v, `"'http"'){
				split v, parse(`"'"')
			}
			else{
				split v, parse(`"""')
			}
			drop v
			set obs 1000
			gen v = ""
			local i = 1
			foreach v of varlist _all{
				replace v = `v'[1] if _n == `i'
				local i = `i' + 1
			}
			keep v
			keep if (index(v, `"http"')&(index(v, "png")|index(v, "jpeg")|index(v, "jpg")|index(v, "gif")|index(v, "bmp")|index(v, "svg")|index(v, "eps")|index(v, "PNG")|index(v, "JPEG")|index(v, "JPG")|index(v, "GIF")|index(v, "BMP")|index(v, "SVG")|index(v, "EPS")|index(v, "gph")))
			
			forvalue i = 1/`=_N'{
				local a = v[`i']
				if index(v[`i'], "="){
					replace v = subinstr(v, "=", ".", .)
				}
				compress
				local b = length(v[`i'])
				local c = substr(v[`i'], `b'-6, `b')
				local temp = v[`i']
				cap copy "`a'" "`m'_`i'_`c'", replace
			}
		}
		local m = `m' + 1
	}
	cap erase temp.txt
end
