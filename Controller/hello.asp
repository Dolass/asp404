<!--#include virtual="/Sys_Config.ASP"-->
<%Sys_Router()%>

<%
Class hello
	'---Public 变量声明
	Public Title,Content,Html

	'---初始化
	Private Sub Class_Initialize()
		Title	= "Class: hello"
		Content = "<h1>Empty</h1>"
		Html	= ""
	End Sub

	'---Public Sub 接口
	Public Sub Index(Name)
		If Name="" Then
			Content = "<h1>Hello World!</h1>"
		Else
			Content = "<h1>Hello [" & Name & "], Welcome!</h1>"
		End if

		Html = MakeHtml("Default", Title, Content)
		Response.WRite Html
	End Sub
	
	'---Public Function 接口: Public接口带返回值暂时不支持调用
	Public Function World(name)

		If name="" then name="Anonymous"
		Content = "<h1>Hello [" & Name & "], Welcome!</h1>"

		Html = MakeHtml("Default", Title, Content)
		Response.WRite Html
	End Function

End Class
%>

<%Set Sys_Cls_Handler = New Hello%>
<!--#include virtual="/Sys_Caller.ASP"-->