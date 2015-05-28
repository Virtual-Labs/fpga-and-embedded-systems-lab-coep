<%-- 
    Document   : FloorPlan
    Created on : 24 Jul, 2012, 4:45:14 PM
    Author     : shree
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <script type="text/javascript" src="scripts/jquery.js"></script>
        <script type="text/javascript" src="scripts/jquery-ui.js"></script>
    </head>
    <body>
        <h4>Floor Plan</h4>
        <%
            String ws=(String)session.getAttribute("workspace");
            String filename=(String)session.getAttribute("FileName");
            String device=(String)session.getAttribute("device");
        %>
    </body>
</html>
