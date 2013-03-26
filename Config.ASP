<%
'----------------------------------------
'	系统配置
'----------------------------------------
Sys.CtrlDir = "controller"	' ctrl 资源目录
Sys.ViewDir = "style"		' view 资源目录
Sys.Debug   = 0 			' 显示debug信息
Router.KLS	= 0				' Url中 KeepLastFlash 


'----------------------------------------
'	数据库配置
'----------------------------------------
DB.Type		= "ACCESS"		' 数据库类型
DB.Dir		= "database"	' ACCESS数据库目录
DB.Name		= "db.mdb"		' ACCESS数据库文件名
DB.PerPage	= 5				' 列表页分页大小


'----------------------------------------
'	模版相关
'----------------------------------------
This.Theme  = "bootstrap"
%>