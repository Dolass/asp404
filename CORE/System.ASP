<%
'----------------------------------------
'    系统配置 和 接口
'----------------------------------------
Class System_Config

    Public post,[get],[server],[cookie],Argvs
    Public CtrlDir, ViewDir
    Public Debug

    '---私有：类初始化
    Private Sub Class_Initialize()
        Set post      = Request.Form
        Set [get]     = Request.QueryString
        Set [server]  = Request.ServerVariables
        Set [cookie]  = Request.Cookies
        Argvs         = Empty
        CtrlDir       = "control"
        ViewDir       = "view"
        Debug         = 0
    End Sub

End Class
%>