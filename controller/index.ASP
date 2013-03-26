<%
Class index

    '通过初始化预设 CSS 和 JS
    Private Sub Class_Initialize()
        This.CSS("bootstrap") = "css/bootstrap.min.css"
        This.JS("jQuery")     = "http://lib.sinaapp.com/js/jquery/1.9.1/jquery-1.9.1.min.js"
        This.JS("bootstrap")  = "js/bootstrap.min.js"
        
    End Sub

    Public Function index()
        This.Tags("title")   = "It Works!"
        If Sys.Server("HTTP_METHOD") ="POST" Then
            This.Tags("content_css") = "alert alert-success"
            This.Tags("content")     = "YOU'VE CLICK LOGIN BUTTON."
        Else
            This.Tags("content_css") = "well"
            This.Tags("content") = "THIS IS DEMO LOGIN FROM."
        End If
        This.View("index")
    End Function


    Public Function hello()
        Dim User : User = Sys.Argvs : If User="" Then User="Guest"
        This.Tags("Title")   = "Welcome"
        This.Tags("content") = "<h1>Welcome, "& User &".</h1>"
        This.View("hello")
    End Function
    
    Public Function error404()
        This.Tags("title")   = "File Not Found!"
        This.Tags("content") = "Can not get <b>["& Sys.Argvs &"]</b> Now, try again later. "
        This.View("404")
    End Function
End Class
%>