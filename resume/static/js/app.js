webpackJsonp([1],{
	"4lUz":function(e,s){},
	"7+p6":function(e,s,t){
		"use strict";var a=t("fZjL"),n=t.n(a),i=t("baUs"),o=t("Aunj");
		s.a={name:"VueTerminalEmulator",
			data:function(){
				return{
					title:"~/Desktop",
					messageList:[],
					actionResult:"",
					lastLineContent:"...",
					inputCommand:"",
					supportingCommandList:"",
					historyIndex:0,commandHistory:[]
				}
			},
		computed:{
			lastLineClass:function(){
				return"&nbsp"===this.lastLineContent?"cursor":"..."===this.lastLineContent?"loading":void 0
			}
		},
		created:function(){
			var e=this;this.supportingCommandList=n()(i.a).concat(n()(o.a)),
			this.handleRun("again").then(function(){
				e.pushToList({type:"system",label:"System",message:'键入 "help" 获取命令列表。'}),
				e.pushToList({type:"system",label:"System",message:'键入 "back" 返回主页面。'}),
				e.handleFocus()})
		},
		methods:{
			handleFocus:function(){
				this.$refs.inputBox.focus()
			},
			handleCommand:function(e){
				var s=this;
				if(13!==e.keyCode) return void this.handlekeyEvent(e);
				if(
					this.commandHistory.push(this.inputCommand),
					this.historyIndex=this.commandHistory.length,
					this.pushToList({message:"$ "+this.inputCommand+" "}),
					this.inputCommand){
						this.inputCommand=this.inputCommand.toLowerCase();
						var t=this.inputCommand.split(" ");
						"back"===t[0]?(this.pushToList(
							{type:"system",label:"System",message:"跳转页面到..."}),
						window.history?window.history.go(-1):location.href="http://czxa.top/"):"help"===t[0]?this.printHelp(t[1]):i.a[this.inputCommand]?i.a[this.inputCommand].messages.map(function(e){s.pushToList(e)}):o.a[this.inputCommand.split(" ")[0]]?this.handleRun(this.inputCommand.split(" ")[0],
						this.inputCommand):(this.pushToList({type:"system",label:"System",message:"Unknown Command."}),
						this.pushToList({type:"system",label:"System",message:'输入"help"得到支持的文件列表。'}),
						this.pushToList({type:"system",label:"System",message:'输入"back"返回主页面。'})),
						this.inputCommand="",
						this.autoScroll(),
						this.handleFocus()
					}
				},
				handlekeyEvent:function(e){
					switch(e.keyCode){case 38:this.historyIndex=0===this.historyIndex?0:this.historyIndex-1,
					this.inputCommand=this.commandHistory[this.historyIndex];
						break;
						case 40:this.historyIndex=this.historyIndex===this.commandHistory.length?this.commandHistory.length:this.historyIndex+1,
					this.inputCommand=this.commandHistory[this.historyIndex]}
				},
				handleRun:function(e,s){
					var t=this;
						return this.lastLineContent="...",
						o.a[e][e](this.pushToList,s).then(function(e){
							t.pushToList(e),t.lastLineContent="&nbsp"
						}).catch(function(e){
							t.pushToList(e||{type:"error",label:"Error",message:"Something went wrong!"}),t.lastLineContent="&nbsp"
				})},
				pushToList:function(e){
					this.messageList.push(e),this.autoScroll()
				},
				printHelp:function(e){var s=this;
					if(e){
						var t=i.a[e]||o.a[e];this.pushToList({message:t.description})
					}
					else this.pushToList({message:"这里是一些支持的变量列表："}),
						this.supportingCommandList.map(function(e){i.a[e]?s.pushToList({
							type:"success",label:e,message:"---\x3e "+i.a[e].description
						}):s.pushToList({
							type:"success",label:e,message:"---\x3e "+o.a[e].description})
					}),
					this.pushToList({
						message:'输入"back"返回主页面。'
					});this.autoScroll(),this.handleFocus()},
				time:function(){return(new Date).toLocaleTimeString().split("").splice(2).join("")},
				autoScroll:function(){var e=this;this.$nextTick(function(){e.$refs.terminalWindow.scrollTop=e.$refs.terminalLastLine.offsetTop})}}}},
				Aunj:function(e,s,t){
					"use strict";function a(){
						var e=new Date,s=e.getHours(),t=e.getMinutes(),a=e.getSeconds(),n=""+s;return n+=(t<10?":0":":")+t,n+=(a<10?":0":":")+a
					}
						var n=t("//Fk"),i=t.n(n),o=[{
							type:"system",
							label:"System",
							message:"谢谢你的来访，我首先自我介绍一下。"
						},{
							time:a(),
							type:"info",
							label:"姓名：",
							message:"程振兴"
						},{
							time:a(),
							type:"info",
							label:"性别：",
							message:"男"
						},{
							time:a(),
							type:"info",
							label:"年龄：",
							message:"22"
						},{
							time:a(),
							type:"info",
							label:"住址：",
							message:"中国广州"
						},{
							time:a(),
							type:"info",
							label:"毕业院校",
							message:"暨南大学经济学院金融学"
						},{
							time:a(),
							type:"info",
							label:"Email:",
							message:"czx@czxa.top"
						},{
							time:a(),
							type:"info",
							label:"目标：",
							message:{
								text:"暂时的目标大概有三个：",
								list:[
									{message:"找到一份满意的工作；"},
									{message:"通过11月份的FRM两级考试"},
									{message:"学好编程和数据库"}
								]}}];
s.a={
	echo:{
		description:"Echoes input",
	echo:function(e,s){
		return s=s.split(" "),
				s.splice(0,1),
			new i.a(function(t){
				e({
					time:a(),
					label:"Echo",
					type:"success",
					message:s.join(" ")
				}),t({
					type:"success",
					label:"",message:""
				})})}},open:{
					description:"Open a specified url in a new tab.",
	open:function(e,s){
		return new i.a(function(t,a){
		var n=s.split(" ")[1];
		if(!n)
			return void a({
				type:"error",
				label:"Error",
				message:"a url is required!"
			});e({
				type:"success",
				label:"Success",
				message:"Opening"
			}),-1===s.split(" ")[1].indexOf("http")&&(n="http://"+s.split(" ")[1]),window.open(n,"_blank"),t({type:"success",label:"Done",message:"Page Opened!"})})}},again:{description:"Introducting myself again.",
	again:function(e){var s=0;return new i.a(function(t){var a=setInterval(function(){e(o[s]),s++,o[s]||(clearInterval(a),t({type:"success",label:"Done",message:"我的自我介绍就是这些了。"}))},1e3)})}}}},
LBla:function(e,s,t){
	"use strict";
	var a=function(){
		var e=this,
			s=e.$createElement,
			t=e._self._c||s;
		return t("div",
			{staticClass:"terminal"},
			[t("div",{staticStyle:{position:"relative"}},
				[t("div",{staticClass:"header fade"},[t("h4",[e._v(e._s(e.title))]),e._v(" "),e._m(0)]),
				e._v(" "),
				t("div",{ref:"terminalWindow",
					staticStyle:{
						position:"absolute",
						top:"0",
						left:"0",
						right:"0",
						overflow:"auto",
						"z-index":"1",
						"margin-top":"30px",
						"max-height":"643px"
					}},[t("div",{staticClass:"terminal-window fade",attrs:{id:"terminalWindow"},on:{click:e.handleFocus}},[t("p",[e._v("欢迎来到我的个人网站！")]),e._v(" "),t("p",[t("span",{staticClass:"prompt"}),t("span",{staticClass:"cmd"},[e._v("cd "+e._s(e.title))])]),e._v(" "),t("transition-group",{attrs:{name:"component-fade",mode:"out-in"}},e._l(e.messageList,function(s,a){return t("p",{key:a},[t("span",[e._v(e._s(s.time))]),e._v(" "),s.label?t("span",{class:s.type},[e._v(e._s(s.label))]):e._e(),e._v(" "),s.message.list?t("span",{staticClass:"cmd"},[t("span",[e._v(e._s(s.message.text))]),e._v(" "),t("ul",e._l(s.message.list,function(s,a){return t("li",{key:a},[s.label?t("span",{class:s.type},[e._v(e._s(s.label)+":")]):e._e(),e._v(" "),t("pre",[e._v(e._s(s.message))])])}))]):t("span",{staticClass:"cmd"},[e._v(e._s(s.message))])])})),e._v(" "),e.actionResult?t("p",[t("span",{staticClass:"cmd"},[e._v(e._s(e.actionResult))])]):e._e(),e._v(" "),t("p",{ref:"terminalLastLine",staticClass:"terminal-last-line",on:{click:e.handleFocus}},["&nbsp"===e.lastLineContent?t("span",{staticClass:"prompt"},[e._v(e._s(e.title)+"/")]):e._e(),e._v(" "),t("span",[e._v(e._s(e.inputCommand))]),e._v(" "),t("span",{class:e.lastLineClass,domProps:{innerHTML:e._s(e.lastLineContent)}}),e._v(" "),t("input",{directives:[{name:"model",rawName:"v-model.trim",value:e.inputCommand,expression:"inputCommand",modifiers:{trim:!0}}],ref:"inputBox",staticClass:"input-box",attrs:{disabled:"..."===e.lastLineContent,autofocus:"true",type:"text"},domProps:{value:e.inputCommand},on:{keyup:function(s){e.handleCommand(s)},input:function(s){s.target.composing||(e.inputCommand=s.target.value.trim())},blur:function(s){e.$forceUpdate()}}})])],1)])])])},n=[function(){var e=this,s=e.$createElement,t=e._self._c||s;return t("ul",{staticClass:"shell-dots"},[t("li",{staticClass:"red"}),e._v(" "),t("li",{staticClass:"yellow"}),e._v(" "),t("li",{staticClass:"green"})])}],i={render:a,staticRenderFns:n};s.a=i},M93x:function(e,s,t){"use strict";function a(e){t("4lUz")}var n=t("xJD8"),i=t("tAMo"),o=t("VU/8"),l=a,m=o(n.a,i.a,!1,l,null,null);s.a=m.exports},
Msdv:function(e,s,t){
	"use strict";
	function a(e){
		t("U36e")
	}
	var n=t("7+p6"),
		i=t("LBla"),
		o=t("VU/8"),
		l=a,
		m=o(n.a,i.a,!1,l,null,null);
		s.a=m.exports},
NHnr:function(e,s,t){
	"use strict";
	Object.defineProperty(s,"__esModule",{value:!0});
	var a=t("Gu7T"),
	n=t.n(a),
	i=t("7+uW"),
	o=t("M93x");
	i.a.config.productionTip=!1,
	new i.a({el:"#app",template:"<App/>",components:{App:o.a}}),
	window.onload=function(){
		[].concat(n()(document.querySelectorAll(".fade"))).forEach(function(e){return e.classList.add("in")})
	}},
U36e:function(e,s){},
baUs:function(e,s,t){
	"use strict";
	var a={
		about:{
			description:"返回一个我的自我介绍",
			messages:[
				{message:"-  我是一个性格温和、开朗但又不失稳重的金融小白。在大学期间比较系统的学习了金融市场、金融工具以及金融建模等方面的知识，具备了一定的研究分析能力。"},
				{message:"-  同时自学了一些统计编程软件和图表的绘制，能够熟练地使用相关软件进行数据搜集、处理建模及图表绘制。"},
				{message:"-  我喜爱钻研、写作和分享，并且给自己做了个人网站 (www.czxa.top)，通过这些平台向朋友们分享自己的学习笔记和经验。."},
				{message:"-  另外自己也爱数据分析和图表绘制，经常会在自己的网站上更新一些博客介绍各种图表的绘制方法，同时自己也在分享中不断进步。"},
				]},
		stata:{
			description:"返回所有我自己编写的Stata外部命令",
			messages:[
					{type:"success",label:"Stata",message:"1 cuse: 我的Stata数据库"},
					{type:"success",label:"Stata",message:'2 rose: 南丁格尔图'},
					{type:"success",label:"Stata",message:'3 dict: 中英文互译'},
					{type:"success",label:"Stata",message:"4 pzrate: 查询重要的利率"},
					{type:"warning",label:"Stata",message:'5 kline: 绘制K线图'},
					{type:"success",label:"Stata",message:'6 fw: Stata+ECharts绘图规范'},
					{type:"success",label:"Stata",message:'7 wball: 绘制水球图'},
					{type:"success",label:"Stata",message:'8 jpncm/cncm: 颜色地图'},
					{type:"success",label:"Stata",message:'9 cnmaproute: 绘制中国地图和路线图'},
					{type:"success",label:"Stata",message:'10 dashboard: 绘制仪表盘'},
					{type:"success",label:"Stata",message:'11 baidumap: 调取指定位置的百度地图'},
					{type:"success",label:"Stata",message:'12 stcnmap: 绘制中国地图'},
					{type:"success",label:"Stata",message:'13 webhelp: 一大堆网络搜索命令(仅限Mac版Stata可用)'},
					{type:"success",label:"Stata",message:'14 weatherglass: 绘制一条温度计——可视化温度数据'},
					{type:"success",label:"Stata",message:'15 progressbar: 绘制进度条柱形图'},
					{type:"success",label:"Stata",message:'16 dynamicbar: 绘制动态可伸缩柱形图'},
					{type:"success",label:"Stata",message:'17 ddc: 绘制双变量动态仪表盘'},
					{type:"success",label:"Stata",message:'18 conch: 绘制海螺饼图'},
					{type:"success",label:"Stata",message:'19 rainbowbar: 绘制彩虹色柱条图的Stata命令'},
					{type:"success",label:"Stata",message:'20 扁平化的仪表盘绘制命令: dashboard2'}

				]},
		r:{
			description:"返回所有我自己编写的R包",
			messages:[
					{type:"success",label:"R",message:"1 FMFE: 一个辅助金融数学和金融工程教学的R包，目前正在开发中"},
					{type:"success",label:"EASTMONEY",message:"2 EASTMONEY: 东方财富网数据接口，用于获取东方财富网的数据。"}
				]},
		skills:{
			description:"返回我接触到的编程语言",
			messages:[
				{type:"success",label:"A",message:"· Stata 90/100"},
				{type:"success",label:"A",message:"· Office 80/100"},
				{type:"warning",label:"B",message:"· R 60/100"},
				{type:"error",label:"C",message:"· C++ 10/100"},
				{type:"warning",label:"C",message:"· Python 20/100"},
				{type:"error",label:"D",message:"· D3.js 2/100"},
				{type:"error",label:"D",message:"· MySQL 1/100"}
			]
		},
		majors:{
			description:"返回我的大学主修课程及得分",
			messages:[
				{type:"success",label:"A", message:". 货币金融学: 98/100"},
				{type:"success",label:"A", message:". 金融数学: 96/100"},
				{type:"success",label:"A", message:". 金融计量学: 96/100"},
				{type:"success",label:"A", message:". 金融数学: 96/100"},
				{type:"success",label:"A", message:". 公司金融: 95/100"},
				{type:"success",label:"A", message:". 国际金融: 95/100"},
				{type:"success",label:"A", message:". 房地产金融: 95/100"},
				{type:"success",label:"A", message:". 个人理财: 95/100"},
				{type:"success",label:"B", message:". 固定收益证券分析: 94/100"},
				{type:"success",label:"B", message:". 国际结算: 94/100"},
				{type:"success",label:"B", message:". 计量经济学: 93/100"},
				{type:"success",label:"A", message:". 证券投资学: 93/100"}
			]
		},
		books:{
			description:"返回我读过的书",
			messages:[
				{type:"success",label:"蔡瑞胸", message:"《金融数据分析导论——基于R语言》"},
				{type:"success",label:"陈强", message:"《高级计量经济学及Stata应用》"},
				{type:"success",label:"陈强", message:"《计量经济学及Stata应用》"},
				{type:"success",label:"Christopher F.Baum", message:"《An Introduction to Stata Programming》"},
				{type:"success",label:"Michael N. Mitchell", message:"《A Visual Guide to Stata Graphics》"},
				{type:"warning",label:"Hadley Wickham", message:"《R包开发》"},
				{type:"success",label:"Philippe Jorion", message:"《金融风险管理师手册》"},
				{type:"success",label:"Steven D. Levitt", message:"《魔鬼经济学》"},
				{type:"success",label:"Steven E. Shreve", message:"《Stochastic Calculus for Finance I: The Binomial Asset Pricing Model》"},
				{type:"warning",label:"薛毅", message:"《统计分析与R》"},
				{type:"warning",label:"Ryan Mitchell", message:"《Python网络数据采集》"},
				{type:"warning",label:"Ruey S. Tsay", message:"《金融时间序列分析》"},
				{type:"warning",label:"Ruey S. Tsay", message:"《多元时间序列及金融应用》"},
				{type:"warning",label:"基本有用的计量经济学", message:"《赵西亮》"},
				{message:" 还有很多忘掉的······"}
			]
		},
		certs:{
			description:"返回我的证书",
			messages:[
				{time: "2016-06", type:"success",label:"大学英语四级", message:"551"}, 
				{time: "2016-12", type:"success",label:"大学英语六级", message:"509"},
				{time: "2017-06", type:"success",label:"暨南大学本科优异生", message:"学院前1.5%"}, 
				{time: "2018-06", type:"warning",label:"证券从业资格证", message:"裸考。。没通过法律法规，只通过了金融市场基础。。。"},
				{time: "2018-09", type:"error",label:"计算机二级MS Office", message:"备考中。。。"},
				{time: "2018-09", type:"error",label:"计算机二级MS MySQL", message:"备考中。。。"},
				{time: "2018-11", type:"error",label:"金融风险管理师 FRM", message:"备考中。。。"},
			]
		}
};s.a=a},
tAMo:function(e,s,t){
	"use strict";
	var a=function(){
		var e=this,
			s=e.$createElement,
			t=e._self._c||s;
		return t("div",{attrs:{id:"app"}},
			[t("vue-terminal-emulator")],1)},
		n=[],
		i={render:a,staticRenderFns:n};s.a=i},
xJD8:function(e,s,t){
	"use strict";
	var a=t("Msdv");
		s.a={
			name:"app",
			components:{
				VueTerminalEmulator:a.a}
			}
		}
	},
	["NHnr"]
);