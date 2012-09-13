<%
'---检查文件是否存在
Function IsFileOK( FileName )
	IsFileOk = False

	Dim FSO,File
    File	= Server.MapPath(FileName)
    If IsObjectOK("Scripting.FileSystemObject") Then   
		Set FSO		= CreateObject("Scripting.FileSystemObject")
		If FSO.FileExists(File) Then
			IsFileOk = True
		End If
		Set FSO		= Nothing
	Else
		Response.Write "FileSystemObject Not Supported!"
		Response.End 
	End If

End Function

'---判断是否支持组件
Function IsObjectOK( ObjectName )
	IsObjectOK = False

	On Error Resume Next
	Dim Obj
    set Obj = Server.CreateObject( ObjectName )
    If Err=0 Then
		IsObjectOK = True
	End If
	Set Obj = Nothing
End Function

'---读取模版文件
Function LoadTpl( tpl )

	Dim FSO,F,File,TplString
	tpl = tpl & ".tpl"
    File	= Server.MapPath( Sys_View_Dir & tpl )

    If IsObjectOK("Scripting.FileSystemObject") Then   
		Set FSO = CreateObject("Scripting.FileSystemObject")
		If FSO.FileExists(File) Then
			Set F = FSO.OpenTextFile( File, 1, True )
			If Err Then 
				Response.WRite "<h1>"& File &"</h1>"
				Response.WRite Err.Description
			End if
			TplString = F.ReadAll()
			F.Close
			Set F = Nothing
		Else
			TplString = "Templete File: "& tpl & " Not Found!"
		End If
		Set FSO		= Nothing
	Else
		TplString = "FileSystemObject Not Supported!"
	End If
	LoadTpl = TplString
End Function

'---读取模版文件
Function MakeHtml( tpl, title, content)
	Dim TplString 
	TplString = LoadTpl(tpl)
	TplString = Replace( TplString, "{%title%}", title)
	TplString = Replace( TplString, "{%content%}", content)
	MakeHtml = TplString
End Function
%>