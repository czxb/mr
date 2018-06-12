clear all
!curl -H 'Host: kmr.service.kugou.com' -H 'Content-Type: application/json' -H 'Cookie: KuGoo=KugooID=978183797&KugooPwd=64A545DAD7901B87DDA7CAAB8C543B8E&NickName=%u0048%u0065%u0074%u0065%u0072%u006f%u0073%u006b%u0065%u0064%u0061%u0073%u0074%u0069%u0063%u0069%u0074%u0079&Pic=http://imge.kugou.com/kugouicon/165/20161130/20161130172325344744.jpg&RegState=1&RegFrom=WEIXIN&t=e09e2563ce3b6dd1ab241213e28c19df7508d708a1d7923520cec4d40a44632c&a_id=1155&ct=1528731147&UserName=%u006b%u0067%u006f%u0070%u0065%u006e%u0039%u0037%u0038%u0031%u0038%u0033%u0037%u0039%u0037&t1=; kg_mid=6a496367090cfcc3f6d6ab73809b5a9c' -H 'Accept: */*' -H 'User-Agent: KugouMusic/2.6.1 (Mac OS X ban ben 10.13.4(ban hao 17E202))' -H 'Accept-Language: zh-Hans-CN;q=1, en-CN;q=0.9' --data-binary '{"clienttime":1528787597895,"author_id":"3520","mid":"7f24358ad3591e449129a4ef58668e09","sort":2,"clientver":261,"pagesize":606,"area_code":"all","key":"972197755efb7824eaad81031770d482","page":1,"appid":1155}' --compressed 'http://kmr.service.kugou.com/container/v1/audio_group/author' -o temp.txt
* 手动断行处理
utrans temp.txt
infix strL v 1-20000 using temp.txt, clear
gen name = ustrregexs(1) if ustrregexm(v, `""audio_name":"(.*)","video_timelength""')
gen hash = ustrregexs(1) if ustrregexm(v, `""hash":"(.*)","hash_320""')
drop if missing(name) | missing(hash)
drop v
replace name = subinstr(name, `"""', "", .)
replace name = subinstr(name, `" "', "", .)
replace name = subinstr(name, `"."', "", .)
replace name = subinstr(name, `"\/"', "", .)
format name %10s
format hash %40s

* 以告白气球为例，根据hash值寻找下载链接：
replace hash = "http://www.kugou.com/song/#hash=" + hash
keep in 6
gen link = ""
gen piclink = ""
local urlinput = hash[1]
percentencode `urlinput'
cap restore
preserve
!curl 'http://music.sonimei.cn/' -H 'Cookie: UM_distinctid=163e4e1af53935-0db2428d718a45-336c7706-fa000-163e4e1af55ce; CNZZDATA1256427037=272117870-1528551817-null%7C1528574133; __51cke__=; __tins__15406580=%7B%22sid%22%3A%201528578179373%2C%20%22vd%22%3A%202%2C%20%22expires%22%3A%201528580401283%7D; __51laig__=2' -H 'Origin: http://music.sonimei.cn' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'Referer: http://music.sonimei.cn/?url=`r(percentencode)'' -H 'X-Requested-With: XMLHttpRequest' -H 'Proxy-Connection: keep-alive' --data 'input=`r(percentencode)'&filter=url&type=_&page=1' --compressed -o temp.json
clear 
gen str200 url = ""
gen str200 pic = ""
insheetjson url pic using temp.json, table(data) col(url pic)
replace url = subinstr(url, "\", "", .)
local url = url[1]
replace pic = subinstr(pic, "\", "", .)
local pic = pic[1]
restore
replace link = "`url'"
replace piclink = "`pic'"
sxpose, clear
