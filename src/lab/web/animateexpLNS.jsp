<%-- 
    Document   : animateexpLNS
    Created on : 26 Jul, 2012, 11:34:44 AM
    Author     : shree
--%>

<%@page import="java.math.BigInteger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <script type="text/javascript" src="scripts/jquery.js"></script>
        <script type="text/javascript" src="scripts/jquery-ui.js"></script>

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
                
                $("#opLNS").bind({
                    change:function(){
                        hideAll();
                        var selops=$("#opLNS").val();
                         
                        switch(selops){
                            case 'Log of a Number (Base 2)':
                                $("#decimal-div").attr("style","display:inline");
                                $("#decimal-div-1").attr("style","display:none");
                                $("#decimal-div-2").attr("style","display:none");
                                $("#decimal-div-3").attr("style","display:none");
                                break;
                               
                            case 'Antilog of a Number (Base 2)':
                                $("#decimal-div").attr("style","display:inline");
                                $("#decimal-div-1").attr("style","display:none");
                                $("#decimal-div-2").attr("style","display:none");
                                $("#decimal-div-3").attr("style","display:none");
                                break;
                               
                            case 'Division':
                                $("#decimal-div").attr("style","display:none");
                                $("#decimal-div-1").attr("style","display:inline");
                                $("#decimal-div-2").attr("style","display:inline");
                                $("#decimal-div-3").attr("style","display:none");
                                break;
                               
                            case 'Square Root':
                                $("#decimal-div").attr("style","display:inline");
                                $("#decimal-div-1").attr("style","display:none");
                                $("#decimal-div-2").attr("style","display:none");
                                $("#decimal-div-3").attr("style","display:none");
                                break;
                               
                            case 'Power':
                                $("#decimal-div").attr("style","display:inline");
                                $("#decimal-div-1").attr("style","display:none");
                                $("#decimal-div-2").attr("style","display:none");
                                $("#decimal-div-3").attr("style","display:inline");
                                break;
                        }
                    }
                });
                 
                $("#submitexpLNS").bind({
                    click:function(){
                        valid=true;
                        var testPer = /^\d+$/;
                          
                        var lax3 = parseFloat($("#decimal-number").val());
                        var lax4 = parseFloat($("#decimal-number-1").val());
                        var lax5 = parseFloat($("#decimal-number-2").val());
                        var lax6 = parseFloat($("#decimal-number-3").val());
                        
                        var selops=$("#opLNS").val();
                        
                        if(selops == "Division"){
                            if($("#decimal-number-1").val()=="" || $("#decimal-number-1").val()==null ||
                                $("#decimal-number-2").val()=="" || $("#decimal-number-2").val()==null)
                            {
                                alert("All fields are necessary");
                                valid= false;
                                
                            }
                        }else if(selops == "Power"){
                            if($("#decimal-number").val()=="" || $("#decimal-number").val()==null ||
                                $("#decimal-number-3").val()=="" || $("#decimal-number-3").val()==null)
                            {
                                alert("All fields are necessary");
                                valid= false;
                                
                            }else if(!testPer.test(lax6)){
                                alert("Invalid Input : Enter Power field value in integer");
                            
                                valid = false;
                            }
                        }else{
                            if($("#decimal-number").val()=="" || $("#decimal-number").val()==null)
                            {
                                alert("All fields are necessary");
                                valid= false;
                            }  
                        }
                        
                        
                        
                        return valid;
                    }
                });
                  
                
            });
            
            function hideAll()
            {
                $("#decimal-div").attr("style","display:none");
                $("#decimal-div-1").attr("style","display:none");
                $("#decimal-div-2").attr("style","display:none");
                $("#decimal-div-3").attr("style","display:none");
            }
            
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
        <form name="expLNS" id="expLNS" action="GenerateVerilogCodeLNS.jsp" method="POST">
            <div id="animateLNS">
                <div>
                    <table class="table" >
                        <tr>
                            <td style="vertical-align: top;width: 30%;">
                                Select Operation
                            </td>
                            <td style="vertical-align: top;width: 10%;">
                                :
                            </td>
                            <td style="vertical-align: top;width: 60%;">
                                <select id="opLNS" name="opLNS">
                                    <option selected>Log of a Number (Base 2)</option>
                                    <option>Antilog of a Number (Base 2)</option>
                                    <option>Division</option>
                                    <option>Square Root</option>
                                    <option>Power</option>
                                </select>
                            </td>
                        </tr>
                    </table>
                </div>

                <div id ="decimal-div">
                    <table class="table">
                        <tr id="decimal-row" >
                            <td style="vertical-align: top;width: 30%;">
                                Enter number in Decimal
                            </td>
                            <td style="vertical-align: top;width: 10%;">
                                :
                            </td>
                            <td style="vertical-align: top;width: 60%;">
                                <input type="text" name="decimal-number" class="givendecimal" id="decimal-number" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div id ="decimal-div-1" style="display: none">
                    <table class="table" >
                        <tr id="decimal-row-1" >
                            <td style="vertical-align: top;width: 30%;">
                                Enter Dividend in Decimal
                            </td>
                            <td style="vertical-align: top;width: 10%;">
                                :
                            </td>
                            <td style="vertical-align: top;width: 60%;">
                                <input type="text" name="decimal-number-1" class="givendecimal" id="decimal-number-1" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div id ="decimal-div-2" style="display: none">
                    <table class="table" >
                        <tr>
                            <td style="vertical-align: top;width: 30%;">
                                Enter Divisor in Decimal
                            </td>
                            <td style="vertical-align: top;width: 10%;">
                                :
                            </td>
                            <td style="vertical-align: top;width: 60%;">
                                <input type="text" name="decimal-number-2" class="givendecimal" id="decimal-number-2" />
                            </td>
                        </tr>

                    </table>

                </div>
                <div id ="decimal-div-3" style="display: none">
                    <table class="table" >
                        <tr>
                            <td style="vertical-align: top;width: 30%;">
                                Enter Power
                            </td>
                            <td style="vertical-align: top;width: 10%;">
                                :
                            </td>
                            <td style="vertical-align: top;width: 60%;">
                                <input type="text" name="decimal-number-3" class="givendecimal" id="decimal-number-3" />
                            </td>
                        </tr>

                    </table>

                </div>
            </div>
            <div>
                <br>
                <input class="buttons" type="submit" id="submitexpLNS" value="Calculate" />
                <input class="buttons" type="reset" id="resetexpLNS" value="Clear" />
            </div>
        </form>

        <%
            String laxpk = (String) session.getAttribute("setvalexpLNS");
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
                String op = (String) session.getAttribute("selected-op");
                if (op.equals("Antilog of a Number (Base 2)") || op.equals("Log of a Number (Base 2)")) {
                    String num = (String) session.getAttribute("number-log");
                    double ans = (Double) session.getAttribute("answer");
                    String globalHexadecimal =(String) session.getAttribute("globalHex");
            %>

            <div>
                <table>
                    <tr>
                        <td style="width: 30%">
                            Selected Operation
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%=op%>
                        </td>

                    </tr>
                    <tr>
                        <td style="width: 30%">
                            Your Number
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%=num%>
                        </td>

                    </tr>
                    <tr>
                        <td style="width: 30%">
                            Answer
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%=ans%>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 30%">
                            Hexadecimal Equivalent
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%=globalHexadecimal.toUpperCase()%>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 30%">
                            Decimal Equivalent
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%=new BigInteger(globalHexadecimal, 16).toString()%>
                        </td>
                    </tr>
                </table>
            </div>

            <%
                }
                if (op.equals("Division")) {
                    String num1 = (String) session.getAttribute("number-div-1");
                    String num2 = (String) session.getAttribute("number-div-2");
                    double ans = (Double) session.getAttribute("answer");
                    String globalHexadecimal =(String) session.getAttribute("globalHex");
            %>
            <div>
                <table>
                    <tr>
                        <td style="width: 30%">
                            Selected Operation
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%=op%>
                        </td>

                    </tr>
                    <tr>
                        <td style="width: 30%">
                            Your Dividend
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%=num1%>
                        </td>

                    </tr>
                    <tr>
                        <td style="width: 30%">
                            Your Divisor
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%=num2%>
                        </td>

                    </tr>
                    <tr>
                        <td style="width: 30%">
                            Answer
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%=ans%>
                        </td>

                    </tr>
                    <tr>
                        <td style="width: 30%">
                            Hexadecimal Equivalent
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%=globalHexadecimal.toUpperCase()%>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 30%">
                            Decimal Equivalent
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%=new BigInteger(globalHexadecimal, 16).toString()%>
                        </td>
                    </tr>
                </table>
            </div>
            <%
                }
                if (op.equals("Square Root")) {
                    String num = (String) session.getAttribute("number-sq");
                    double ans = (Double) session.getAttribute("answer");
                    String globalHexadecimal =(String) session.getAttribute("globalHex");
            %>
            <div>
                <table>
                    <tr>
                        <td style="width: 30%">
                            Selected Operation
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%=op%>
                        </td>

                    </tr>
                    <tr>
                        <td style="width: 30%">
                            Your Number
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%=num%>
                        </td>

                    </tr>
                    <tr>
                        <td style="width: 30%">
                            Answer
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%=ans%>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 30%">
                            Hexadecimal Equivalent
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%=globalHexadecimal.toUpperCase()%>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 30%">
                            Decimal Equivalent
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%=new BigInteger(globalHexadecimal, 16).toString()%>
                        </td>
                    </tr>
                </table>
            </div>
            <%
                }
                if (op.equals("Power")) {
                    String num = (String) session.getAttribute("number-pow");
                    double ans = (Double) session.getAttribute("answer");
                    String globalHexadecimal =(String) session.getAttribute("globalHex");
            %>
            <div>
                <table>
                    <tr>
                        <td style="width: 30%">
                            Selected Operation
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%=op%>
                        </td>

                    </tr>
                    <tr>
                        <td style="width: 30%">
                            Your Number
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%=num%>
                        </td>

                    </tr>
                    <tr>
                        <td style="width: 30%">
                            Answer
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%=ans%>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 30%">
                            Hexadecimal Equivalent
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%=globalHexadecimal.toUpperCase()%>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 30%">
                            Decimal Equivalent
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%=new BigInteger(globalHexadecimal, 16).toString()%>
                        </td>
                    </tr>
                </table>
            </div>
            <%
                }
            %>
        </div>

        <%
            }
        %>

    </body>
</html>
