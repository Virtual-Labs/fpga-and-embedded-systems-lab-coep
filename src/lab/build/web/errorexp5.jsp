<%-- 
    Document   : errorexp5
    Created on : 20 Dec, 2011, 2:34:57 PM
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true"  %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
            .laxp{
                color: #2875DE;
            }
        </style>
    </head>

    <body>


        <%
            String lax = "";
            if (exception.getMessage().equalsIgnoreCase("matrix is singular")) {
                lax = "Your equation is not solvable......";
            } else if (exception.toString().contains("NumberFormat")) {
                lax = "You have entered \"-\" character multiple times";
            } else {
                lax = exception.getMessage();
            }


        %>
        <h3 class="laxp"><%=lax%> </h3>
    </body>
</html>
