<%
'----------------------------------------
'   系统Url Router类
'       解析URL并动态调用ctroller
'
'   注意：
'       所有ctroller的method都不带参数
'       参数访问通过 调用 Router.Argvs
'----------------------------------------
Class System_Router

    Public FULLURI, URI, HOST
    Public ClassName, MethodName, Argvs
    Public ClassDefault, MethodDefault
    Public KLS    'KeepLastSlash
    Public Rules
    Public RegRules
    Public Router_Trigger
    Public TmpExec, TmpCode, TmpHanlder

    '---私有：类初始化
    Private Sub Class_Initialize()
        KLS  = 0
        FULLURI        = Sys.Server("QUERY_STRING") : If FULLURI = "" Then FULLURI = Sys.Server("SCRIPT_NAME")
        URI            = FULLURI
        HOST           = Sys.Server("SERVER_NAME")

        ClassDefault   = "index"
        MethodDefault  = "index"

        ClassName      = ClassDefault
        MethodName     = MethodDefault
        Argvs          = ""

        Set Rules      = Server.CreateObject("Scripting.Dictionary")
        Set RegRules   = Server.CreateObject("Scripting.Dictionary")
        Router_Trigger = False
        TmpExec        = "Set TmpHanlder=New "& ClassDefault &":TmpHanlder."& MethodDefault &"():Set TmpHanlder=Nothing"
    End Sub
    
    '---私有：清理回收
    Private Sub class_terminate()
        KLS            = Empty
        FULLURI        = Empty
        URI            = Empty
        HOST           = Empty
        ClassName      = Empty
        MethodName     = Empty
        Argvs          = Empty
        ClassDefault   = Empty
        MethodDefault  = Empty
        Set Rules      = Empty
        Set RegRules   = Empty
        Router_Trigger = Empty
        TmpExec        = Empty
    End Sub

    '---私有：遍历Url Rewrite规则列表，返回当前URI匹配结果
    Private Function GetHandler()
        Dim result
        result = False        

        Dim i,k,v
        '普通规则
        k = Rules.Keys
        v = Rules.Items
        For i=0 to Rules.Count-1
            If LCase(k(i)) = LCase(URI) Then
                result = v(i)
                Exit For
            End if
        Next
        If result<>False Then
            GetHandler = result
            Exit Function
        End If

        Dim regEx, Matches,SubMatches
        Dim regRe
        '正则规则
        k = RegRules.Keys
        v = RegRules.Items
        Set regEx = New RegExp
        regEx.IgnoreCase = True
        regEx.Global = True
        For i=0 to RegRules.Count-1
            regEx.Pattern = k(i)
            Set Matches = regEx.Execute( URI )
            If Matches.Count Then
                Set regRe = New RegExp  
                regRe.Pattern = k(i)
                regRe.IgnoreCase = True                
                result = regRe.Replace( URI , v(i) )
                Exit For
            End If
        Next
        GetHandler = result
    End Function

    '---私有：解析当前请求URI
    Private Function Analyser()
        If Instr(URI, "404;http")>0 OR Instr(URI, "405;http")>0 Then
            '补充URI最后的 /
            If KLS=0 Then
                While ( Right( URI, 1 ) = "/" )
                    URI = Left( URI, Len(URI)-1 )
                WEnd
            End If

            '提取真正请求的URI，去掉 404;http / 405;http
            URI = Split( URI, HOST )(1)

            '解析URI，获取 Class/Method/Argv
            Dim Controller
            Controller      = GetHandler()
            Router_Trigger  = Controller

            If Instr( Controller, "/" )>0 then
                Controller = Split(Controller, "/")
                Select Case Ubound(Controller)
                    Case 1
                        ClassName  = Controller(0)
                        MethodName = Controller(1)
                        Argvs      = ""
                    Case 2
                        ClassName  = Controller(0)
                        MethodName = Controller(1)
                        Argvs      = Controller(2)
                    Case ELse
                        ClassName  = Controller(0)
                        MethodName = Controller(1)
                        Argvs      = Controller(2)
                        Dim i
                        For i=3 to Ubound(Controller)                          
                            Argvs  = Argvs &"/"& Controller(i)
                        Next
                End Select
            ElseIf Controller<>False Then
                ClassName  = Controller
                MethodName = MethodDefault
                Argvs      = ""
            End If
        Else
            ClassName  = ClassDefault
            MethodName = MethodDefault
            Argvs      = ""
        ENd If
        '--处理GET编码问题
        Argvs = Func.UrlDecode( Argvs )
    End Function
        
    '---私有：动态执行类、方法
    Private Function Handler( ClassName, MethodName )
        Dim ClassFileName
        ClassFileName = Sys.CtrlDir &"/"& ClassName &".ASP"
        If Func.IsFile( ClassFileName ) Then
            On Error Resume Next
            TmpCode = Func.ReadFile( ClassFileName )
            TmpCode = Replace( TmpCode, "<"&"%" , "")
            TmpCode = Replace( TmpCode, "%"&">" , "")
            ExecuteGlobal TmpCode
            If Err Then Func.Die( "Controller: <font color=red>"& ClassFileName &" ["& ClassName &"."& MethodName &"]</font>: "& Err.Description )

            On Error Resume Next
            TmpExec = "Set TmpHanlder=New "& ClassName &":TmpHanlder."& MethodName &"():Set TmpHanlder=Nothing"
            Execute TmpExec
            If Err Then Debuger() : Func.Die( "Controller.Method: <font color=red>"& ClassFileName &" ["& ClassName &"."& MethodName &"()]</font>: "& Err.Description )
        Else
            Func.Die( "File Not Found : " & ClassFileName )
        End If
    End Function

    '---私有：显示Debug信息
    Private Function Debuger()
        If Sys.Debug Then
            Dim DebugInfo
            Dim i,k,v
            DebugInfo = "<div style='width:100%;color:#000;clear:both;line-height:32px;'>FullURI: " & FULLURI &_
                        "<BR>VirtualURI: " & URI &_
                        "<BR>Rules:"

            k = Rules.Keys
            v = Rules.Items
            For i=0 to Rules.Count-1
                DebugInfo = DebugInfo & "<BR> &nbsp; &nbsp; &nbsp; &nbsp; <i><b>["& i &"]</b> " & k(i) &" => "& v(i) & "</i>"
            Next
            DebugInfo = DebugInfo & "<BR>RegRules:"    

            k = RegRules.Keys
            v = RegRules.Items
            For i=0 to RegRules.Count-1
                DebugInfo = DebugInfo & "<BR> &nbsp; &nbsp; &nbsp; &nbsp; <i><b>["& i &"]</b> " & k(i) &" => "& v(i) & "</i>"
            Next
            DebugInfo = DebugInfo & "<BR>Rule Triggered: <font color=red>" & Router_Trigger &"</font>"&_
                                    "<BR>Class: <font color=red>" & ClassName & "</font>, Method: <font color=red>" & MethodName & "</font>, Argvs: <font color=red>" & Argvs & "</font>" &_
                                    "<BR>Dymanic EXEC: <font color=red>" & TmpExec &"</font>"
            Dim Time_End
            Time_End = Timer()
            DebugInfo = DebugInfo & "<BR>Time Used: <font color=blue>"& FormatNumber(Time_End-Time_Start, 2, True) &"s</font> </div>"
            Func.Info( DebugInfo )
        End If
    End Function
    
    '---外部借口：动态调用类、方法
    Public Function Dispatch()
        Call Analyser()
        Sys.Argvs = Argvs
        Call Handler( ClassName, MethodName )
        Call Debuger()
    End Function
End Class
%>