<%-- 
    Document   : test1
    Created on : 19 Jul, 2011, 11:41:00 AM
    Author     : root
--%>

<%@page import="extra.VCDPRO"%>
<%@page import="java.util.*"%>
<%@page import="extra.VcdParse"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    
  <%
  VCDPRO vcd=new VCDPRO();
out.print(vcd.setTheme());
%>
    </head>
    <body>
 
    </body>
</html>
