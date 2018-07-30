{smcl}
{* 2018年7月30日}{...}
{hline}
{cmd:help ctbc}{right: }
{hline}

{title:标题}

{phang}
{bf:ctbc} {hline 2} 该命令用于获取国债到期收益率数据和绘制利率期限结构曲线。

{title:语法}

{p 8 18 2}
{cmdab:ctbc} {cmd:,} [{cmd:{opt s:tart}(}{it:string}{cmd:)} {cmd:{opt e:nd}(}{it:string}{cmd:)} {cmd:{opt shellp:ath}(}{it:string}{cmd:)} {cmd:{opt res:shape}} {cmd:{opt p:lot}} {cmd:{opt yla:ble}(}{it:string}{cmd:)}]

{marker options}{...}
{title:选项}

{phang}
{cmd:{opt s:tart}(}{it:string}{cmd:)}: 指定绘图的起始日期；{p_end}

{phang}
{cmd:{opt e:nd}(}{it:string}{cmd:)}: 指定绘图的截止日期；{p_end}

{phang}
{cmd:{opt shellp:ath}(}{it:string}{cmd:)}：指定"cn-treasury-curve"的位置，默认为"/Users/mr.cheng/anaconda3/bin"。在终端运行"pip install cn-treasury_curve"即可安装"cn-treasury-curve"，再运行"which cn-treasury-curve" 即可显示其路径。关于改shell命令的详细介绍参考{browse "https://github.com/rainx/cn_treasury_curve"}；

{phang}
{cmd:{opt res:shape}}: 选择该选项时数据会变成长面板；{p_end}

{phang}
{cmd:{opt p:lot}} : 指定是否绘图。默认不绘图。{p_end}

{phang}
{cmd:{opt yla:ble}(}{it:string}{cmd:)}: 自定义ylabel()选项，默认为"0(2)10"{p_end}

{title:示例}
{phang}
{stata `"ctbc, p s("20180101") yla(2(1)6)"'}
{p_end}
{phang}
{stata `"ctbc, p"'}
{p_end}
{phang}
{stata `"ctbc"'}
{p_end}
{phang}
{stata `"ctbc, res"'}
{p_end}

{title:作者}

{pstd}程振兴{p_end}
{pstd}暨南大学·经济学院·金融学{p_end}
{pstd}中国·广州{p_end}
{pstd}{browse "http://www.czxa.top":个人网站}{p_end}
{pstd}Email {browse "mailto:czxjnu@163.com":czxjnu@163.com}{p_end}

{title:Also see}
{phang}
{browse "https://github.com/rainx/cn_treasury_curve"}
{p_end}