{smcl}
{* 3jan2013}{...}
{cmd:help chinafin}{right: }
{hline}

{title:简介}

{p2colset 5 25 27 2}{...}
{p2col:{hi: chinafin} {hline 2}}从和讯网下载中国上市公司的财务数据
{p_end}
{p2colreset}{...}


{title:语法}

{p 8 18 2}
{cmdab:chinafin} {it: codelist}{cmd:,}
[{it:options}]

{synoptset 36 tabbed}{...}
{synopthdr}
{synoptline}
{synopt:{opt path(foldername)}}输出结果存储的文件夹路径{p_end}

{synoptline}
{p2colreset}{...}


{pstd}{it:codelist} 一列股票代码，使用空格分割。 
对于每一个股票代码会输出一个Stata数据集文件；
输出的数据集中包含了所有年份的财务数据；
输出数据集的名字是上市公司的股票代码；
中国上市公司的股票代码为六位数字，这不同与纽约证券交易所。
例如: {p_end}
{pstd} {hi:000001} 平安银行  {p_end}
{pstd} {hi:000002} 万科 {p_end}
{pstd} {hi:600000} 浦发银行 {p_end}
{pstd} {hi:600005} 武钢股份 {p_end}

{pstd}开头的0是可以被省略的。{p_end}

{pstd}{it:path} 指定数据集保存的路径。{p_end}
{pstd} 这个路径如果不存在会被自动创建。{p_end}



{title:示例}

{phang}{cmd:. chinafin 002046 300236 600573, path(d:\account) } {p_end}
{phang}{cmd:. chinafin 002046 300236 600573} {p_end}
{phang}{cmd:. chinafin 2 5} {p_end}

{title:Authors}

{pstd}Xuan Zhang{p_end}
{pstd}Zhongnan University of Economics and Law{p_end}
{pstd}Wuhan, China{p_end}
{pstd}zhangx@znufe.edu.cn{p_end}

{pstd}Chuntao Li{p_end}
{pstd}Zhongnan University of Economics and Law{p_end}
{pstd}Wuhan, China{p_end}
{pstd}chtl@znufe.edu.cn{p_end}

{pstd}Cheng Pan{p_end}
{pstd}Zhongnan University of Economics and Law{p_end}
{pstd}Wuhan, China{p_end}
{pstd}panchengmail@163.com{p_end}

{title:致谢}

{pstd}We owe Prof. Christopher Baum many thanks for his help and suggestions on designing the code, especially on Mata programming. Of course, all the errors belong to the authors.{p_end}

{title:翻译}

{pstd}程振兴{p_end}
{pstd}暨南大学·经济学院·金融学{p_end}
{pstd}中国·广州{p_end}
{pstd}{browse "http://www.czxa.top":个人网站}{p_end}
{pstd}Email {browse "mailto:czxjnu@163.com":czxjnu@163.com}{p_end}


