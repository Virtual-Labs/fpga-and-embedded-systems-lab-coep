<%-- 
    Document   : errorexp2
    Created on : 31 Jan, 2012, 11:14:14 AM
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
        <h1>Your input might be wrong...</h1>
        <H3>
            Reason : <%=exception.getMessage()%>
        </h3>
    </body>
</html>
