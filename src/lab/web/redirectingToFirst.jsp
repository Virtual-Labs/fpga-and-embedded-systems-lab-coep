<%-- 
    Document   : redirectingToFirst
    Created on : 27 Jan, 2012, 3:48:53 PM
    Author     : root
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
            function redirecting()
            {
                //alert("here at redir");
                $(location).attr('href',"SimFpga.jsp?expNo=1"); 
            }
            function loading() 
            {
               // alert("here loading");
                setTimeout(redirecting,1500);
            }
            
        </script>
    </head>
    
    <body onload="loading()">
        <h4>Wrong Experiment number, redirecting you to experiment number 1</h4>
    </body>
</html>
