<%-- 
    Document   : loginUser
    Created on : 10 Jul, 2012, 11:45:01 AM
    Author     : shree
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="scripts/jquery.js"></script>
        <script type="text/javascript" src="scripts/jquery-ui.js"></script>
        
        <script type="text/javascript">
             $(document).ready(function(){
                var expNo = $('#expNo').val();
                alert("Invalid Username or Password !!");
                window.top.location.href = "loginExp.jsp?expNo="+expNo;
             });
        </script>
        
        <%
            String exp = (String) request.getParameter("expNo");
            System.out.println("Exp No : " + exp);
        %>
        
    </head>
    
    <body>
        <div>
            <input type="hidden" id="expNo" value="<%=exp%>"/>
        </div>
    </body>
</html>
