<%-- 
    Document   : linuxCommands
    Created on : 21 Jun, 2011, 6:18:59 PM
    Author     : root
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="extra.DbConnect"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
   <script type="text/javascript" src="ToolTipscript.js">
        </script><link rel="stylesheet" type="text/css" href="style.css" />
    <body>
        <h1>Basic Linux Commands: </h1>
        <h2>
            <table border="1">
            <% Connection connection = null;
try
{
DbConnect db=new DbConnect();
        connection =db.getConnect();
        Statement st = connection.createStatement();
        ResultSet rs =st.executeQuery("SELECT * FROM Commands;");
        String t=null;
while (rs.next()) {%>
<tr>
    <td>&nbsp;&nbsp;<%=rs.getString(2)%><td>&nbsp;&nbsp;<%=rs.getString(3)%>
</tr>

       <% }
}
catch (Exception e)
{        e.printStackTrace();}
%>
</table>
        </h2>
    </body>
</html>
