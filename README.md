**这是一个精简的demo实现，完整版和应用实例正在完成**

系统要求
-----
* FSO支持
* 支持自定义404

系统文件
-----
	│  Index.ASP			//主程序入口
	│  Sys_Caller.ASP		//动态调用类、方法
	│  Sys_Config.ASP		//系统配置
	│  说明文档.txt			//本文档
	│  
	├─Controller			//Class主目录: http://xxx.xxx.xxx/class/ -> class.asp
	│      hello.asp		//测试class hello
	│      index.asp		//默认class
	│      
	├─Lib					//系统基础库
	│      Sys_Functions.ASP	//常用函数库
	│      Sys_Router.asp		//Url解析、动态加载ASp
	│      
	└─View					//模版
			Default.tpl		//默认模版

使用说明
-----
* 将404错误指向 /index.asp
* 在 Controller 下新建类文件
* 开发说明

		本测试程序 UrlRewrite规则是被写死的
		[域名]/url1/url2/url3/ur4.html

		则建立: /Controller/url1.asp 文件, 文件内容为 class 定义, 且class name 必须为 url1
		其中的方法 和参数不受任何限制，但是建议写 Index 方法用于默认调用

		该class文件必须在头部插入
			==============================================
			<!--#include virtual="/Sys_Config.ASP"-->
			<%Sys_Router()%>
			==============================================
		同时尾部必须插入
			==============================================
			<%Set Sys_Cls_Handler = New Index%>
			<!--#include virtual="/Sys_Caller.ASP"-->
			==============================================
* Class的内部实现不受任何限制
		
其他
-----	
* 已存在的文件/目录会直接访问
* 存在的目录下不存在的文件 会交给404 Handler 也就是会有本系统来全部处理
		