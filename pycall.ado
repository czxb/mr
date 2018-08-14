*! pycall: 在Stata中运行Python代码
*! 程振兴 2018年8月14日
*! 该命令的实现原理是将Python代码保存为一个临时的py文件，然后将该文件使用命令行的python3运行，然后将结果返回。一段示例的原始代码如下：
*! ###################### !*
*! ###		原理 	  ### !*
*! ###################### !*
*! file open myfile using temp.py, write replace
*! file write myfile "from tushare import *" _n
*! file write myfile "df = get_hist_data('000001')" _n
*! file write myfile "df.to_csv('000001.csv')" _n
*! file close myfile 
*! !/Users/mr.cheng/anaconda3/bin/python3 temp.py > temp.txt
*! ###################### !*
*! ###		示例 	  ### !*
*! ###################### !*
*! pycall, s
*! pycall "from tushare import *"
*! pycall "df = get_hist_data('000001')"
*! pycall "df.to_csv('000001.csv')"
*! pycall "for i in range(1, 10):print(i)"
*! pycall, e r t
cap prog drop pycall
prog def pycall
	version 14.0
	syntax [anything(name = pycode)] [, Start End Run Txt]
	if "`start'" != ""{
		cap file close myfile
		file open myfile using temppyfile.py, write replace
	}
	if "`txt'" != ""{
		local out = "> output.txt"
	}
	if "`end'" != ""{
		file close myfile
	}
	else{
		file write myfile `pycode' _n
	}
	if "`run'" != ""{
		!/Users/mr.cheng/anaconda3/bin/python3 temppyfile.py `out'
		erase temppyfile.py
	}
end
