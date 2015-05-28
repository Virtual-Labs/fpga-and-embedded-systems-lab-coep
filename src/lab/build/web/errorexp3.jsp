<%-- 
    Document   : errorexp3
    Created on : 28 Dec, 2011, 2:05:37 PM
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Your Equation Can not be solved....</h1>
        <H3>
            Reason : <%=exception.getMessage()%>
        </h3>
    </body>
</html>
