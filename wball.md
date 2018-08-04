<center>wball——可视化百分比数据</center>
====================================================
这是一个绘制水球图的Stata命令，你只需要给出一列数据即可绘制出非常炫酷的水球图。一个最简单的示例如下：
![](https://github.com/czxa/Web_data_Source/raw/master/ewball.png)
`代码`
```py
wball 0.6 0.5 0.4 0.3
```

### <center> 目录 </center>
  - [x] [__`1.安装`__](#安装)
  - [x] [__`2.语法`__](#语法)
  - [x] [__`3.示例`__](#示例)
    - [x] [__`3.1.主题`__](#主题)
    - [x] [__`3.2.水球上的文字`__](#水球上的文字)
    - [x] [__`3.3.文件名称`__](#文件名称)
    - [x] [__`3.4.外观`__](#外观)
    - [x] [__`3.5.水球空白区域的颜色`__](#水球空白区域的颜色)
    - [x] [__`3.6水波的波峰高度`__](#水波的波峰高度)
    - [x] [__`3.7水波的颜色`__](#水波的颜色)
    - [x] [__`3.7.1使用颜色的名称`__](#使用颜色的名称)
    - [x] [__`3.7.2使用色卡`__](#使用色卡)
    - [x] [__`3.7.3使用16进制色号`__](#使用16进制色号)
  - [x] [__`4.自定义水球外观`__](#自定义水球外观)
  - [x] [__`5.更多配置正在探索中`__](#更多配置正在探索中)


#### 安装
##### <center>安装方式一：</center>

> 第一种安装是使用github命令安装本命令：
> 首先你需要安装github命令，这个命令来源Haghish.

```py
net install github, from("https://haghish.github.io/github/")
```

> 然后使用github命令安装wball命令：

```py
github install czxa/wball, replace
```

> 推荐使用这种安装方法，`因为github安装Stata外部命令的最后会运行一个dependency.do`，这里面有该外部命令依赖的其它外部命令的安装代码。

##### <center>安装方法二：</center>

> 第二种安装方法是直接使用net命令安装：

```py
net install wball, from(http://www.czxa.top/wball)
```

> 但是由于这个命令还依赖了我的另外一些命令，所以需要再安装这些依赖的命令：

```py
net install fw, from(http://www.czxa.top/fw)
```

#### 语法

> 这个命令使用了很多的选择项，使得你能够通过选择项来自定义自己的水球图。

```js
wball arg1 arg2 arg3 ···
      [,
      text(string)
      htmlname(numeric)
      radius(numeric)
      scheme(string)
      shape(string)
      waveanimation(string)
      bordercolor(string)
      borderwidth(numeric)
      shadowcolor(string)
      shadowblur(numeric)
      color(string)
      outline(string)
      amplitude(numeric)
      animationduration(numeric)
      direction(string)
      animationduration(numeric)
      wavecolor(string)]
```

##### 参数
`arg1` `arg2` `arg3` ··· 是一列要可视化的数据，将会被反映在水球的每层波浪的高度上。取值范围建议为`0-1`，建议`从大到小排列`。理论上来说，你可以使用任意数量的参数，当然必须要有的。

##### 选项
* <span style="color:green;">冒号表明该选择项可以简写为冒号前面的部分。</span>
__`t:ext(string)`__: 控制水球上的文字，换行使用`\n`，事实上可以通过换行和空格控制文字的位置，默认为最大的数据的对应的百分数；
__`html:name(string)`__:设置html文件的名称，默认值为<span style="color:blue;">fw_example.html</span>；
__`r:adius(numeric)`__: 控制水球的大小，默认值为<span style="color:blue;">80</span>；
__`sch:eme(string)`__: 控制绘图的主题，有`dark`/`roma`/`vintage`/`macarons`/`infographic`/`shine`六种可选，默认<span style="color:blue;">dark</span>主题；
__`sha:pe(string)`__: 控制水球的形状，支持自定义，系统形状有`github`/`tax`/`wechat`/`trunk`/`weibo`/`alipay`/`baidu`/`wechat1`/`diamond`/`rect`/`roundRect`/`pin`/`circle`/`echarts`/`cup`/`arrow`/`cylinder`/`man3star`/`triangle`/`women1-women5`/`light`/`pen`/`container`/`mail`/`folder`/`battery`/`qq`/`wechatmoments`/`apple`/`chinamap`可选，如果你想自定义形状可以点击文末的链接跳转到项目主页查看如何自定义水球的形状，默认形状为<span style="color:blue;">章鱼猫</span>；
__`wavea:nimation(string)`__: 控制水球内的水波是否波动，可以取值true/false，默认<span style="color:blue;">true</span>；
__`borderc:olor(string)`__: 控制水球的边界颜色，支持各种颜色系统；
__`borderw:idth(numeric)`__: 控制水球的边界宽度，默认值为<span style="color:blue;">3</span>；
__`shadowc:olor(string)`__: 控制水球的边界阴影颜色， 默认值为<span style="color:blue;">grey</span>；
__`shadowb:lur(numeric)`__: 控制水球光晕的大小，默认取值<span style="color:blue;">20</span>；
__`color(string)`__: 控制水球空白区域的颜色， 默认值为<span style="color:blue;">grey</span>；
__`outl:ine(string)`__: 控制是否显示水球的轮廓，可以选择true/false， 默认值为<span style="color:blue;">false</span>；
__`a:mplitude(numeric)`__: 控制水球内水波的波峰高度，默认取值<span style="color:blue;">30</span>；
__`d:irection(string)`__: 控制水球内水波流动的方向，取值right/left， 默认值为<span style="color:blue;">right</span>；
__`animationd:uration(numeric)`__: 控制水球内水波波动的快慢，默认取值<span style="color:blue;">2000</span>；
__`wavec:olor(string)`__: 根据给定的颜色列表控制水波的颜色，颜色列表的颜色数目如果少于水波的数目，颜色将会循环使用。同时支持使用色卡`card1-card7`，默认取值<span style="color:blue;">card1</span>。

#### 示例
##### 主题
* `dark`:

![](https://github.com/czxa/Web_data_Source/raw/master/ewball.png)

```py
wball 0.6 0.5 0.4 0.3, sch(dark)
```

* `roma`:

![](https://github.com/czxa/Web_data_Source/raw/master/ewballroma.png)

```py
wball 0.6 0.5 0.4 0.3, sch(roma)
```

* `vintage`:

![](https://github.com/czxa/Web_data_Source/raw/master/ewballvintage.png)

```py
wball 0.6 0.5 0.4 0.3, sch(vintage)
```


* `macarons`:

![](https://github.com/czxa/Web_data_Source/raw/master/ewballmacarons.png)

```py
wball 0.6 0.5 0.4 0.3, sch(macarons)
```

* `infographic`:

![](https://github.com/czxa/Web_data_Source/raw/master/ewballinfographic.png)

```py
wball 0.6 0.5 0.4 0.3, sch(infographic)
```

* `shine`:

![](https://github.com/czxa/Web_data_Source/raw/master/ewballshine.png)

```py
wball 0.6 0.5 0.4 0.3, sch(shine)
```

##### 水球上的文字

* 基本文字添加

![](https://github.com/czxa/Web_data_Source/raw/master/ewballtext1.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) text(你好\n章鱼猫)
```

* 使用 \n 和空格控制文字的位置

![](https://github.com/czxa/Web_data_Source/raw/master/ewballtext2.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) text(你  好\n\n章  鱼  猫)
```

##### 文件名称

* 代码
```js
. wball 0.6 0.5 0.4 0.3, sch(vintage) text(你  好\n\n章  鱼  猫) html(章鱼猫)
点击章鱼猫.html即可打开结果文件
```
* 结果
```js
. wball 0.6 0.5 0.4 0.3, sch(vintage) text(你  好\n\n章  鱼  猫) html(章鱼猫)
点击章鱼猫.html即可打开结果文件
```

##### 外观

* tax

![](https://github.com/czxa/Web_data_Source/raw/master/ewballtax.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) text(你好\n\水球) shape(tax)
```

* wechat

![](https://github.com/czxa/Web_data_Source/raw/master/ewballwechat.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) text(你好\n\水球) shape(wechat)
```

* trunk

![](https://github.com/czxa/Web_data_Source/raw/master/ewballtrunk.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) text(你好\n\水球) shape(trunk)
```

* weibo

![](https://github.com/czxa/Web_data_Source/raw/master/ewballweibo.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) text(你好\n\水球) shape(weibo)
```

* alipay

![](https://github.com/czxa/Web_data_Source/raw/master/ewballalipay.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(alipay)
```

* baidu

![](https://github.com/czxa/Web_data_Source/raw/master/ewballbaidu.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(baidu)
```

* wechat1

![](https://github.com/czxa/Web_data_Source/raw/master/ewballwechat1.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(wechat1)
```
* diamond

![](https://github.com/czxa/Web_data_Source/raw/master/ewballdiamond.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(diamond)
```

* rect

![](https://github.com/czxa/Web_data_Source/raw/master/ewballrect.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(rect)
```

* roundRect

![](https://github.com/czxa/Web_data_Source/raw/master/ewballroundRect.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(roundRect)
```

* pin

![](https://github.com/czxa/Web_data_Source/raw/master/ewballpin.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(pin)
```

* circle

![](https://github.com/czxa/Web_data_Source/raw/master/ewballcircle.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(circle)
```


* echarts

![](https://github.com/czxa/Web_data_Source/raw/master/ewballecharts.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(echarts)
```

* cup

![](https://github.com/czxa/Web_data_Source/raw/master/ewballcup.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(cup)
```

* arrow

![](https://github.com/czxa/Web_data_Source/raw/master/ewballarrow.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(arrow)
```

* man3star

![](https://github.com/czxa/Web_data_Source/raw/master/ewballman3star.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(man3star)
```

* triangle

![](https://github.com/czxa/Web_data_Source/raw/master/ewballtriangle.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(triangle)
```

* women1

![](https://github.com/czxa/Web_data_Source/raw/master/ewballwomen1.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(women1)
```

* women3

![](https://github.com/czxa/Web_data_Source/raw/master/ewballwomen3.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(women3)
```

* light

![](https://github.com/czxa/Web_data_Source/raw/master/ewballlight.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(light)
```

* pen

![](https://github.com/czxa/Web_data_Source/raw/master/ewballpen.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(pen)
```

* container

![](https://github.com/czxa/Web_data_Source/raw/master/ewballcontainer.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(container)
```

* mail

![](https://github.com/czxa/Web_data_Source/raw/master/ewballmail.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(mail)
```

* folder

![](https://github.com/czxa/Web_data_Source/raw/master/ewballfolder.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(folder)
```

* battery

![](https://github.com/czxa/Web_data_Source/raw/master/ewballbattery.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(battery)
```

* qq

![](https://github.com/czxa/Web_data_Source/raw/master/ewballqq.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(qq)
```

* wechatmoments

![](https://github.com/czxa/Web_data_Source/raw/master/ewballwechatmoments.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(wechatmoments)
```

* apple

![](https://github.com/czxa/Web_data_Source/raw/master/ewballapple.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(apple)
```

* chinamap

![](https://github.com/czxa/Web_data_Source/raw/master/ewballchinamap.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(chinamap)
```

##### 水球空白区域的颜色

![](https://github.com/czxa/Web_data_Source/raw/master/ewballgreen.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(qq) color(green)
```

##### 水波的波峰高度

![](https://github.com/czxa/Web_data_Source/raw/master/ewballa60.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(cup) a(60)
```

##### 水波的颜色

###### 使用颜色的名称

![](https://github.com/czxa/Web_data_Source/raw/master/ewballcolor.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(cup)  wavec(red blue green yellow)
```

###### 使用色卡
* 色卡2

![](https://github.com/czxa/Web_data_Source/raw/master/ewballcolorcard2.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(chinamap)  wavec(card2)
```

* 色卡3

![](https://github.com/czxa/Web_data_Source/raw/master/ewballcolorcard3.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(chinamap)  wavec(card3)
```
* 色卡4

![](https://github.com/czxa/Web_data_Source/raw/master/ewballcolorcard4.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(chinamap)  wavec(card4)
```
* 色卡4

![](https://github.com/czxa/Web_data_Source/raw/master/ewballcolorcard4.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(chinamap)  wavec(card4)
```
* 色卡5

![](https://github.com/czxa/Web_data_Source/raw/master/ewballcolorcard5.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(chinamap)  wavec(card5)
```

* 色卡6

![](https://github.com/czxa/Web_data_Source/raw/master/ewballcolorcard6.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(chinamap)  wavec(card6)
```

* 色卡7

![](https://github.com/czxa/Web_data_Source/raw/master/ewballcolorcard7.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(chinamap)  wavec(card7)
```

###### 使用16进制色号

![](https://github.com/czxa/Web_data_Source/raw/master/ewballcolor16c.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(chinamap)  wavec(#E8B647 #BA9132 #DCB879 #F98f45)
```

![](https://github.com/czxa/Web_data_Source/raw/master/ewballcolor16d.png)

```js
wball 0.6 0.5 0.4 0.3, sch(vintage) shape(chinamap)  wavec(#5DAC81 #36563C #A8D8B9 #24936E)
```

#### 自定义水球外观

* 虽然该命令内置了很多外观，但是这可能依然不够使用，下面将会介绍如何定制自己的外观。
* 首先百度一下找一个提供svg图形素材的网站，例如[http://www.sfont.cn/](http://www.sfont.cn/)
* 进入这个网站：

![](https://github.com/czxa/Web_data_Source/raw/master/svg1.png)

* 找到一个自己喜欢的外观：
* 例如这个：

![](https://github.com/czxa/Web_data_Source/raw/master/svg2.png)

* 下载svg文件：

![](https://github.com/czxa/Web_data_Source/raw/master/svg3.png)

* 选择本地下载

![](https://github.com/czxa/Web_data_Source/raw/master/svg4.png)

* 然后用`文本编辑器`打开这个svg文件:

```html
<?xml version="1.0" encoding="utf-8"?>
<!-- Svg Vector Icons : http://www.sfont.cn -->
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 1000 1000" enable-background="new 0 0 1000 1000" xml:space="preserve">
<metadata> Svg Vector Icons : http://www.sfont.cn </metadata>
<g><g><path d="M839.1,513c-0.5,0-0.9,0.3-1.5,0.3l-29.6-51.2c1.9-2.6,3.3-5.6,3.3-9.2c0-8.6-7-15.7-15.7-15.7c-6.3,0-11.7,3.8-14.2,9.2h-59.1c-2.5-5.4-7.8-9.2-14.2-9.2c-8.6,0-15.7,7-15.7,15.7c0,3,1,5.6,2.5,7.9l-11.3,19.6l-10.6-18.4c1.9-2.6,3.3-5.6,3.3-9.2c0-8.6-7-15.7-15.6-15.7c-6.3,0-11.7,3.8-14.2,9.2h-59.1c-2.5-5.4-7.8-9.2-14.2-9.2c-8.6,0-15.7,7-15.7,15.7c0,2.9,1,5.6,2.5,7.9l-30.2,52.2c-8.5,0.2-15.3,7.1-15.3,15.6c0,8.3,6.5,14.9,14.6,15.4l30.2,52.3c-1.1,2.1-1.9,4.5-1.9,7c0,8.6,7,15.6,15.7,15.6c5.4,0,9.9-2.9,12.8-7.1h19l-7.7,13.3c-8.4,0.2-15.3,7.1-15.3,15.6c0,8.3,6.5,14.8,14.6,15.4l30.2,52.3c-1.1,2.2-1.9,4.5-1.9,7c0,8.6,7,15.7,15.7,15.7c5.4,0,10-3,12.8-7.2h61.8c2.8,4.2,7.3,7.2,12.8,7.2c8.6,0,15.7-7,15.7-15.7c0-3-1.1-5.7-2.6-8.2l29.5-51.1c0.4,0,0.7,0.2,1,0.2c8.6,0,15.6-7,15.6-15.7c0-8.7-7-15.7-15.6-15.7c-0.5,0-1,0.2-1.5,0.3l-7.9-13.5h20.5c2.8,4.2,7.4,7.2,12.8,7.2c8.6,0,15.7-7,15.7-15.7c0-3.1-1.1-5.8-2.7-8.2l29.5-51.1c0.4,0,0.7,0.2,1,0.2c8.6,0,15.7-7,15.7-15.7C854.8,520,847.8,513,839.1,513z M683.8,504.7l8.4,14.5c-2.1,2.6-3.5,5.8-3.5,9.5c0,3.8,1.5,7.3,3.9,10l-8.6,15l-7.9-13.6c3.1-2.8,5-6.8,5-11.4c0-4.4-1.7-8.3-4.6-11.1L683.8,504.7z M588.4,599.9c-1.7-6.8-7.6-12-14.9-12c-1.5,0-2.9,0.5-4.3,0.9l-28-48.6c3.1-2.8,5.1-6.8,5.1-11.4c0-4.3-1.8-8.3-4.6-11.1l28.7-49.7c1.1,0.3,2.1,0.6,3.3,0.6c6.6,0,12.2-4.2,14.5-10h58.4c2.3,5.9,7.8,10,14.5,10c0.7,0,1.3-0.3,1.9-0.4l14.1,24.4L665,513.1c-8.4,0.2-15.3,7.1-15.3,15.6c0,8.3,6.5,14.9,14.6,15.4l8.3,14.5h-17.6c-2.5-5.4-7.9-9.2-14.2-9.2c-8.6,0-15.7,7-15.7,15.6c0,3,1,5.6,2.5,8L612.3,600L588.4,599.9L588.4,599.9L588.4,599.9z M674,570.7l-10.2,17.7c-1-0.2-1.9-0.6-2.9-0.6c-7.4,0-13.3,5.2-14.9,12h-19.7l11.5-19.7c1.1,0.2,2.1,0.6,3.2,0.6c6.7,0,12.2-4.2,14.5-10L674,570.7L674,570.7L674,570.7z M731.2,700.6c-1-0.2-1.9-0.6-3-0.6c-7.4,0-13.3,5.2-14.9,12h-57.5c-1.6-6.8-7.6-12-14.9-12c-1.5,0-2.9,0.5-4.3,0.9l-28-48.6c3.1-2.9,5.1-6.9,5.1-11.4c0-4.4-1.7-8.3-4.6-11.1l10.3-17.8h28.8c2.8,4.2,7.4,7.1,12.8,7.1c8.6,0,15.7-7,15.7-15.7c0-3.1-1.1-5.8-2.6-8.2l10-17.3l10.7,18.5c-1.1,2.1-1.9,4.5-1.9,7c0,8.6,7,15.7,15.7,15.7c5.4,0,10-2.9,12.8-7.1h27.3l11.2,19.3c-2.1,2.6-3.5,5.9-3.5,9.6c0,3.8,1.5,7.2,3.8,10L731.2,700.6z M693.6,570.7h20.1c2.3,5.9,7.9,10,14.5,10c0.7,0,1.2-0.3,1.9-0.4l11.3,19.6h-18.2c-1.6-6.9-7.6-12.1-14.9-12.1c-1.5,0-2.9,0.5-4.3,0.9L693.6,570.7z M798.7,588.4c-1-0.2-1.9-0.6-3-0.6c-7.4,0-13.3,5.2-14.9,12h-25.4l-14.8-25.6c1.9-2.6,3.3-5.6,3.3-9.2c0-8.6-7-15.6-15.6-15.6c-6.3,0-11.7,3.7-14.2,9.2H695l8.3-14.5c0.4,0.1,0.6,0.2,1,0.2c8.6,0,15.7-7,15.7-15.7c0-8.7-7-15.7-15.7-15.7c-0.5,0-1,0.3-1.5,0.3l-12-20.8l14.2-24.7c1.1,0.3,2.1,0.7,3.3,0.7c6.6,0,12.3-4.2,14.5-10h58.4c2.3,5.8,7.9,10,14.5,10c0.6,0,1.2-0.3,1.9-0.4l29.4,51c-2.1,2.6-3.6,5.8-3.6,9.5c0,3.8,1.5,7.3,3.8,10L798.7,588.4z M300.1,629.2c6.2,4.2,14.9,7.3,24.7,8.7c4.1,0.6,8.3,1,12.7,1c4.4,0,8.7-0.4,12.7-1c9.8-1.5,18.5-4.6,24.7-8.7c-2.2,3.4-5.8,6.2-10,8.7c-7.2,4.3-16.7,7.1-27.4,7.1c-10.7,0-20.2-2.8-27.4-7.1C305.9,635.3,302.3,632.5,300.1,629.2z M375.3,558.7c0-2.2,0.6-4.3,1.4-6.2c2.4-5.2,7.5-8.8,13.6-8.8c6.1,0,11.2,3.6,13.6,8.8c0.8,1.9,1.4,3.9,1.4,6.2c0,8.3-6.7,15-15,15C382,573.7,375.3,567,375.3,558.7z M269.7,558.7c0-2.2,0.5-4.3,1.4-6.2c2.4-5.2,7.5-8.8,13.5-8.8c6.1,0,11.3,3.6,13.6,8.8c0.9,1.9,1.4,3.9,1.4,6.2c0,8.3-6.7,15-15,15C276.5,573.7,269.7,567,269.7,558.7z M955.2,887.9V296h-430L782.6,38.6L754,10L500,264L246.1,10l-28.5,28.6L474.9,296H44.8v591.9h332.2v43.8h-83.4V990h412.7v-58.4H623v-43.8L955.2,887.9L955.2,887.9z M217,548.3c1.6-6.4,20.8-38.9,76.7-38.9c10.2,0,21.3,1.1,32.8,3.3c22.8,4.3,41.5-6.1,53-28.4c0.6,3.6,3.9,21.8,9.6,29.8c14.3,20.2,37.3,17.8,42.6,16.3c4.2-1.2,7.7-3,10.7-5.3c6.6,10.5,9.5,19.6,10,22.8l-4.6,5.4h8.4c0.8,0,1.8,0,2.9-1.4l0,0c0.3-0.4,0.5-0.7,0.8-1.3c1.2-2.3,2.6-6.5,3.9-14.3c7.7,3.3,13.1,12.9,13.1,24.3c0,14.4-8.3,26-18.2,26c0,0,0,0,0,0c-0.4-0.2-1-0.4-1.8-0.5l-3.2-0.4l-1.1,3.1c-3.9,11.6-9.6,22.1-16.4,31.7c-12.7,17.7-30,31.6-49.9,40.3c-15.1,6.6-31.6,10.6-48.8,10.6c-18.5,0-36.2-4.3-52.1-11.9c-18.5-8.8-34.6-22.1-46.6-39c-6.8-9.6-12.5-20.2-16.4-31.7l-1-3.1l-3.2,0.5l-1.5,0.5c-10.2,0-18.5-11.6-18.5-26c0-7.9,2.6-15,7-19.8c1.7,5.6,3.2,8.6,4.5,10.3c0,0,0,0.2,0,0.2h0.1c1.6,1.9,3,1.9,4.2,1.9l5.3-1.1L217,548.3z M304.5,729L288,669.2c15.4,6.4,32.1,10.2,49.5,10.2c16.2,0,31.7-3.4,46.2-8.9L367.6,729L352,785.8h-31.9L304.5,729z M548.6,785.8c-5.1-47.1-25.5-89.4-56.1-122.2V543.4c0-95.3-69.4-172.7-155-172.7c-85.5,0-154.9,77.4-154.9,172.7v120.2c-30.7,32.8-51.1,75.1-56.2,122.2h-21V356.5h789.2v429.3L548.6,785.8L548.6,785.8z"/></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g></g>
</svg>
```

* 我们把这段：

```
path d="M839.1,513c-0.5,0-0.9,0.3-1.5,0.3l-29.6-51.2c1.9-2.6,3.3-5.6,3.3-9.2c0-8.6-7-15.7-15.7-15.7c-6.3,0-11.7,3.8-14.2,9.2h-59.1c-2.5-5.4-7.8-9.2-14.2-9.2c-8.6,0-15.7,7-15.7,15.7c0,3,1,5.6,2.5,7.9l-11.3,19.6l-10.6-18.4c1.9-2.6,3.3-5.6,3.3-9.2c0-8.6-7-15.7-15.6-15.7c-6.3,0-11.7,3.8-14.2,9.2h-59.1c-2.5-5.4-7.8-9.2-14.2-9.2c-8.6,0-15.7,7-15.7,15.7c0,2.9,1,5.6,2.5,7.9l-30.2,52.2c-8.5,0.2-15.3,7.1-15.3,15.6c0,8.3,6.5,14.9,14.6,15.4l30.2,52.3c-1.1,2.1-1.9,4.5-1.9,7c0,8.6,7,15.6,15.7,15.6c5.4,0,9.9-2.9,12.8-7.1h19l-7.7,13.3c-8.4,0.2-15.3,7.1-15.3,15.6c0,8.3,6.5,14.8,14.6,15.4l30.2,52.3c-1.1,2.2-1.9,4.5-1.9,7c0,8.6,7,15.7,15.7,15.7c5.4,0,10-3,12.8-7.2h61.8c2.8,4.2,7.3,7.2,12.8,7.2c8.6,0,15.7-7,15.7-15.7c0-3-1.1-5.7-2.6-8.2l29.5-51.1c0.4,0,0.7,0.2,1,0.2c8.6,0,15.6-7,15.6-15.7c0-8.7-7-15.7-15.6-15.7c-0.5,0-1,0.2-1.5,0.3l-7.9-13.5h20.5c2.8,4.2,7.4,7.2,12.8,7.2c8.6,0,15.7-7,15.7-15.7c0-3.1-1.1-5.8-2.7-8.2l29.5-51.1c0.4,0,0.7,0.2,1,0.2c8.6,0,15.7-7,15.7-15.7C854.8,520,847.8,513,839.1,513z M683.8,504.7l8.4,14.5c-2.1,2.6-3.5,5.8-3.5,9.5c0,3.8,1.5,7.3,3.9,10l-8.6,15l-7.9-13.6c3.1-2.8,5-6.8,5-11.4c0-4.4-1.7-8.3-4.6-11.1L683.8,504.7z M588.4,599.9c-1.7-6.8-7.6-12-14.9-12c-1.5,0-2.9,0.5-4.3,0.9l-28-48.6c3.1-2.8,5.1-6.8,5.1-11.4c0-4.3-1.8-8.3-4.6-11.1l28.7-49.7c1.1,0.3,2.1,0.6,3.3,0.6c6.6,0,12.2-4.2,14.5-10h58.4c2.3,5.9,7.8,10,14.5,10c0.7,0,1.3-0.3,1.9-0.4l14.1,24.4L665,513.1c-8.4,0.2-15.3,7.1-15.3,15.6c0,8.3,6.5,14.9,14.6,15.4l8.3,14.5h-17.6c-2.5-5.4-7.9-9.2-14.2-9.2c-8.6,0-15.7,7-15.7,15.6c0,3,1,5.6,2.5,8L612.3,600L588.4,599.9L588.4,599.9L588.4,599.9z M674,570.7l-10.2,17.7c-1-0.2-1.9-0.6-2.9-0.6c-7.4,0-13.3,5.2-14.9,12h-19.7l11.5-19.7c1.1,0.2,2.1,0.6,3.2,0.6c6.7,0,12.2-4.2,14.5-10L674,570.7L674,570.7L674,570.7z M731.2,700.6c-1-0.2-1.9-0.6-3-0.6c-7.4,0-13.3,5.2-14.9,12h-57.5c-1.6-6.8-7.6-12-14.9-12c-1.5,0-2.9,0.5-4.3,0.9l-28-48.6c3.1-2.9,5.1-6.9,5.1-11.4c0-4.4-1.7-8.3-4.6-11.1l10.3-17.8h28.8c2.8,4.2,7.4,7.1,12.8,7.1c8.6,0,15.7-7,15.7-15.7c0-3.1-1.1-5.8-2.6-8.2l10-17.3l10.7,18.5c-1.1,2.1-1.9,4.5-1.9,7c0,8.6,7,15.7,15.7,15.7c5.4,0,10-2.9,12.8-7.1h27.3l11.2,19.3c-2.1,2.6-3.5,5.9-3.5,9.6c0,3.8,1.5,7.2,3.8,10L731.2,700.6z M693.6,570.7h20.1c2.3,5.9,7.9,10,14.5,10c0.7,0,1.2-0.3,1.9-0.4l11.3,19.6h-18.2c-1.6-6.9-7.6-12.1-14.9-12.1c-1.5,0-2.9,0.5-4.3,0.9L693.6,570.7z M798.7,588.4c-1-0.2-1.9-0.6-3-0.6c-7.4,0-13.3,5.2-14.9,12h-25.4l-14.8-25.6c1.9-2.6,3.3-5.6,3.3-9.2c0-8.6-7-15.6-15.6-15.6c-6.3,0-11.7,3.7-14.2,9.2H695l8.3-14.5c0.4,0.1,0.6,0.2,1,0.2c8.6,0,15.7-7,15.7-15.7c0-8.7-7-15.7-15.7-15.7c-0.5,0-1,0.3-1.5,0.3l-12-20.8l14.2-24.7c1.1,0.3,2.1,0.7,3.3,0.7c6.6,0,12.3-4.2,14.5-10h58.4c2.3,5.8,7.9,10,14.5,10c0.6,0,1.2-0.3,1.9-0.4l29.4,51c-2.1,2.6-3.6,5.8-3.6,9.5c0,3.8,1.5,7.3,3.8,10L798.7,588.4z M300.1,629.2c6.2,4.2,14.9,7.3,24.7,8.7c4.1,0.6,8.3,1,12.7,1c4.4,0,8.7-0.4,12.7-1c9.8-1.5,18.5-4.6,24.7-8.7c-2.2,3.4-5.8,6.2-10,8.7c-7.2,4.3-16.7,7.1-27.4,7.1c-10.7,0-20.2-2.8-27.4-7.1C305.9,635.3,302.3,632.5,300.1,629.2z M375.3,558.7c0-2.2,0.6-4.3,1.4-6.2c2.4-5.2,7.5-8.8,13.6-8.8c6.1,0,11.2,3.6,13.6,8.8c0.8,1.9,1.4,3.9,1.4,6.2c0,8.3-6.7,15-15,15C382,573.7,375.3,567,375.3,558.7z M269.7,558.7c0-2.2,0.5-4.3,1.4-6.2c2.4-5.2,7.5-8.8,13.5-8.8c6.1,0,11.3,3.6,13.6,8.8c0.9,1.9,1.4,3.9,1.4,6.2c0,8.3-6.7,15-15,15C276.5,573.7,269.7,567,269.7,558.7z M955.2,887.9V296h-430L782.6,38.6L754,10L500,264L246.1,10l-28.5,28.6L474.9,296H44.8v591.9h332.2v43.8h-83.4V990h412.7v-58.4H623v-43.8L955.2,887.9L955.2,887.9z M217,548.3c1.6-6.4,20.8-38.9,76.7-38.9c10.2,0,21.3,1.1,32.8,3.3c22.8,4.3,41.5-6.1,53-28.4c0.6,3.6,3.9,21.8,9.6,29.8c14.3,20.2,37.3,17.8,42.6,16.3c4.2-1.2,7.7-3,10.7-5.3c6.6,10.5,9.5,19.6,10,22.8l-4.6,5.4h8.4c0.8,0,1.8,0,2.9-1.4l0,0c0.3-0.4,0.5-0.7,0.8-1.3c1.2-2.3,2.6-6.5,3.9-14.3c7.7,3.3,13.1,12.9,13.1,24.3c0,14.4-8.3,26-18.2,26c0,0,0,0,0,0c-0.4-0.2-1-0.4-1.8-0.5l-3.2-0.4l-1.1,3.1c-3.9,11.6-9.6,22.1-16.4,31.7c-12.7,17.7-30,31.6-49.9,40.3c-15.1,6.6-31.6,10.6-48.8,10.6c-18.5,0-36.2-4.3-52.1-11.9c-18.5-8.8-34.6-22.1-46.6-39c-6.8-9.6-12.5-20.2-16.4-31.7l-1-3.1l-3.2,0.5l-1.5,0.5c-10.2,0-18.5-11.6-18.5-26c0-7.9,2.6-15,7-19.8c1.7,5.6,3.2,8.6,4.5,10.3c0,0,0,0.2,0,0.2h0.1c1.6,1.9,3,1.9,4.2,1.9l5.3-1.1L217,548.3z M304.5,729L288,669.2c15.4,6.4,32.1,10.2,49.5,10.2c16.2,0,31.7-3.4,46.2-8.9L367.6,729L352,785.8h-31.9L304.5,729z M548.6,785.8c-5.1-47.1-25.5-89.4-56.1-122.2V543.4c0-95.3-69.4-172.7-155-172.7c-85.5,0-154.9,77.4-154.9,172.7v120.2c-30.7,32.8-51.1,75.1-56.2,122.2h-21V356.5h789.2v429.3L548.6,785.8L548.6,785.8z
```

* 把开头：
```
path d="
```

* 改成

```
path://
```

* 然后我们打开一个html文件，找到41行的shape，把我们修改好的这段替换进去：

![](https://github.com/czxa/Web_data_Source/raw/master/svg5.png)

![](https://github.com/czxa/Web_data_Source/raw/master/svg6.png)

#### 更多配置正在探索中···
* 敬请期待
