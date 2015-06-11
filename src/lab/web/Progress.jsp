<%-- 
    Document   : Progress
    Created on : 16 May, 2011, 1:07:40 PM
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="statusBean" scope="session"
class="extra.StatusBean"/>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Progress</title>
        <% if (!statusBean.isCompleted()) { %>
        <SCRIPT type="text/javascript"  LANGUAGE="JavaScript">
setTimeout("location='Progress.jsp'", 1000);
</SCRIPT>
<% } %>
    </head>
    <body>
       <% if (!statusBean.isCompleted()) { %>
<H1 ALIGN="CENTER"> Please wait..while we process your request..</H1>
<% } else { %>
<H1 ALIGN="CENTER">Put your page content here...</H1>
<% } %>
    </body>
</html>
