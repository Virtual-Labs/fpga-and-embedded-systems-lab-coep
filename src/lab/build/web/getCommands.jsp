<%--
    Document   : getKeywords
    Created on : 16 May, 2011, 2:59:11 PM
    Author     : root
--%>

<%@page import="extra.DbConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <% Connection connection = null;
try
{



    // Create a connection to the database
   
    connection = new DbConnect().getConnect();
        Statement st = connection.createStatement();
        String cl=request.getParameter("getCountriesByLetters");
        String letters=request.getParameter("letters");
        System.out.println("cl="+cl+" letters="+letters);
        ResultSet rs =st.executeQuery("select command from Commands where command like '"+letters+"%';");
        //$letters = preg_replace("/[^a-z0-9 ]/si","",$letters);


        while (rs.next()) {
        	String lastName = rs.getString(1);
        	%><%="1.ID "+"###"+lastName+"|"%><%

        	System.out.println(lastName + "\n");
        	}
}
catch (Exception e)
{
        e.printStackTrace();

}
%>

    </body>
</html>
