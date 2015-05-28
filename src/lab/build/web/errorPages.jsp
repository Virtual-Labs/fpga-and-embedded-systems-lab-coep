<%-- 
    Document   : errorPages
    Created on : 7 Dec, 2011, 3:42:17 PM
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
        <div style="color: blueviolet; background-color: white">
            <h3>Matrix Inverse Failed...</h3>
            <h2>Reason : <%=exception.getMessage()%></h2>
        </div>
    </body>
</html>
