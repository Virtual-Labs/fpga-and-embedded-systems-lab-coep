<%-- 
    Document   : animateexp4
    Created on : 16 Jul, 2012, 1:28:57 PM
    Author     : shree
--%>

<%@page import="java.math.BigDecimal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <script type="text/javascript" src="scripts/jquery.js"></script>
        <script type="text/javascript" src="scripts/jquery-ui.js"></script>
        
        
        <%
            String clock =(String) session.getAttribute("clock");
            String device = (String) session.getAttribute("device");
            if(clock == null || clock.equals("")){
                device = "Spartan 3E(XC3S500e-4fg320) @ 50 MHz";
                clock = "50";
            }
        %>
        
        <style>
            .table
            {
                width : 100%;
            }

            .buttons{
                border-radius: 10px;
                -moz-border-radius: 10px;
                -webkit-border-radius: 10px;


                cursor: pointer;
                color:red;
                display: block;
                float: left;
                font: normal 12px arial, sans-serif;
                height: 24px;
                margin-right: 6px;
                padding-right: 18px; /* sliding doors padding */
                text-decoration: none;
            }
            .cirdiv{
                height: 20px; width: 20px; background:#00ff00; vertical-align: top;
                text-align: center;
                border-radius: 20px;
                -moz-border-radius: 20px;
                -webkit-border-radius: 20px;


                cursor: pointer;
            }
        </style>
        
        <script type="text/javascript">
            
            $(document).ready(function(){
                $(".givendecimal").bind({
                    keypress: function(e){
                        var lax1=e.which>=58;
                        var lax2=e.which<=47;
                        if(lax1 || lax2 && e.which!=8 && e.which!=9 && e.which!=46 && e.which!=45)
                        {
                            e.preventDefault();
                        }
                    }
                });
                
                $("#plot-pwm").bind({
                   click:function(){
                        valid=true;
                        var testPer = /^\d+$/;
                        
                        var lax3 = parseFloat($("#pwm-period").val());
                        var lax4 = parseFloat($("#duty-cycle").val());
                        
                        if( $("#pwm-period").val()=="" || $("#pwm-period").val()==null || 
                            $("#duty-cycle").val()=="" || $("#duty-cycle").val()==null   
                        )
                         {
                             alert("All fields are necessary");
                             valid= false;
                         }
                         
                         else if(lax3 < 0.0001 || lax3 >100){
                             alert("Invalid Input : PWM period value ranges from 0.0001 msec to 100 msec");
                             valid = false;
                         }
                         
                         else if(lax4 <1 || lax4 > 100 || !testPer.test(lax4)){
                            alert("Invalid Input : Duty Cycle value ranges from 1% to 100% integer value");
                            
                            valid = false;
                        }
                        return valid;
                   }
                });
                
            });
            
            function toggleDiv()
            {
                var pk=$("#presult").attr("Style");
                // alert(pk);
                // String ds[];
                var i=0;
                for(i=0;i<pk.split(":").length;i++ )
                {
                    if(pk.split(":")[i].trim()=="block;")
                    {
                        $("#presult").attr("Style","display : none;");
                        $("#sigdiv").attr("title","Expand All");
                        $("#sigdiv").html("+");
                    }
                    if(pk.split(":")[i].trim()=="none;")
                    {
                        $("#presult").attr("Style","display : block;");
                        $("#sigdiv").attr("title","Collapse All");
                        $("#sigdiv").html("-");
                    }
                }
            }
            
        </script>
        
    </head>
    <body>
        
        <form name="exp4" id="exp4" action="GenerateVerilogCodeExp4.jsp" method="POST">
            <div id="animate4">
                <h3>Your reference clock is <%=clock%>  MHz</h3>
                <table class="table">
                    <tr>
                        <td style="vertical-align: top;width: 20%;">
                            Enter PWM Period
                        </td>
                        <td style="vertical-align: top;width: 10%;">
                           :
                        </td>
                        <td style="vertical-align: top;width: 70%;">
                            <input type="text" name="pwm-period" class="givendecimal" id="pwm-period"/>
                            &nbsp;&nbsp;msec
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top;width: 20%;">
                            Enter PWM Duty Cycle
                        </td>
                        <td style="vertical-align: top;width: 10%;">
                            :
                        </td>
                        <td style="vertical-align: top;width: 70%;">
                            <input type="text" name="duty-cycle" id="duty-cycle" class="givendecimal"/>
                            &nbsp;&nbsp;%
                        </td>
                    </tr>
                 </table>
                <div>
                    <input class="buttons" type="submit" name="plot-pwm" id="plot-pwm" value="Calulate"/> 
                </div>
            </div>
         </form>
        
        <%
            String laxpk = (String) session.getAttribute("setvalexp4");
            if (laxpk != null) {

        %>
        
        <table width="100%">
            <tr>
                <td width="5%">
                    <div id="sigdiv" class="cirdiv" onclick="toggleDiv()" title="Collapse All">
                        -
                    </div>
                </td>
                <td width="75%">
                    <hr onclick="toggleDiv()" style="cursor: pointer">
                </td>
            </tr>
        </table>
        
        <div id="presult" style="display: block;" >
            <%
                String period = (String) session.getAttribute("pwm-period");
                String cycle = (String) session.getAttribute("pwm-cycle");
                BigDecimal frequencyCount =(BigDecimal) session.getAttribute("frequencyCount");
                BigDecimal onDutyCount = (BigDecimal) session.getAttribute("onDutyCount");
                BigDecimal offDutyCount = (BigDecimal) session.getAttribute("offDutyCount");
            %>
            
            <div>
                <table style="width :100%">
                    <tr>
                        <td style="width: 20%">
                            PWM Period 
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 70%"> 
                            <%=period%>&nbsp;&nbsp;msec
                        </td>
                    </tr>
                    <tr>
                       <td style="width: 20%">
                            PWM Duty Cycle 
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 70%"> 
                            <%=cycle%>&nbsp;&nbsp;%
                        </td> 
                    </tr>
                    <tr>
                       <td style="width: 20%">
                            Count for Frequency 
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 70%"> 
                            <%=frequencyCount%>
                        </td> 
                    </tr>
                    <tr>
                       <td style="width: 20%">
                            ON Time Count for Duty Cycle 
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 70%"> 
                            <%=onDutyCount%>
                        </td> 
                    </tr>
                    <tr>
                       <td style="width: 20%">
                            OFF Time Count for Duty Cycle 
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 70%"> 
                            <%=offDutyCount%>
                        </td> 
                    </tr>
                </table>
            </div>
            
        </div>
        
        <%
             }
        %>
        
    </body>
    
</html>
