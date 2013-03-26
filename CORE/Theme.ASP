<%
'----------------------------------------
'    轻量级模版
'       支持无限include
'       自定义Tag
'       自定义CSS、JS
'语法: {%tagname%} / {%include(html)%}
'----------------------------------------
Class System_Theme
	Public Tags
	Public CSS
	Public JS
	Public Theme

	Private Sub Class_Initialize()
		Set CSS  = Server.CreateObject("Scripting.Dictionary")
		Set JS   = Server.CreateObject("Scripting.Dictionary")
		Set Tags = Server.CreateObject("Scripting.Dictionary")
	End Sub
	
	Private Sub class_terminate()
		Set CSS    = Nothing
		Set JS     = Nothing
		Set Tags   = Nothing
	End Sub

	'---模版包含
	Private Function View_Include( ViewStr )
		Dim regRe, Matches
		Set regRe        = New RegExp
		regRe.IgnoreCase = True
		regRe.Global     = True
		regRe.Pattern    = "\{\%include\((\w+)\)\%\}"		
		Set Matches      = regRe.Execute( ViewStr )

		Dim Match
		Dim IncludeStr
		For Each Match in Matches
			IncludeStr = Match
			IncludeStr = regRe.Replace( IncludeStr , "$1")
			IncludeStr = Func.ReadFile( Sys.ViewDir &"/"& Theme &"/"& IncludeStr &".html" )
			ViewStr    = Replace( ViewStr, Match , IncludeStr)
		Next
		View_Include   = ViewStr
		Set regRe      = Nothing
	End Function 

	'---生成HTML并返回给浏览器
	Public Function View( tplFile )
		View = Func.ReadFile( Sys.ViewDir &"/"& Theme &"/"& tplFile & ".html" )
		If View=False Then
			Func.Die( "Theme: <font color=red>" & Sys.ViewDir &"/"& Theme &"/"& tplFile & ".html</font> load failed." )
		End If
		View = View_Include( View )

        '处理CSS
        Dim cssi, cssret
        cssret = ""
        For Each cssi In CSS
            If Left(LCase(CSS(cssi)),4)="http" Then   '外部资源
                cssret = cssret & "<link rel='stylesheet' href='"& CSS(cssi) &"' title='"& cssi &"' />" & vbcrlf
            Else
                cssret = cssret & "<link rel='stylesheet' href='/"& Sys.ViewDir &"/"& Theme &"/"& CSS(cssi) &"' title='"& cssi &"' />" & vbcrlf
            End if
        Next
		View = Func.RegReplace( View , "\{\%CSS\%\}", cssret )
        
        '处理JS
        Dim jsi, jsret
        jsret = ""
        For Each jsi In JS
            If Left(LCase(JS(jsi)),4)="http" Then   '外部资源
                jsret = jsret & "<script src='"& JS(jsi) &"' title='"& jsi &"'></script>" & vbcrlf
            Else
                jsret = jsret & "<script src='/"& Sys.ViewDir &"/"& Theme &"/"& JS(jsi) &"' title='"& jsi &"'></script>" & vbcrlf
            End if
        Next
		View = Func.RegReplace( View , "\{\%JS\%\}", jsret )

        '处理Tags
		Dim k
		For Each k in Tags
			View = Func.RegReplace( View , "\{\%"& k &"\%\}", Tags(k) )
		Next
		Response.Write View
	End Function
End Class
%>