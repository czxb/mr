{smcl}
{* 2018年1月18日}
{hline}
{cmd:help cname}{right: }
{hline}

{title:标题}

{phang}
{bf:cname} {hline 2} 在Stata中查询中文姓氏的各种拼法。{p_end}

{title:语法}

{p 8 18 2}
{cmdab:cname} {cmd: lastname} {cmd:,[}{cmd:{opt s:plit}}{cmd:]}

{pstd}{cmd: 描述:}{p_end}

{pstd}{space 3}{cmd: lastname}: 是一列需要查询的中文姓氏，多个姓氏需要使用空格分开。{p_end}


{marker options}{...}
{title:选项}

{phang}
{cmd: {opt s:plit}}: 选择是否有分割线，默认不使用分割线。{p_end}

{title:示例}

{phang}
{stata `"cname 宋"'}
{p_end}
{phang}
{stata `"cname 程"'}
{p_end}
{phang}
{stata `"cname 刘"'}
{p_end}
{phang}
{stata `"cname 丁"'}
{p_end}
{phang}
{stata `"cname 宋 程 丁, s"'}
{p_end}

{title:作者}

{pstd}程振兴{p_end}
{pstd}暨南大学·经济学院·金融学{p_end}
{pstd}中国·广州{p_end}
{pstd}{browse "http://www.czxa.top":个人网站}{p_end}
{pstd}Email {browse "mailto:czxjnu@163.com":czxjnu@163.com}{p_end}

{title:Also see}
{phang}
{stata `"help cname"'}
{p_end}