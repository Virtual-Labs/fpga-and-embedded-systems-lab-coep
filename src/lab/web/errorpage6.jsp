<%-- 
    Document   : errorpage6
    Created on : 12 Jan, 2012, 11:06:40 AM
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
        <h1><%if (exception.getMessage().contains("For input string")) {
                out.println("Invalid Input");
            } else {
                exception.getMessage();
            }

            %></h1>

    </body>
</html>
