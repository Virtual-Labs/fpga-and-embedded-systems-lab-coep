<%-- 
    Document   : GenerateVerilogCodeExp4
    Created on : 16 Jul, 2012, 2:15:55 PM
    Author     : shree
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.math.BigDecimal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript" src="scripts/jquery.js"></script>
        <script type="text/javascript" src="scripts/jquery-ui.js"></script>
<!--        <script type="text/javascript" src="Exp4pwm.js"></script>-->
<!--        <script type="text/javascript" src="scripts/FusionCharts.js"></script>
        <script type="text/javascript" src="scripts/FusionChartsExportComponent.js"></script>-->
        
        <style>
            .rnd {
                border: solid 1px black;
                height: 50px;
                width: 100%;
                border-radius: 10px;
                -moz-border-radius: 10px;
                -webkit-border-radius: 10px;
                background-color: #000;
                color: #00ff00;

                visibility: visible;
            }
            
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
        </style>
        
        <script type="text/javascript">
            $(document).ready(function(){
                var url;
                $("#generate").bind({
                    
                    click: function(){
                        $.ajax({
                            url: 'PWMController',
                            type: "Post",
                            success:function(e){
                                $("#laxdivk").attr("style","display: block");
                                parent.callFromChildPage();
                            },
                            fail:function(e){
                                alert("Hi");
                                $("#laxdiv").html("Not Generated");
                            }
                            
                        });
                    }
                });
            });
            
        </script>
    </head>
    <body>
        <%
            String period = request.getParameter("pwm-period");
            String cycle = request.getParameter("duty-cycle");
            
            session = request.getSession();
            session.setAttribute("pwm-period", period);
            session.setAttribute("pwm-cycle",cycle );
            session.setAttribute("setvalexp4", "true");
            String clock =(String) session.getAttribute("clock");
            String device = (String) session.getAttribute("device");
            
            if(clock == null || clock.equals("")){
                device = "Spartan 3E(XC3S500e-4fg320) @ 50 MHz";
                clock = "50";
            }
            
            double pt = Double.parseDouble(period);
            double pd = Double.parseDouble(cycle);
            double df = Double.parseDouble(clock);
            df= df * 100000;
            //String pd1 = Double.toString(pd);
            pt = pt / 1000;
            DecimalFormat dformat = new DecimalFormat("#.#######");
            String pt1 = dformat.format(pt);
            System.out.println("pt1 is :"+pt1);
            session.setAttribute("pwmPeriod", pt1);
            
            double pf = 1/pt;
            double fc = df/pf;
            double ondc = fc * pd/100;
            double offdc = fc - ondc;
            
            BigDecimal frequencyCount = BigDecimal.valueOf(fc);
            BigDecimal onDutyCount = BigDecimal.valueOf(ondc);
            BigDecimal offDutyCount = BigDecimal.valueOf(offdc);
            
            String freCount = Double.toString(fc);
            
            session.setAttribute("freCount",freCount );
            session.setAttribute("frequencyCount",frequencyCount );
            session.setAttribute("onDutyCount",onDutyCount );
            session.setAttribute("offDutyCount",offDutyCount );
        %>
        
        <div>
            Your Selected Device is <%=device%>
            <br/>
            <table class="table">
                
                
                <tr>
                    <td style="width: 30%">
                        Device Clock
                    </td>
                    <td style="width: 10%">
                        :
                    </td>
                    <td style="width: 60%">
                        <%=clock%>&nbsp;&nbsp;MHz
                    </td>
                </tr>
                <tr>
                    <td style="width: 30%">
                        PWM Period (PT)
                    </td>
                    <td style="width: 10%">
                        :
                    </td>
                    <td style="width: 60%">
                        <%= period%>&nbsp;&nbsp;msec
                    </td>
                </tr>
                <tr>
                    <td style="width: 30%">
                        PWM Duty Cycle (PD)
                    </td>
                    <td style="width: 10%">
                        :
                    </td>
                    <td style="width: 60%">
                        <%= cycle%>&nbsp;&nbsp;%
                    </td>
                </tr>
                <tr>
                    <td style="width: 30%">
                        Count for Frequency
                    </td>
                    <td style="width: 10%">
                        :
                    </td>
                    <td style="width: 60%">
                        <%= frequencyCount%>
                    </td>
                </tr>
                <tr>
                    <td style="width: 30%">
                        ON Time Count for Duty Cycle
                    </td>
                    <td style="width: 10%">
                        :
                    </td>
                    <td style="width: 60%">
                        <%= onDutyCount%>
                    </td>
                </tr>
                <tr>
                    <td style="width: 30%">
                        OFF Time Count for Duty Cycle
                    </td>
                    <td style="width: 10%">
                        :
                    </td>
                    <td style="width: 60%">
                        <%= offDutyCount%>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <%

                            out.println(
                                    "<br><div class='rnd' id='laxdivk' style='display: none' ><strong>"
                                    + "<div id='laxdiv'> Verilog code generated successfully!! "
                                    + "click on Load Program tab</div>"
                                    + "</strong></div>");
                            out.println(
                                    "<br><input class=\"buttons\" type=\"button\" name=\"gen\" id=\"generate\" value=\"Generate Verilog code\" ");

                            
                        %>
                    </td>
                </tr>
            </table>
        </div>
                    
<!--       <div id="chartdiv"  align="center">
           <APPLET  codebase="applet" archive="MyApplet52.jar" 
        code="PwmGraphApplet.class" width="1200" height="800">
                <PARAM name="period" value="<%=period%>">
                <PARAM name="cycle" value="<%=cycle%>">
                This page will be very boring if your 
                browser doesn't understand Java.
            </APPLET>
       </div>-->
<!--
    <div id="chartdiv" style="width:100%; height:800px;">
        
    </div>-->
                    
    </body>
</html>
