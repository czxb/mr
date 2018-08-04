{smcl}
{* 2018年3月1日}
{hline}
{cmd:help wball}{right: }
{hline}

{title:标题}

{phang}
{bf:wball} {hline 2} Stata+ECharts绘制水球图。{p_end}

{pstd}{browse "https://github.com/czxa/Web_data_source/raw/master/wball1.png":示例图片1}{p_end}
{pstd}{browse "https://github.com/czxa/Web_data_source/raw/master/wball2.png":示例图片2}{p_end}
{pstd}{browse "https://github.com/czxa/Web_data_source/raw/master/wball3.png":示例图片3}{p_end}
{pstd}{browse "https://github.com/czxa/Web_data_source/raw/master/wball4.png":示例图片4}{p_end}


{title:语法}

{p 8 18 2}
{cmd:wball} {bf: arg1 arg2 arg3 ···} {bf: [, {opt t:ext}(}{it:string}{bf:) {opt html:name}(}{it:numeric}{bf:) {opt r:adius}(}{it:numeric}{bf:) {opt sch:eme}(}{it:string}{bf:) {opt sha:pe}(}{it:string}{bf:) {opt wavea:nimation}}({it:string}) {cmd: {opt borderc:olor}}({it:string}){bf: {opt borderw:idth}(}{it:numeric}{bf:) {opt shadowc:olor}(}{it:string}{bf:) {opt shadowb:lur}(}{it:numeric}{bf:) {opt color}(}{it:string}{bf:) {opt outl:ine}(}{it:string}{bf:) {opt a:mplitude}}({it:numeric}) {cmd:{opt d:irection}(}{it:string}{bf:) {opt animationd:uration}(}{it:numeric}{bf:) {opt wavec:olor}(}{it:string}{bf:)]}

{pstd}{cmd: 描述:}{p_end}

{pstd}{space 3}{cmd: args}: 是一列要可视化的数据，将会被反映在水球的每层波浪的高度上。取值范围建议为0-1，建议从大到小排列。{p_end}


{marker options}{...}
{title:选项}

{phang} {bf: {opt t:ext}(}{it:string}{bf:)}: 控制水球上的文字，换行使用\n；      {p_end}
{phang} {bf: {opt html:name}(}{it:string}{bf:)}:设置html文件的名称，默认值为fw_example.html；{p_end}
{phang} {bf: {opt r:adius}(}{it:numeric}{bf:)}: 控制水球的大小，默认值为80；    {p_end}
{phang} {bf: {opt sch:eme}(}{it:string}{bf:)}: 控制绘图的主题，有dark/roma/vintage/macarons/infographic/shine六种可选，默认dark主题；    {p_end}
{phang} {bf: {opt sha:pe}(}{it:string}{bf:)}: 控制水球的形状，支持自定义，系统形状有github/tax/wechat/trunk/weibo/alipay/baidu/wechat1/diamond/rect/roundRect/pin/circle/echarts/cup/arrow/cylinder/man3star/triangle/women1-5/light/pen/container/mail/folder/battery/qq/wechatmoments/apple/chinamap可选，如果你想自定义形状可以点击文末的链接跳转到项目主页查看如何自定义水球的形状，默认形状为章鱼猫；    {p_end}
{phang} {bf: {opt wavea:nimation}(}{it:string}{bf:)}: 控制水球内的水波是否波动，可以取值true/false，默认true；    {p_end}
{phang} {bf: {opt borderc:olor}(}{it:string}{bf:)}: 控制水球的边界颜色，支持多种颜色系统；    {p_end}
{phang} {bf: {opt borderw:idth}(}{it:numeric}{bf:)}: 控制水球的边界宽度，默认值为3；     {p_end}
{phang} {bf: {opt shadowc:olor}(}{it:string}{bf:)}: 控制水球的边界阴影颜色，默认值为grey；    {p_end}
{phang} {bf: {opt shadowb:lur}(}{it:numeric}{bf:)}: 控制水球光晕的大小，默认取值20；    {p_end}
{phang} {bf: {opt color}(}{it:string}{bf:)}: 控制水球空白区域的颜色， 默认值为grey；    {p_end}
{phang} {bf: {opt outl:ine}(}{it:string}{bf:)}: 控制是否显示水球的轮廓，可以选择true/false， 默认值为false；    {p_end}
{phang} {bf: {opt a:mplitude}(}{it:numeric}{bf:)}: 控制水球内水波的波峰高度，m默认取值30；    {p_end}
{phang} {bf: {opt d:irection}(}{it:string}{bf:)}: 控制水球内水波流动的方向，取值right/left， 默认值为right；    {p_end}
{phang} {bf: {opt animationd:uration}(}{it:numeric}{bf:)}: 控制水球内水波波动的快慢，默认取值2000；    {p_end}
{phang} {bf: {opt wavec:olor}(}{it:string}{bf:)}.: 根据给定的颜色列表控制水波的颜色，颜色列表的颜色数目如果少于水波的数目，颜色将会循环使用。同时支持使用色卡card1-card7，默认取值card1    {p_end}

{title:示例}
{phang}
{stata `"wball 0.75 0.5 0.25, html(章鱼猫) text(你好\n章鱼猫) wavec(red green orange) sch(dark) r(90) sha(github) wavea(true) outl(false) borderc(pink) borderw(3) shadowc(gray) shadowb(40) color(yellow) a(40) direction(right)"'}
{p_end}
{phang}
{stata `"wball 0.6 0.5 0.4 0.3 0.2 0.1, text(你好\n水球) wavec(red green orange) sch(dark) r(90) sha(chinamap) wavea(true) outl(false) borderc(pink) borderw(3) shadowc(gray) shadowb(40) color(yellow) a(40) direction(right) animationd(3000)"'}
{p_end}
{phang}
{stata `"wball 0.75 0.5 0.25, html(apple) text(Hello\nMac) wavec(red green orange) sch(dark) r(90) sha(apple) wavea(true) outl(false) borderc(pink) borderw(3) shadowc(grey) shadowb(40) color(yellow) a(40) direction(right)"'}
{p_end}
{phang}
{stata `"wball 0.75 0.5 0.25, html(wechat1) text(我的微信公众号\nczxa\n\n\n\n\n\n\n\n\n) wavec(card6) sch(dark) r(90) sha(wechat1) borderc(pink) borderw(3) shadowc(grey) shadowb(40) color(#C46243) a(40) wavea(true)"'}
{p_end}

{title:作者}
{pstd}程振兴{p_end}
{pstd}暨南大学·经济学院·金融学{p_end}
{pstd}中国·广州{p_end}
{pstd}{browse "http://www.czxa.top":个人网站}{p_end}
{pstd}Email {browse "mailto:czxjnu@163.com":czxjnu@163.com}{p_end}

{title:Also see}
{phang}
{stata `"help fw"'}
{p_end}
