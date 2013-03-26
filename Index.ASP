<!-- #include virtual="/Core/Base.ASP"      -->
<!-- #include virtual="/Core/System.ASP"    -->

<!-- #include virtual="/Core/Function.ASP"  -->
<!-- #include virtual="/Core/Router.ASP"    -->

<!-- #include virtual="/Core/DB.ASP"        -->
<!-- #include virtual="/Core/Cache.ASP"     -->

<!-- #include virtual="/Core/Theme.ASP"     -->

<!-- #include virtual="/Config.ASP"         -->
<!-- #include virtual="/htaccess.ASP"       -->

<%
	Router.Dispatch()
%>
