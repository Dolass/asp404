<!--#include virtual="/Sys_Config.ASP"-->
<%Sys_Router()%>

<%
Class Index
	Public Title, Content, Html

	'---初始化
	Private Sub Class_Initialize()
		Title = "默认首页"
	End Sub

	Public Sub Index()
		Content = "<h1>It Works!</h1>"

		Html	= MakeHtml("Default", Title, Content)
		Response.Write Html
	End Sub

End Class
%>

<%Set Sys_Cls_Handler = New Index%>
<!--#include virtual="/Sys_Caller.ASP"-->