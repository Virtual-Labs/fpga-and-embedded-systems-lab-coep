<%-- 
    Document   : LogoutUser
    Created on : 10 Jul, 2012, 6:51:04 PM
    Author     : coepfpgavlabs
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String ref = request.getParameter("ref");
            System.out.println("ref: "+ref);
            
            session.invalidate();
            response.sendRedirect(ref);
        %>
    </body>
</html>
