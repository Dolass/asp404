<%
If IsObject(Sys_Cls_Handler) Then
	'---尝试实例化类
	On Error Resume Next

	'---带参数
	Dim Exec_String

	If Sys_Argvs<>"" AND Sys_MethodName<>"" AND Sys_Classname<>"" Then
		'---Class.Method(Argv) --> Class.Medthod("") --> Class.Medthod() --> Medthod不存在
		Exec_String = "Sys_Cls_Handler."& Sys_MethodName &" "& Chr(34) & Sys_Argvs & Chr(34)
		Execute( Exec_String )
		If Err Then	
			Err.Clear
			Exec_String = "Sys_Cls_Handler."& Sys_MethodName &" "& Chr(34) & Chr(34)
			Execute( Exec_String )
			If Err Then
				Err.Clear
				Exec_String = "Sys_Cls_Handler."& Sys_MethodName &"()"
				Execute( Exec_String )
				If Err Then
					Sys_404()
				End If
			End If
		End If
	ElseIf Sys_Argvs="" AND Sys_MethodName<>"" AND Sys_Classname<>"" Then
		'---Class.Medthod("") --> Class.Medthod() --> Class.Index(Method) --> Class.Index() --> Medthod不存在
		Exec_String = "Sys_Cls_Handler."& Sys_MethodName &" "& Chr(34) & Chr(34)
		Execute( Exec_String )
		If Err Then
			Err.Clear
			Exec_String = "Sys_Cls_Handler."& Sys_MethodName &"()"
			Execute( Exec_String )
			If Err Then
				Err.Clear
				Exec_String = "Sys_Cls_Handler.Index "& Chr(34) & Sys_MethodName & Chr(34)
				Execute( Exec_String )
				If Err Then					
					Err.Clear
					Exec_String = "Sys_Cls_Handler.Index()"
					Execute( Exec_String )
					If Err Then
						Sys_404()
					End If
				End If	
			End If
		End If
	ElseIf Sys_Argvs="" AND Sys_MethodName="" AND Sys_Classname<>"" Then
		'---Class.Index("")  --> Class.Index() --> Medthod不存在
		Exec_String = "Sys_Cls_Handler.Index "& Chr(34) & Chr(34)
		Execute( Exec_String )
		If Err Then
			Err.Clear
			Exec_String = "Sys_Cls_Handler.Index()"
			Execute( Exec_String )
			If Err Then
				Sys_404()
			End If
		End If
	End if
	
	Err.Clear
	If Sys_Debug=1 Then
		Exec_String = "Execute: "& Replace(Exec_String, "Sys_Cls_Handler", Sys_ClassName)
		Response.write "<pre style='width:50%;border:#CCC 5px solid;padding:5px;'>"
		Response.Write "<u>Debug</u>"	&vbcrlf
		Response.Write vbtab& Exec_String &vbcrlf
		Response.Write "</pre>"
	End If
End if
%>