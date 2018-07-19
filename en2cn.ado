*! 用于chinafin运行之后翻译变量名
*! 程振兴 2018年7月15日
cap program drop en2cn
program define en2cn
  version 12.0
  if c(stata_version) < 14{
  di "你的Stata版本过低，无法使用中文变量名！"
  }
  if c(stata_version) >= 14{
    label var stkcd "股票代码"
    label var date "日期"
    label var A001 "货币资金"
    label var A002 "交易性金融资产"
    label var A003 "应收票据"
    label var A004 "应收账款"
    label var A005 "预付款项"
    label var A006 "其他应收款"
    label var A007 "应收关联公司款"
    label var A008 "应收利息"
    label var A009 "应收股利"
    label var A010 "存货"
    label var A011 "消耗性生物资产"
    label var A012 "一年内到期的非流动资产"
    label var A013 "其他流动资产"
    label var A014 "流动资产合计"
    label var A015 "可供出售金融资产"
    label var A016 "持有至到期投资"
    label var A017 "长期应收款"
    label var A018 "长期股权投资"
    label var A019 "投资性房地产"
    label var A020 "固定资产"
    label var A021 "在建工程"
    label var A022 "工程物资"
    label var A023 "固定资产清理"
    label var A024 "生产性生物资产"
    label var A025 "油气资产"
    label var A026 "无形资产"
    label var A027 "开发支出"
    label var A028 "商誉"
    label var A029 "长期待摊费用"
    label var A030 "递延所得税资产"
    label var A031 "其他非流动资产"
    label var A032 "非流动资产合计"
    label var A033 "资产总计"
    label var A034 "短期借款"
    label var A035 "交易性金融负债"
    label var A036 "应付票据"
    label var A037 "应付账款"
    label var A038 "预收款项"
    label var A039 "应付职工薪酬"
    label var A040 "应交税费"
    label var A041 "应付利息"
    label var A042 "应付股利"
    label var A043 "其他应付款"
    label var A044 "应付关联公司款"
    label var A045 "一年内到期的非流动负债"
    label var A046 "其他流动负债"
    label var A047 "流动负债合计"
    label var A048 "长期借款"
    label var A049 "应付债券"
    label var A050 "长期应付款"
    label var A051 "专项应付款"
    label var A052 "预计负债"
    label var A053 "递延所得税负债"
    label var A054 "其他非流动负债"
    label var A055 "非流动负债合计"
    label var A056 "负债合计"
    label var A057 "实收资本（或股本）"
    label var A058 "资本公积"
    label var A059 "盈余公积"
    label var A060 "库存股"
    label var A061 "未分配利润"
    label var A062 "少数股东权益"
    label var A063 "外币报表折算价差"
    label var A064 "非正常经营项目收益调整"
    label var A065 "归属母公司所有者权益（或股东权益）"
    label var A066 "所有者权益（或股东权益）合计"
    label var P001 "营业收入"
    label var P002 "营业成本"
    label var P003 "营业税金及附加"
    label var P004 "销售费用"
    label var P005 "管理费用"
    label var P006 "勘探费用"
    label var P007 "财务费用"
    label var P008 "资产减值损失"
    label var P009 "公允价值变动净收益"
    label var P010 "投资收益"
    label var P011 "对联营企业和合营企业的投资收益"
    label var P012 "影响营业利润的其他科目"
    label var P013 "营业利润"
    label var P014 "补贴收入"
    label var P015 "营业外收入"
    label var P016 "营业外支出"
    label var P017 "非流动资产处置净损失"
    label var P018 "影响利润总额的其他科目"
    label var P019 "利润总额"
    label var P020 "所得税"
    label var P021 "影响净利润的其他科目"
    label var P022 "净利润"
    label var P023 "归属于母公司所有者的净利润"
    label var P024 "少数股东损益"
    label var P025 "每股收益"
    label var P026 "基本每股收益"
    label var C001 "经营活动产生的现金流量"
    label var C002 "销售商品、提供劳务收到的现金"
    label var C003 "收到的税费返还"
    label var C004 "收到其他与经营活动有关的现金"
    label var C005 "经营活动现金流入小计"
    label var C006 "购买商品、接受劳务支付的现金"
    label var C007 "支付给职工以及为职工支付的现金"
    label var C008 "支付的各项税费"
    label var C009 "支付其他与经营活动有关的现金"
    label var C010 "经营活动现金流出小计"
    label var C011 "经营活动产生的现金流量净额"
    label var C012 "投资活动产生的现金流量"
    label var C013 "收回投资收到的现金"
    label var C014 "取得投资收益收到的现金"
    label var C015 "处置固定资产、无形资产和其他长期资产收回的现金净额"
    label var C016 "处置子公司及其他营业单位收到的现金净额"
    label var C017 "收到其他与投资活动有关的现金"
    label var C018 "投资活动现金流入小计"
    label var C019 "购建固定资产、无形资产和其他长期资产支付的现金"
    label var C020 "投资支付的现金"
    label var C021 "取得子公司及其他营业单位支付的现金净额"
    label var C022 "支付其他与投资活动有关的现金"
    label var C023 "投资活动现金流出小计"
    label var C024 "投资活动产生的现金流量净额"
    label var C025 "筹资活动产生的现金流量"
    label var C026 "吸收投资收到的现金"
    label var C027 "取得借款收到的现金"
    label var C028 "收到其他与筹资活动有关的现金"
    label var C029 "筹资活动现金流入小计"
    label var C030 "偿还债务支付的现金"
    label var C031 "分配股利、利润或偿付利息支付的现金"
    label var C032 "支付其他与筹资活动有关的现金"
    label var C033 "筹资活动现金流出小计"
    label var C034 "筹资活动产生的现金流量净额"
    label var C035 "汇率变动对现金的影响"
    label var C036 "其他原因对现金的影响"
    label var C037 "现金及现金等价物净增加额"
    label var C038 "期初现金及现金等价物余额"
    label var C039 "期末现金及现金等价物余额"
    label var C040 "将净利润调节为经营活动现金流量"
    label var C041 "净利润"
    label var C042 "资产减值准备"
    label var C043 "固定资产折旧、油气资产折耗、生产性生物资产折旧"
    label var C044 "无形资产摊销"
    label var C045 "长期待摊费用摊销"
    label var C046 "处置固定资产、无形资产和其他长期资产的损失"
    label var C047 "固定资产报废损失"
    label var C048 "公允价值变动损失"
    label var C049 "财务费用2"
    label var C050 "投资损失"
    label var C051 "递延所得税资产减少"
    label var C052 "递延所得税负债增加"
    label var C053 "存货的减少"
    label var C054 "经营性应收项目的减少"
    label var C055 "经营性应付项目的增加"
    label var C056 "其他"
    label var C057 "经营活动产生的现金流量净额2"
    label var C058 "不涉及现金收支的重大投资和筹资活动"
    label var C059 "债务转为资本"
    label var C060 "一年内到期的可转换公司债券"
    label var C061 "融资租入固定资产"
    label var C062 "现金及现金等价物净变动情况"
    label var C063 "现金的期末余额"
    label var C064 "现金的期初余额"
    label var C065 "现金等价物的期末余额"
    label var C066 "现金等价物的期初余额"
    label var C067 "其他原因对现金的影响2"
    label var A067 "现金及存放同业款项"
    label var A068 "客户资金存款"
    label var A069 "存放中央银行款项"
    label var A070 "结算备付金"
    label var A071 "客户备付金"
    label var A072 "贵金属"
    label var A073 "拆出资金"
    label var A074 "衍生金融资产"
    label var A075 "买入返售金融资产"
    label var A076 "应收保费"
    label var A077 "应收代位追偿款"
    label var A078 "应收分保帐款"
    label var A079 "应收分保未到期责任准备金"
    label var A080 "应收分保未决赔款准备金"
    label var A081 "应收分保寿险责任准备金"
    label var A082 "应收分保长期健康险责任准备金"
    label var A083 "保户质押贷款"
    label var A084 "定期存款"
    label var A085 "发放贷款及垫款"
    label var A086 "存出保证金"
    label var A087 "代理业务资产"
    label var A088 "交易席位费"
    label var A089 "独立帐户资产"
    label var A090 "向中央银行借款"
    label var A091 "同业及其他金融机构存放款项"
    label var A092 "质押借款"
    label var A093 "拆入资金"
    label var A094 "衍生金融负债"
    label var A095 "卖出回购金融资产款"
    label var A096 "吸收存款"
    label var A097 "代理买卖证券款"
    label var A098 "代理承销证券款"
    label var A099 "预收保费"
    label var A100 "代理业务负债"
    label var A101 "应付保单红利"
    label var A102 "保户储金及投资款"
    label var A103 "未到期责任准备金"
    label var A104 "未决赔款准备金"
    label var A105 "寿险责任准备金"
    label var A106 "长期健康险责任准备金"
    label var A107 "独立帐户负债"
    label var A108 "一般风险准备"
    label var P027 "利息净收入"
    label var P028 "利息收入"
    label var P029 "利息支出"
    label var P030 "手续费及佣金净收入"
    label var P031 "手续费及佣金收入"
    label var P032 "代理买卖证券业务净收入"
    label var P033 "证券承销业务净收入"
    label var P034 "委托客户管理资产业务净收入"
    label var P035 "已赚保费"
    label var P036 "保险业务收入"
    label var P037 "分保费收入"
    label var P038 "分出保费"
    label var P039 "提取未到期责任准备金"
    label var P040 "退保金"
    label var P041 "赔付支出"
    label var P042 "摊回赔付支出"
    label var P043 "提取保险责任准备金"
    label var P044 "摊回保险责任准备金"
    label var P045 "保单红利支出"
    label var P046 "分保费用"
    label var P047 "业务及管理费"
    label var P048 "摊回分保费用"
    label var C068 "客户存款和同业存放款项净增加额"
    label var C069 "向中央银行借款净增加额"
    label var C070 "向其他金融机构拆入资金净增加额"
    label var C071 "收取利息、手续费及佣金的现金"
    label var C072 "处置交易性金融资产净增加额"
    label var C073 "拆入资金净增加额"
    label var C074 "回购业务资金净增加额"
    label var C075 "收到原保险合同保费取得的现金"
    label var C076 "收到再保业务现金净额"
    label var C077 "保户储金及投资款净增加额"
    label var C078 "客户贷款及垫款净增加额"
    label var C079 "存放中央银行和同业款项净增加额"
    label var C080 "支付的手续费及佣金的现金"
    label var C081 "支付原保险合同赔付款项的现金"
    label var C082 "支付保单红利的现金"
    label var C083 "质押贷款净增加额"
    rename stkcd 股票代码
    rename date 日期
    rename A001 A货币资金
    rename A002 A交易性金融资产
    rename A003 A应收票据
    rename A004 A应收账款
    rename A005 A预付款项
    rename A006 A其他应收款
    rename A007 A应收关联公司款
    rename A008 A应收利息
    rename A009 A应收股利
    rename A010 A存货
    rename A011 A消耗性生物资产
    rename A012 A一年内到期的非流动资产
    rename A013 A其他流动资产
    rename A014 A流动资产合计
    rename A015 A可供出售金融资产
    rename A016 A持有至到期投资
    rename A017 A长期应收款
    rename A018 A长期股权投资
    rename A019 A投资性房地产
    rename A020 A固定资产
    rename A021 A在建工程
    rename A022 A工程物资
    rename A023 A固定资产清理
    rename A024 A生产性生物资产
    rename A025 A油气资产
    rename A026 A无形资产
    rename A027 A开发支出
    rename A028 A商誉
    rename A029 A长期待摊费用
    rename A030 A递延所得税资产
    rename A031 A其他非流动资产
    rename A032 A非流动资产合计
    rename A033 A资产总计
    rename A034 A短期借款
    rename A035 A交易性金融负债
    rename A036 A应付票据
    rename A037 A应付账款
    rename A038 A预收款项
    rename A039 A应付职工薪酬
    rename A040 A应交税费
    rename A041 A应付利息
    rename A042 A应付股利
    rename A043 A其他应付款
    rename A044 A应付关联公司款
    rename A045 A一年内到期的非流动负债
    rename A046 A其他流动负债
    rename A047 A流动负债合计
    rename A048 A长期借款
    rename A049 A应付债券
    rename A050 A长期应付款
    rename A051 A专项应付款
    rename A052 A预计负债
    rename A053 A递延所得税负债
    rename A054 A其他非流动负债
    rename A055 A非流动负债合计
    rename A056 A负债合计
    rename A057 A实收资本（或股本）
    rename A058 A资本公积
    rename A059 A盈余公积
    rename A060 A库存股
    rename A061 A未分配利润
    rename A062 A少数股东权益
    rename A063 A外币报表折算价差
    rename A064 A非正常经营项目收益调整
    rename A065 A归属母公司所有者权益（或股东权益）
    rename A066 A所有者权益（或股东权益）合计
    rename P001 P营业收入
    rename P002 P营业成本
    rename P003 P营业税金及附加
    rename P004 P销售费用
    rename P005 P管理费用
    rename P006 P勘探费用
    rename P007 P财务费用1
    rename P008 P资产减值损失
    rename P009 P公允价值变动净收益
    rename P010 P投资收益
    rename P011 P对联营企业和合营企业的投资收益
    rename P012 P影响营业利润的其他科目
    rename P013 P营业利润
    rename P014 P补贴收入
    rename P015 P营业外收入
    rename P016 P营业外支出
    rename P017 P非流动资产处置净损失
    rename P018 P影响利润总额的其他科目
    rename P019 P利润总额
    rename P020 P所得税
    rename P021 P影响净利润的其他科目
    rename P022 P净利润
    rename P023 P归属于母公司所有者的净利润
    rename P024 P少数股东损益
    rename P025 P每股收益
    rename P026 P基本每股收益
    rename C001 C经营活动产生的现金流量
    rename C002 C销售商品、提供劳务收到的现金
    rename C003 C收到的税费返还
    rename C004 C收到其他与经营活动有关的现金
    rename C005 C经营活动现金流入小计
    rename C006 C购买商品、接受劳务支付的现金
    rename C007 C支付给职工以及为职工支付的现金
    rename C008 C支付的各项税费
    rename C009 C支付其他与经营活动有关的现金
    rename C010 C经营活动现金流出小计
    rename C011 C经营活动产生的现金流量净额
    rename C012 C投资活动产生的现金流量
    rename C013 C收回投资收到的现金
    rename C014 C取得投资收益收到的现金
    rename C015 C处置固定资产、无形资产和其他长期资产收回的现金净额
    rename C016 C处置子公司及其他营业单位收到的现金净额
    rename C017 C收到其他与投资活动有关的现金
    rename C018 C投资活动现金流入小计
    rename C019 C购建固定资产、无形资产和其他长期资产支付的现金
    rename C020 C投资支付的现金
    rename C021 C取得子公司及其他营业单位支付的现金净额
    rename C022 C支付其他与投资活动有关的现金
    rename C023 C投资活动现金流出小计
    rename C024 C投资活动产生的现金流量净额
    rename C025 C筹资活动产生的现金流量
    rename C026 C吸收投资收到的现金
    rename C027 C取得借款收到的现金
    rename C028 C收到其他与筹资活动有关的现金
    rename C029 C筹资活动现金流入小计
    rename C030 C偿还债务支付的现金
    rename C031 C分配股利、利润或偿付利息支付的现金
    rename C032 C支付其他与筹资活动有关的现金
    rename C033 C筹资活动现金流出小计
    rename C034 C筹资活动产生的现金流量净额
    rename C035 C汇率变动对现金的影响
    rename C036 C其他原因对现金的影响
    rename C037 C现金及现金等价物净增加额
    rename C038 C期初现金及现金等价物余额
    rename C039 C期末现金及现金等价物余额
    rename C040 C将净利润调节为经营活动现金流量
    rename C041 C净利润2
    rename C042 C资产减值准备
    rename C043 C固定资产折旧、油气资产折耗、生产性生物资产折旧
    rename C044 C无形资产摊销
    rename C045 C长期待摊费用摊销
    rename C046 C处置固定资产、无形资产和其他长期资产的损失
    rename C047 C固定资产报废损失
    rename C048 C公允价值变动损失
    rename C049 C财务费用
    rename C050 C投资损失
    rename C051 C递延所得税资产减少
    rename C052 C递延所得税负债增加
    rename C053 C存货的减少
    rename C054 C经营性应收项目的减少
    rename C055 C经营性应付项目的增加
    rename C056 C其他
    rename C057 C经营活动产生的现金流量净额2
    rename C058 C不涉及现金收支的重大投资和筹资活动
    rename C059 C债务转为资本
    rename C060 C一年内到期的可转换公司债券
    rename C061 C融资租入固定资产
    rename C062 C现金及现金等价物净变动情况
    rename C063 C现金的期末余额
    rename C064 C现金的期初余额
    rename C065 C现金等价物的期末余额
    rename C066 C现金等价物的期初余额
    rename C067 C其他原因对现金的影响2
    rename A067 A现金及存放同业款项
    rename A068 A客户资金存款
    rename A069 A存放中央银行款项
    rename A070 A结算备付金
    rename A071 A客户备付金
    rename A072 A贵金属
    rename A073 A拆出资金
    rename A074 A衍生金融资产
    rename A075 A买入返售金融资产
    rename A076 A应收保费
    rename A077 A应收代位追偿款
    rename A078 A应收分保帐款
    rename A079 A应收分保未到期责任准备金
    rename A080 A应收分保未决赔款准备金
    rename A081 A应收分保寿险责任准备金
    rename A082 A应收分保长期健康险责任准备金
    rename A083 A保户质押贷款
    rename A084 A定期存款
    rename A085 A发放贷款及垫款
    rename A086 A存出保证金
    rename A087 A代理业务资产
    rename A088 A交易席位费
    rename A089 A独立帐户资产
    rename A090 A向中央银行借款
    rename A091 A同业及其他金融机构存放款项
    rename A092 A质押借款
    rename A093 A拆入资金
    rename A094 A衍生金融负债
    rename A095 A卖出回购金融资产款
    rename A096 A吸收存款
    rename A097 A代理买卖证券款
    rename A098 A代理承销证券款
    rename A099 A预收保费
    rename A100 A代理业务负债
    rename A101 A应付保单红利
    rename A102 A保户储金及投资款
    rename A103 A未到期责任准备金
    rename A104 A未决赔款准备金
    rename A105 A寿险责任准备金
    rename A106 A长期健康险责任准备金
    rename A107 A独立帐户负债
    rename A108 A一般风险准备
    rename P027 P利息净收入
    rename P028 P利息收入
    rename P029 P利息支出
    rename P030 P手续费及佣金净收入
    rename P031 P手续费及佣金收入
    rename P032 P代理买卖证券业务净收入
    rename P033 P证券承销业务净收入
    rename P034 P委托客户管理资产业务净收入
    rename P035 P已赚保费
    rename P036 P保险业务收入
    rename P037 P分保费收入
    rename P038 P分出保费
    rename P039 P提取未到期责任准备金
    rename P040 P退保金
    rename P041 P赔付支出
    rename P042 P摊回赔付支出
    rename P043 P提取保险责任准备金
    rename P044 P摊回保险责任准备金
    rename P045 P保单红利支出
    rename P046 P分保费用
    rename P047 P业务及管理费
    rename P048 P摊回分保费用
    rename C068 C客户存款和同业存放款项净增加额
    rename C069 C向中央银行借款净增加额
    rename C070 C向其他金融机构拆入资金净增加额
    rename C071 C收取利息、手续费及佣金的现金
    rename C072 C处置交易性金融资产净增加额
    rename C073 C拆入资金净增加额
    rename C074 C回购业务资金净增加额
    rename C075 C收到原保险合同保费取得的现金
    rename C076 C收到再保业务现金净额
    rename C077 C保户储金及投资款净增加额
    rename C078 C客户贷款及垫款净增加额
    rename C079 C存放中央银行和同业款项净增加额
    rename C080 C支付的手续费及佣金的现金
    rename C081 C支付原保险合同赔付款项的现金
    rename C082 C支付保单红利的现金
    rename C083 C质押贷款净增加额
    }
end

