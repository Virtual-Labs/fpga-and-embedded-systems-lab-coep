<%-- 
    Document   : RegisterFail
    Created on : 13 Jul, 2012, 4:52:48 PM
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
        
        <script type="text/javascript">
            $(document).ready(function(){
                var expNo = $('#expNo').val();
                alert("Registration successfully !! Info sent on your mail");
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
