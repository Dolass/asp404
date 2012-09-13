<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	Option Explicit
	Response.CodePage=65001
	Response.CharSet="UTF-8"
	
	'---全局变量, UrlRewrite 必须
	Dim Sys_REQ_Url
	Dim Sys_REQ_Query
	Dim Sys_Lib_Dir
	Dim Sys_Ctrl_Dir
	Dim Sys_View_Dir
	Dim Sys_Cls_Handler
	Dim Sys_ClassName,Sys_MethodName,Sys_Argvs
	Dim Sys_Debug

	'---初始赋值
	Sys_REQ_Url		= Request.ServerVariables("URL")
	Sys_REQ_Query	= Request.ServerVariables("QUERY_STRING")
	Sys_Lib_Dir		= "/Lib/"
	Sys_Ctrl_Dir 	= "/Controller/"
	Sys_View_Dir 	= "/View/"
	Sys_Cls_Handler	= NULL
	Sys_Debug		= 0
%>
<!--#include virtual="/Lib/Sys_Router.asp"-->
<!--#include virtual="/Lib/Sys_Functions.ASP"-->