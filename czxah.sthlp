{smcl}
{* 01Dec2017}{...}
{hline}
{cmd:help czxah}{right: }
{hline}

{title:标题}

{phang}
{bf:czxah} {hline 2} 该命令用于处理iPhone手机导出的健康数据文件"导出.xml"(如果手机的语言设置的是中文)或者"export.xml"(手机语言设置的是英文)(需要导出并解压)，
然后从其中提取出步数、运动距离、已爬楼层数以及睡眠数据并绘图。

{title:语法}

{p 8 18 2}
{cmdab:czxah} {cmd:language} {cmd:,} [{cmd:path(}{it:string}{cmd:)} {cmd:{opt t:ype}(}{it:string}{cmd:)} {cmd:{opt p:eriod}(}{it:string}{cmd:)} {cmd:{opt s:avefile}} {cmd:{opt g:raph}} {cmd:graphtype(}{it:string}{cmd:)}]

{marker description}{...}
{title:描述}

{pstd}{cmd:language} 
{space 2}是你的手机的语言设置，如果你的iPhone语言设置为中文，那么导出的zip文件解压得到的一个较大的xml文件的名字会是"导出.xml"。
{space 2}而如果你的iPhone语言设置为英文，那么导出的zip文件解压得到的一个较大的xml文件的名字将是"export.xml"。
{space 2}考虑到大家的手机一般应该只会是中文或英文，因此只设置了这两种语言，如果你有其它的语言需要，可以联系我。语言项的简写为cn
或en：{p_end}

{pstd} {hi:cn} 中文(这个时候你的工作目录或者你指定的文件路径里面要有对应的"导出.xml"才能正确运行这个命令。) {p_end}
{pstd} {hi:en} 英文(这个时候你的工作目录或者你指定的文件路径里面要有对应的"export.xml"才能正确运行这个命令。) {p_end}

{marker options}{...}
{title:选项}

{phang}
{opt path(文件路径)}: path选项可以用来工作目录的设置，默认路径为当前工作目录。{p_end}

{phang}
{opt t:ype(统计类型)}: 指定需要导出数据的统计类型，有以下几种：{p_end}

{pstd} {hi:{space 4}stepcount} 可以简写为{cmd:st}，这个时候会提取步数数据。同时这也是默认选项。 {p_end}
{pstd} {hi:{space 4}distance} 可以简写为{cmd:di}，这个时候会提取运动距离(单位：km)数据。{p_end}
{pstd} {hi:{space 4}climb} 可以简写为{cmd:cl}，这个时候会提取已爬楼层数据。{p_end}
{pstd} {hi:{space 4}sleep} 可以简写为{cmd:sl}，这个时候会提取睡眠数据，包括睡眠时间、入睡时间以及起床时间。{p_end}

{phang}
{opt p:eriod(时间类型)}: 指定需要导出数据的时间类型，有以下几种：{p_end}

{pstd} {hi:{space 4}clock} 这个时候会提取分时数据。同时这也是默认选项。{p_end}
{pstd} {hi:{space 4}day} 这个时候会提取每日数据。{p_end}
{pstd} {hi:{space 4}week} 这个时候会提取每周数据。{p_end}
{pstd} {hi:{space 4}month} 这个时候会提取每月数据。{p_end}
{pstd} {hi:{space 4}year} 这个时候会提取每年数据。{p_end}

{phang}
{opt s:avefile}: 指定保存生成的数据文件。默认不保存。{p_end}

{phang}
{cmd:graph}: 可以简写为{cmd:g}，指定是否绘图。默认不绘图。{p_end}

{phang}
{cmd:graphtype(绘图类型)}: 可以简写为{cmd:gr}，指定绘图的类型，如果指定了该选项就会绘图。默认为线图。有以下几种：{p_end}

{pstd} {hi:{space 4}line} 这个时候会绘制线图。同时这也是默认选项。{p_end}
{pstd} {hi:{space 4}hist} 这个时候会绘制频数分布直方图。{p_end}
{pstd} {hi:{space 4}kdensity} 这个时候会绘制核密度图。{p_end}

{title:示例}

{pstd}为了运行下面的示例程序，你可能需要下载示例数据集：{p_end}
{pstd}{browse "https://github.com/czxa/czxah/raw/master/导出.xml":导出.xml}{p_end}
{pstd}{browse "https://github.com/czxa/czxah/raw/master/export.xml":export.xml}{p_end}
{pstd}点击上面两个链接会在浏览器中打开数据集，这个时候只要在浏览器中右键选择“存储为”即可下载。下载完成后把数据集放在工作目录下即可正常运行下面的程序：{p_end}

{phang}
{stata `"czxah cn"'}
{p_end}
{phang}
{stata `"czxah en"'}
{p_end}
{phang}
{stata `"czxah cn, path(~/Desktop/czxah)"'}
{p_end}
{phang}
{stata `"czxah cn, t(st)"'}
{p_end}
{phang}
{stata `"czxah cn, t(di)"'}
{p_end}
{phang}
{stata `"czxah cn, t(cl)"'}
{p_end}
{phang}
{stata `"czxah cn, t(sl)"'}
{p_end}
{phang}
{stata `"czxah cn, t(st) p(day)"'}
{p_end}
{phang}
{stata `"czxah cn, t(cl) p(week)"'}
{p_end}
{phang}
{stata `"czxah cn, t(di) p(month)"'}
{p_end}
{phang}
{stata `"czxah cn, t(st) p(day) g"'}
{p_end}
{phang}
{stata `"czxah cn, t(di) p(week) gr(line)"'}
{p_end}
{phang}
{stata `"czxah cn, t(cl) p(day) gr(line)"'}
{p_end}
{phang}
{stata `"czxah cn, t(cl) p(day) gr(hist)"'}
{p_end}
{phang}
{stata `"czxah cn, t(cl) p(day) gr(kdensity)"'}
{p_end}
{phang}
{stata `"czxah cn, t(cl) p(day) gr(kdensity) savefile"'}
{p_end}

{title:作者}

{pstd}程振兴{p_end}
{pstd}暨南大学·经济学院·金融学{p_end}
{pstd}中国·广州{p_end}
{pstd}{browse "http://www.czxa.top":个人网站}{p_end}
{pstd}Email {browse "mailto:czxjnu@163.com":czxjnu@163.com}{p_end}

{title:Also see}
{phang}
{stata `"help hist"'}
{p_end}
{phang}
{stata `"help kdensity"'}
{p_end}
{phang}
{stata `"help egen"'}
{p_end}
