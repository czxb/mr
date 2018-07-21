{smcl}
{* 2018年07月21日}
{hline}
{cmd:help pmapi}{right: }
{hline}

{title:标题}

{phang}
{bf:pmapi} {hline 2} 获取一个城市所有监测点的pm2_5/pm10/co/no2/so2/o3数据。{p_end}

{title:语法}

{p 4 18 2}
{cmdab:pmapi} {cmd: city} {cmd: pollution_type}

{marker description}{...}
{title:描述}

{pstd}{cmd:city} 城市的中文名称、拼音名称或区号。
例如："city=广州","city=guangzhou","city=020"；{p_end}
{pstd}{cmd:pollution_type} 污染物的名称：pm2_5/pm10/co/no2/so2/o3。{p_end}

{title:示例}

{phang}
{stata `"pmapi guangzhou pm2_5"'}
{p_end}
{phang}
{stata `"pmapi 广州 pm2_5"'}
{p_end}
{phang}
{stata `"pmapi 广州 pm10"'}
{p_end}

{title:作者}

{pstd}程振兴{p_end}
{pstd}暨南大学·经济学院·金融学{p_end}
{pstd}中国·广州{p_end}
{pstd}{browse "http://www.czxa.top":个人网站}{p_end}
{pstd}Email {browse "mailto:czxjnu@163.com":czxjnu@163.com}{p_end}
