ctbc2
local num = `=_N' - 1
tostring _all, replace
destring date, replace
format date %tdCY-N-D
gen datestr = string(date, "%tdCY-N-D")
drop date
order datestr
foreach i of varlist _all{
	replace `i' = "NaN" if `i' == "."
}
fw, s h(收益率曲面)
lib, b s(dark)
fw "var matrix = ["
forval i = 1/`=_N'{
	fw `"[ `=rate0d[`i']', `=rate1m[`i']', `=rate2m[`i']', `=rate3m[`i']', `=rate6m[`i']', `=rate9m[`i']', `=rate1y[`i']', `=rate2y[`i']', `=rate3y[`i']', `=rate4y[`i']', `=rate5y[`i']', `=rate6y[`i']', `=rate7y[`i']', `=rate8y[`i']', `=rate9y[`i']', `=rate10y[`i']', `=rate15y[`i']', `=rate20y[`i']', `=rate30y[`i']', `=rate40y[`i']', `=rate50y[`i']' ],"'
}

fw `"];"'
fw `"option = {"'
fw `"  title : {"'
fw `"        text: '中债国债到期收益率曲面',"'
fw `"        subtext: '数据来源：中国债券信息网',"'
fw `"        textStyle:{"'
fw `"          color: '#313695'"'
fw `"        }"'
fw `"    },"'
fw `"    toolbox: {"'
fw `"        show: true,"'
fw `"        feature: {"'
fw `"            dataView: {show: true, readOnly: false},"'
fw `"            restore: {show: true},"'
fw `"            saveAsImage: {show: true}"'
fw `"        }"'
fw `"    },"'
fw `"    tooltip: {},"'
fw `"    backgroundColor: '#fff',"'
fw `"    visualMap: {"'
fw `"        show: true,"'
fw `"        dimension: 2,"'
fw `"        min: 2,"'
fw `"        max: 6,        "'
fw `"        inRange: {"'
fw `"            color: ['#313695', '#4575b4', '#74add1', '#abd9e9', '#e0f3f8', '#ffffbf', '#fee090', '#fdae61', '#f46d43', '#d73027', '#a50026']"'
fw `"        }"'
fw `"    },"'
fw `"    xAxis3D: {"'
fw `"        name: '日期', "'
fw `"        type: 'category',"'
fw `"        data: ["'
forval i = 1/`=_N'{
	fw `" "`=datestr[`i']'", "'
}
fw `"        ]"'
fw `"    },"'
fw `"    yAxis3D: {"'
fw `"        name: '期限',"'
fw `"        type: 'category',"'
fw `"        data: ["0d", "1m", "2m", "3m", "6m", "9m", "1y", "2y", "3y", "4y", "5y", "6y", "7y", "8y", "9y", "10y", "15y", "20y", "30y", "40y", "50y"]"'
fw `"    },"'
fw `"    zAxis3D: {"'
fw `"        name: '中债国债到期收益率',"'
fw `"        type: 'value',"'
fw `"        min: 0.5,"'
fw `"        max: 11"'
fw `"    },"'
fw `"    grid3D: {"'
fw `"        viewControl: {"'
fw `"            projection: 'orthographic'"'
fw `"        }"'
fw `"    },"'
fw `"    series: [{"'
fw `"        type: 'surface',"'
fw `"        wireframe: {"'
fw `"            show: false"'
fw `"        },"'
fw `"        equation: {"'
fw `"            x: {"'
fw `"                step: 1,"'
fw `"                min: 0,"'
fw `"                max: `num'"'
fw `"            },"'
fw `"            y: {"'
fw `"                step: 1,"'
fw `"                min: 0,"'
fw `"                max: 20"'
fw `"            },"'
fw `"            z: function (x, y) {"'
fw `"                var u;"'
fw `"                var v;"'
fw `"                var indexL = [];"'
fw `"                for (var l = 0;l <= 20; l = l + 1){"'
fw `"                  indexL.push(l);"'
fw `"                }"'
fw `"                var indexH = [];"'
fw `"                for (var h = 0; h <= `num'; h = h + 1){"'
fw `"                  indexH.push(h);"'
fw `"                }"'
fw `"                u = indexH.indexOf(x);"'
fw `"                v = indexL.indexOf(y);"'
fw `"                  return matrix[u][v];"'
fw `"}}}]};"'
fw, e t
