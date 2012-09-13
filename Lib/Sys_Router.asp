<%
'---自定义404显示
Sub Sys_404()
	Response.Write "<b>File Not Found !</b>"
	Response.End	
End Sub

'---执行失败
Sub Sys_Err()
	If Err Then
		Response.Write "<b>Error: </b>" & Err.Description & "<BR/>"
	End If
	Err.Clear
	Response.End	
End Sub


'---URL解析
Sub Sys_Router()
	'---初始化
	Dim URL,QUERY
		URL		= Sys_REQ_URL
		QUERY	=	Sys_REQ_Query
	Dim Host
		Host		 	= Request.ServerVariables("SERVER_NAME")
		Sys_ClassName	= "Index"
		Sys_MethodName	= "Index"
		Sys_Argvs		= ""
	'---清除无效数据部分 => http://xxx.xxx.xxx 
	If Instr(QUERY,"404;") Then
		QUERY = Replace(QUERY,	"404;",		"")
		QUERY = Replace(QUERY,	"http://"&Host,	"")
		'---兼容结尾: 如果有 / 则去掉
		If Right(QUERY,1)="/" Then
			QUERY = Mid(QUERY, 1, Len(QUERY)-1)
		End if
		'---取得Sys_ClassName / MedthoaName / Args
		Dim TmpArr,TmpI
		TmpArr	= Split(QUERY, "/")
		TmpI	= Ubound(TmpArr)
		If TmpI<1 Then
			Sys_404()
		Else
			If TmpI=1 Then
				Sys_ClassName	= TmpArr(1)
				Sys_MethodName	= ""
				Sys_Argvs		= ""
			ElseIf TmpI=2 Then
				Sys_ClassName	= TmpArr(1)
				Sys_MethodName	= TmpArr(2)
				Sys_Argvs		= ""
			Else
				Sys_ClassName	= TmpArr(1)
				Sys_MethodName	= TmpArr(2)
				Sys_Argvs		= Replace(QUERY, Sys_ClassName&"/", "")
				Sys_Argvs		= Replace(Sys_Argvs, Sys_MethodName&"/", "")
				Sys_Argvs		= Replace(Sys_Argvs, "/", "_")
				If Left(Sys_Argvs,1) = "_" Then
					Sys_Argvs = Mid(Sys_Argvs, 2, Len(Sys_Argvs) )
				End if
			End if
		End if
	End if
End Sub

'---URL解析
Sub Sys_Router_Debug

	Call Sys_Router()

	'---Debug信息
	If Sys_Debug=1 Then
		Response.write "<pre style='width:50%;border:#CCC 5px solid;padding:5px;'>"
		Response.write "<u>DEBUG</u>"& vbcrlf
		Response.write vbtab &"Url:"	& vbtab & Sys_REQ_URL 		& vbcrlf
		Response.write vbtab &"Query:"	& vbtab & Sys_REQ_Query 	& vbcrlf
		Response.write vbtab &"Class:"	& vbtab & Sys_ClassName		& vbcrlf
		Response.write vbtab &"Method:"	& vbtab & Sys_MethodName 	& vbcrlf
		Response.write vbtab &"Argvs:"	& vbtab & Sys_Argvs
		Response.write "</pre>"
	End if

End Sub

'---URL分发 核心函数
Sub Sys_Run()
	Dim FileName
	FileName =  Sys_Ctrl_Dir & Sys_ClassName & ".asp"
	If IsFileOK(FileName) Then
		Server.ExECUTE( FileName )
	Else
		Sys_404()
	End If
	
End Sub
%>