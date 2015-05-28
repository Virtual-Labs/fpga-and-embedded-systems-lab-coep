<%-- 
    Document   : GenerateGraphExp7new
    Created on : 19 May, 2012, 10:31:16 AM
    Author     : coepfpgavlabs
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript" src="scripts/jquery.js"></script>
        <script type="text/javascript" src="scripts/jquery-ui.js"></script>
        <script src="highcharts.js"></script>
        <script src="exporting.js"></script>
        
        <style>
           .table
           {
               width : 100%;
           }
       </style>
    </head>
    <body>
        
        <%
           session = request.getSession();
           String transfer=(String) session.getAttribute("transferFunction");
           String operation=(String) session.getAttribute("operation");
           String time=(String) session.getAttribute("samplingTime");
           String setpoint=(String) session.getAttribute("setPoint");
           String kpval=(String) session.getAttribute("kp");
           String kdval=(String) session.getAttribute("kd");
           String kival=(String) session.getAttribute("ki");
       %>
       
       <div>
           <table class="table">
               <tr>
                   <td style="width: 30%">
                       Transfer Function
                   </td>
                   <td style="width: 10%">
                       :
                   </td>
                   <td style="width: 60%">
                       <%= transfer%>
                   </td>
                   
               </tr>
               <tr>
                   <td style="width: 30%">
                       Operation
                   </td>
                   <td style="width: 10%">
                       :
                   </td>
                   <td style="width: 60%">
                       <%= operation%>
                   </td>
               </tr>
               <tr>
                   <td>
                       Sampling Time
                   </td>
                   <td>
                       :
                   </td>
                   <td>
                       <%= time%>
                   </td>
               </tr>
               <tr>
                   <td>
                       Set Point
                   </td>
                   <td>
                       :
                   </td>
                   <td>
                       <%= setpoint%>
                   </td>
               </tr>
               <tr>
                   <td>
                       kp
                   </td>
                   <td>
                       :
                   </td>
                   <td>
                       <%= kpval%>
                   </td>
               </tr>
               <tr>
                   <td>
                       kd
                   </td>
                   <td>
                       :
                   </td>
                   <td>
                       <%= kdval%>
                   </td>
               </tr>
               <tr>
                   <td>
                       ki
                   </td>
                   <td>
                       :
                   </td>
                   <td>
                       <%= kival%>
                   </td>
               </tr>
           </table>
       </div>
                   
       <div id ="graph2" style="width:100%; height: 30%;" >

       </div>
 
    </body>
    
    <script type="text/javascript" src="Exp7new1.js"></script>
 
</html>
