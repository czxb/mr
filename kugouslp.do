*! 查询并下载酷狗网站搜索结果
*! kugousearch 周杰伦
*! kugousearch 程振兴, d
*! kugousearch 程振兴, download
*! 需要的外部命令utrans, insheetjson, dict（percentencode）
cap prog drop kugousearch
prog def kugousearch
	version 13.0
	syntax anything [, Download]
	clear all
	qui{
		local keyword = "`anything'"
		percentencode `keyword'
		copy "http://songsearch.kugou.com/song_search_v2?callback=jQuery1124031407034218114016_1528575153677&keyword=`r(percentencode)'&page=1&pagesize=5&userid=-1&clientver=&platform=WebFilter&tag=em&filter=2&iscorrection=1&privilege_filter=0&_=1528575153679" temp.txt, replace
		utrans temp.txt
		infix strL v 1-20000 using temp.txt, clear
		split v, parse(({ [{ },{ }] }))
		sxpose, clear
		ren _var1 v
		drop if index(v, "SongName") == 0
		drop in 1
		gen name = ustrregexs(1) if ustrregexm(v, `""SongName":"(.*)","OwnerCount""')
		gen hash = ustrregexs(1) if ustrregexm(v, `""FileHash":"(.*)"?"')
		drop v
		replace name = subinstr(name, `"""', "", .)
		replace name = subinstr(name, `" "', "", .)
		replace name = subinstr(name, `"."', "", .)
		replace name = subinstr(name, `"\/"', "", .)
		replace hash = "http://www.kugou.com/song/#hash=" + hash
		save songlist, replace
		forval i = 2/4{
			copy "http://songsearch.kugou.com/song_search_v2?callback=jQuery1124031407034218114016_1528575153677&keyword=`r(percentencode)'&page=`page'&pagesize=5&userid=-1&clientver=&platform=WebFilter&tag=em&filter=2&iscorrection=1&privilege_filter=0&_=1528575153679" temp.txt, replace
			utrans temp.txt
			infix strL v 1-20000 using temp.txt, clear
			cap{
				split v, parse(({ [{ },{ }] }))
				sxpose, clear
				ren _var1 v
				drop if index(v, "SongName") == 0
				drop in 1
				gen name = ustrregexs(1) if ustrregexm(v, `""SongName":"(.*)","OwnerCount""')
				gen hash = ustrregexs(1) if ustrregexm(v, `""FileHash":"(.*)"?"')
				drop v
			}
			if _rc != 0{
				use songlist, clear
				save songlist, replace
				continue, break
			}
			cap{
				replace hash = "http://www.kugou.com/song/#hash=" + hash
			}
			append using songlist.dta
			save songlist, replace
		}
	}
	di "1. 搜索结果列表爬取完成！"
	di "2. 一共得到了`=_N'个搜索结果，下一步是获取音频下载链接，费时较长，请耐心等候。"
	qui{
		use songlist, clear
		replace hash = ustrregexs(1) if ustrregexm(hash, `"(.*)","SQPayType""')
		drop if length(hash) < 40
		drop if length(hash) > 80
		replace name = subinstr(name, `"""', "", .)
		replace name = subinstr(name, `" "', "", .)
		replace name = subinstr(name, `"."', "", .)
		replace name = subinstr(name, `"\/"', "", .)
		format name %10s
		format hash %40s
		replace hash = subinstr(hash, `"""', "", .)
		gen link = ""
		gen piclink = ""
		save songlist, replace
	}
		forval i = 1/`=_N'{
			use songlist, clear
			local rt = (`i'/`=_N')*100
			dis %6.0f "已完成`rt'%"
			local urlinput = hash[`i']
			qui{
				percentencode `urlinput'
				cap restore
				preserve
				!curl 'http://music.sonimei.cn/' -H 'Cookie: UM_distinctid=163e4e1af53935-0db2428d718a45-336c7706-fa000-163e4e1af55ce; CNZZDATA1256427037=272117870-1528551817-null%7C1528574133; __51cke__=; __tins__15406580=%7B%22sid%22%3A%201528578179373%2C%20%22vd%22%3A%202%2C%20%22expires%22%3A%201528580401283%7D; __51laig__=2' -H 'Origin: http://music.sonimei.cn' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'Referer: http://music.sonimei.cn/?url=`r(percentencode)'' -H 'X-Requested-With: XMLHttpRequest' -H 'Proxy-Connection: keep-alive' --data 'input=`r(percentencode)'&filter=url&type=_&page=1' --compressed -o temp.json
				clear 
				gen str200 url = ""
				gen str200 pic = ""
				cap{
					insheetjson url pic using temp.json, table(data) col(url pic)
					replace url = subinstr(url, "\", "", .)
					local url = url[1]
					replace pic = subinstr(pic, "\", "", .)
					local pic = pic[1]
					restore
					replace link = "`url'" in `i'
					replace piclink = "`pic'" in `i'
				}
			save songlist, replace
			}
		}
		qui save song_download_list, replace
		qui drop if link == ""
	di "3. 下载链接列表爬取完成！"
	qui{
		if "`download'" != ""{
			use song_download_list, clear
			drop if link == ""
			forval i = 1/`=_N'{
				copy "`=link[`i']'" "`=name[`i']'.mp3", replace
			}
		}
	}
end

kugousearch 银临
format hash %10s
format link %30s
format piclink %30s

cap file close myfile
file open myfile using temp.json, write replace
forval i = 1/`=_N'{
	file write myfile `"{% aplayer "`=name[`i']'" "`=link[`i']'"  "`=piclink[`i']'" %}"' _n
}
file close myfile
utrans temp.json
