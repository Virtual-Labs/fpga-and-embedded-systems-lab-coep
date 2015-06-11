<%-- 
    Document   : Login
    Created on : 6 Jan, 2012, 11:09:04 AM
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form name="Login" id="Login" action="Login" method="Post">
            <table>
                <tr>
                    <td>
                        Username 
                    </td>
                    <td>
                        :
                    </td>
                    <td>
                        <input type="text" id="uname" name="uname" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Password 
                    </td>
                    <td>
                        :
                    </td>
                    <td>
                        <input type="password" id="upass" name="upass" />
                    </td>
                </tr>
            </table>
            <input type="submit" />
        </form>
    </body>
</html>
