<%-- 
    Document   : animateexp7new
    Created on : 19 Apr, 2012, 11:28:41 AM
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
        <script src="highcharts.js"></script>
        <script src="exporting.js"></script>
        
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
                
                $("#opnew6").bind({
                    change:function(){
                        var selops=$("#opnew6").val();
             
                        switch(selops){
                            case 'Select':
                                $("#sec-num").attr("style","display:none");
                                $("#sec--").attr("style","display:none");
                                $("#sec-den").attr("style","display:none");
                                $("#th-num").attr("style","display:none");
                                $("#th--").attr("style","display:none");
                                $("#th-den").attr("style","display:none");
                                break;
                            
                            case 'Second Order':
                               $("#sec-num").attr("style","display:inline");
                               $("#sec--").attr("style","display:inline");
                               $("#sec-den").attr("style","display:inline");
                               $("#th-num").attr("style","display:none");
                               $("#th--").attr("style","display:none");
                               $("#th-den").attr("style","display:none");
                               break;
                            case 'Third Order':
                                $("#sec-num").attr("style","display:none")
                                $("#sec--").attr("style","display:none");
                                $("#sec-den").attr("style","display:none")
                                $("#th-num").attr("style","display:inline");
                                $("#th--").attr("style","display:inline");
                                $("#th-den").attr("style","display:inline");
                                break;
                        }
                        
                    }
                });
                
                $("#submitexpnew7").bind({
                    click:function(){
                        valid=true;
                      
                       
                        var lax2 = parseFloat($("#kp").val());
                        var lax3 = parseFloat($("#kd").val());
                        var lax4 = parseFloat($("#ki").val());
                        var lax5 = parseFloat($("#setpt").val());
                       
                        var lax1 = $("#opnew6 option:selected").text();
                       
                        if(lax1=='Select')
                        {
                            alert("Select Transfer Function");
                            valid = false;
                               
                        }
                       
                        else if( $("#kp").val()=="" || $("#kp").val()==null || 
                            $("#kd").val()=="" || $("#kd").val()==null ||
                            $("#ki").val()=="" || $("#ki").val()==null ||
                            $("#setpt").val()=="" || $("#setpt").val()==null   
                    )
                        {
                            alert("All fields are necessary");
                            valid= false;
                        }
                       
                        else if(lax5 <0 || lax5>100)
                        {
                            alert("Invalid Input : Set Point value ranges from 0 to 100 ");
                            valid = false;
                        }
                       
                        else if(lax2 <0.01 || lax2 > 100)
                        {
                            alert("Invalid Input : kp value ranges from 0.01 to 100 ");
                            valid = false;
                        }
                       
                        else if( lax3 < 0 || lax3 > 60)
                        {
                            alert("Invalid Input : kd value ranges from 0 to 60 sec ");
                            valid = false;
                        }
                       
                        else if( lax4<0.001 || lax4>100)
                        {
                            alert("Invalid Input : ki value ranges from 0.001 to 100 ");
                            valid = false;
                        }
                       
                       
                        return valid;
                       
                    } 
                });
                
                $("#oprnew7").bind({
                    change:function(){
                        hideAll();
                        var selops=$("#oprnew7").val();
                        switch(selops){
                            case 'Floating Point':
                                $("#floatingPoint").attr("style","display:block");
                                $("#fixedPoint").attr("style","display:none");
                                $("#pidSetting").attr("style","display:none");
                                $("#submitexpnew7").attr("style","display:none");
                                $("#resetexpnew7").attr("style","display:none");
                                break;
                            case 'Fixed Point':
                                $("#floatingPoint").attr("style","display:none");
                                $("#fixedPoint").attr("style","display:block");
                                $("#pidSetting").attr("style","display:block");
                                $("#submitexpnew7").attr("style","display:block");
                                $("#resetexpnew7").attr("style","display:block");
                                break;
                        }
                        
                    }
                });
                
                $("#resetexpnew7").bind({
                    click:function(){
                        $("#kp").val() = 0;
                        $("#ki").val() = 0;
                        $("#kd").val() = 0;
                    } 
                });
                
                function hideAll()
                {
                    $("#floatingPoint").attr("style","display:none");
                    $("#fixedPoint").attr("style","display:none");
                    $("#pidSetting").attr("style","display:none");
                    $("#submitexpnew7").attr("style","display:none");
                    $("#resetexpnew7").attr("style","display:none");
                }
               
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
        <form name="expnew7" id="expssnew7" action="GenerateVerilogCodeExp7new.jsp" method="POST">

            <div id="animatnew6">
                <table class="table">
                    <tr>
                        <td style="vertical-align: top;width: 20%;" >
                            Select Transfer Function
                        </td>
                        <td style="vertical-align: top;width: 10%;">
                            :
                        </td>
                        <td style="width: 70%;">
                            <table>
                                <tr>
                                    <td style="vertical-align: top">
                                        <select id="opnew6" name="opnew6">
                                            <option selected="">Select</option>
                                            <option>Second Order</option>
                                            <option>Third Order</option>
                                        </select>
                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td id="sec-num" style="display:none; vertical-align: top"> 
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1s + 1
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="sec--" style="display:none; vertical-align: top">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;----------------  
                                                </td>
                                            </tr>
                                            <tr> 
                                                <td id="sec-den" style="display:none; vertical-align: top">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s^2 + 2s + 1 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="th-num" style="display:none; vertical-align: top">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-0.1 + s
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="th--" style="display:none; vertical-align: top">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-----------------------
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="th-den" style="display:none; vertical-align: top">
                                                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s^3 + 3s^2 + 3s + 1
                                                </td>
                                            </tr>
                                        </table>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <div style="display: block">
                    <table class="table">
                        <tr>
                            <td style="width: 20%;">
                                Select Operation
                            </td>
                            <td style="width: 10%;">
                                :
                            </td>
                            <td style="width: 70%;">
                                <table>
                                    <tr>
                                        <td >
                                            <select id="oprnew7" name="oprnew7">
                                               <option selected>Fixed Point</option>
                                               <option>Floating Point</option>
                                            </select>
                                        </td>
                                    </tr>
                              <!--      <tr>
                                        <td style="display:block">
                                            <select id="typenew7" name="typenew7">
                                                <option selected>IEEE 754 format Half Precision</option>
                                                <option >IEEE 754 format Single Precision</option>
                                                <option >IEEE 754 format Double Precision</option>
                                            </select>
                                        </td>
                                    </tr>
                            -->    </table>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="pidSetting">
                    <br/><br/>
                    
                    <h4>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        
                        PID Settings :
                    </h4>
                    
                </div>
                <div id="fixedPoint">
                    <table class="table">
                        <tr>
                            <td style="width: 20%;">
                                Sampling Time
                            </td>
                            <td style="width: 10%;">
                                :
                            </td>
                            <td style="width: 70%;">
                                <select id="samp-time" name="samp-time">
                                    <option>0.001</option>
                                    <option>0.005</option>
                                    <option>0.01</option>
                                    <option>0.1</option>
                                    <option>1</option>
                                </select>
                                sec
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%;">
                                Set Point
                            </td>
                            <td style="width: 10%;">
                                :
                            </td >
                            <td style="width: 70%;">
                                <input type="text" id="setpt" value="10" name="setpt" class="givendecimal"/>
                                value ranges from 0 to 100
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%;">
                                kp
                            </td>
                            <td style="width: 10%;">
                                :
                            </td>
                            <td style="width: 70%;">
                                <input  type="text" id="kp" value="4.8007" name="kp" class="givendecimal"/>
                                value ranges from 0.01 to 100
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%;">
                                kd
                            </td>
                            <td style="width: 10%;">
                                :
                            </td>
                            <td style="width: 70%;">
                                <input  type="text" id="kd" name="kd" value="0.275" class="givendecimal"/>
                                value ranges from 0 to 60 sec
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%;">
                                ki
                            </td>
                            <td style="width: 10%;">
                                :
                            </td>
                            <td style="width: 70%;">
                                <input  type="text" id="ki" name="ki" value="0.0026" class="givendecimal"/>
                                value ranges from 0.001 to 100
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="floatingPoint" style="display:none; vertical-align: top">
                    <h4 align="center">Under Construction</h4>
                </div>
                <div>
                    <br>
                    <input class="buttons" type="submit" id="submitexpnew7" value="Calculate" />
                    <input class="buttons" type="reset" id="resetexpnew7" value="Clear" />
                </div>
            </div>
        </form>

        <%
            String laxpk = (String) session.getAttribute("setvalexp7");
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
                String transfer = (String) session.getAttribute("transferFunction");
                String operation = (String) session.getAttribute("operation");
                
                String time = (String) session.getAttribute("samplingTime");
                String setpoint = (String) session.getAttribute("setPoint");
                String kpval = (String) session.getAttribute("kp");
                String kdval = (String) session.getAttribute("kd");
                String kival = (String) session.getAttribute("ki");
            %>

            <div>
                <table style="width :100%">
                    <tr>
                        <td style="width: 20%">
                            Transfer Function 
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 70%"> 
                            <%=transfer%>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 20%">
                            Operation 
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 70%"> 
                            <%=operation%>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 20%">
                            Sampling Time 
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 70%"> 
                            <%=time%>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 20%">
                            Set Point 
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 70%"> 
                            <%=setpoint%>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 20%">
                            kp 
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 70%"> 
                            <%=kpval%>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 20%">
                            kd 
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 70%"> 
                            <%=kdval%>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 20%">
                            ki 
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 70%"> 
                            <%=kival%>
                        </td>
                    </tr>
                </table>
            </div>
                        
            
        </div>
        <div id="graph" style="width:100%; height: 30%">
               
        </div>                
                        
        <%



            }

        %>
        
    </body>
    <script type="text/javascript" src="Exp7new2.js"></script>
</html>
