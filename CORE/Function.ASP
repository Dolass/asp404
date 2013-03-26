<%
'----------------------------------------
'	系统函数库
'----------------------------------------
Class System_Function

	'---显示警告信息并终止执行
	Public Function Die( Message )
		Err.Clear
		Response.Write Message
		Response.End
	End Function
	
	'---显示调试信息并继续执行
	Public Function Info( Message )
		Response.Write "<div style='text-align: left; border:#CCC 1px solid;margin: 10px auto;padding: 10px;color: #333; font-size: 12px;width: 90%;font-family: Georgia;'>"
		Response.Write Message
		Response.Write "</div>"
	End Function

	'---检查文件是否存在
	Public Function IsFile( FilePath )
		IsFile = False
		Dim FSO,File
		If Not ( Mid(FilePath,2,1) = ":" ) Then
			File = Server.MapPath( FilePath )
		Else
			File = FilePath
		End If
		If IsObject("Scripting.FileSystemObject") Then   
			Set FSO = CreateObject("Scripting.FileSystemObject")
			If FSO.FileExists(File) Then IsFile = True
			Set FSO	= Nothing
		Else
			Die( "FSO not supported by your server!" )
		End If
	End Function
	
	'---检查对象是否存在
	Public Function IsObject( ObjectName )
		IsObject = False
		Dim Obj
		set Obj = Server.CreateObject( ObjectName )
		If Err=0 Then IsObject = True
		Set Obj = Nothing
	End Function

	'---读取文件内容
	Public Function ReadFile( FilePath )
		Dim FSO, File, Stream
		Dim TmpStr
		File = Server.MapPath( FilePath )
		If Func.IsFile( File ) Then
			Set Stream = Server.CreateObject("ADODB.Stream")
			With Stream
				.Type = 2
				.Mode = 3
				.Open
				.LoadFromFile File
				.Charset = "UTF-8"
				.Position = 2
				TmpStr = .ReadText
				.Close
			End With
			Set Stream = Nothing
		Else
			TmpStr = False
		End If
		Set Fso = Nothing
		ReadFile = tmpStr
	End Function

	'---正则替换：原始字符串、正则表达式、目标字符串
	Public Function RegReplace( src, regStr, tarStr )
		Dim regRe
		Set regRe        = New RegExp
		regRe.IgnoreCase = True
		regRe.Global     = True
		regRe.Pattern    = regStr
		RegReplace       = regRe.Replace( src , tarStr )
		Set regRe        = Nothing
	End Function
	
	'---URI中解决汉字编码问题 [[通过vbs动态调用jscript]]
	Public FUnction UrlDecode(str)
		If IsObject("ScriptControl") Then
			Dim objScript		
			Set objScript = Server.CreateObject("ScriptControl")
			objScript.Language = "JavaScript"
            On Error Resume Next
			UrlDecode = objScript.Eval("decodeURIComponent(""" & Str & """.replace(/\+/g,"" ""))")
			Set objScript = NOTHING
			If Err Then Func.Die( Err.Description &"["& str &"]" )
		Else
			UrlDecode = Unescape( Str )
		End If
	END Function
End Class
%>