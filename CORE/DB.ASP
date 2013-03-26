<%
'----------------------------------------------------------------------------------------------------
'	数据库操作类
'
'	示例
'		Set DB = New System_DataBase()
'		DB.SQL = "SELECT * FROM TABLE"
'		DB.Open( DB.SQL ) / DB.OpenPage( DB.SQL )
'		...Record Access...
'		DB.Close()
'----------------------------------------------------------------------------------------------------
Class System_DataBase

	Public [Type]
	Public Dir, Name, User, Pass, Host
	Public Conn, ConnStr
	Public PerPage, CurPage
	Public Rs, SQL

	'私有, 初始化: 数据库类型和连接配置 / 数据分页配置
	Private Sub Class_Initialize()
		[Type] = "ACCESS"

		Dir  = "database"
		Name = "db.mdb"
		User = ""
		Pass = ""
		Host = "(local)"

		PerPage  = 10
		CurPage  = 1
	End Sub
	
	'私有, 销毁：ADO对象创建
	Private Sub class_terminate()
		Set Conn = Nothing
		Set Rs   = Nothing
	End Sub
	
	'私有, 打开数据库连接
	Private Sub DB___Connect()
		Set Conn = Nothing : Set Conn = Server.CreateObject("ADODB.Connection")
		Set Rs   = Nothing : Set Rs   = Server.CreateObject("ADODB.Recordset")

		If UCase([Type]) = "ACCESS" Then
			ConnStr = "Provider = Microsoft.Jet.OLEDB.4.0; Data Source = " & Server.MapPath( Dir &"\"& Name )
		ElseIf UCase([Type]) = "MSSQL" Then
			ConnStr = "Provider = Sqloledb; User ID = " & User & "; Password = " & Pass & "; Initial Catalog = " & Name & "; Data Source = " & Host & ";"
		End If		

		On Error Resume Next
		Conn.open ConnStr
		If Err Then
			Func.ShowAlert( Err.Description )
		End If
	End Sub

	'私有, 执行单句SQL
	Private Sub DB___Execute()
		If COnn.State Then
			Set Rs = Conn.Execute( SQL )
		End If
	End Sub

	'私有, 执行数据分页
	Private Sub DB___ExecutePage()
		If Rs.State Then Rs.Close
		Rs.Open SQL, Conn, 1, 1
	End Sub

	'-----接口：打开数据库连接并执行SQL语句
	Public Function [Open]( userSQL )
		SQL = userSQL
		DB___Connect()
		DB___Execute()
	End Function

	'-----接口：打开数据库连接并执行SQL语句：数据分页
	Public Function [OpenPage]( userSQL )
		SQL = userSQL
		DB___Connect()
		DB___ExecutePage()
	End Function
	
	'-----接口：关闭数据库和记录连接
	Public Function [Close]()
		If Conn.State Then Conn.Close()
		If Rs.State Then Rs.Close()
	End Function
End Class
%>