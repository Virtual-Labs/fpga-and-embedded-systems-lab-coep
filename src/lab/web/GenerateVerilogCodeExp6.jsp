<%-- 
    Document   : GenerateVerilogCodeExp6
    Created on : 5 Jan, 2012, 12:55:59 PM
    Author     : root
--%>

<%@page import="java.util.Vector"%>
<%@page import="java.math.BigInteger"%>
<%@page import="JavaFiles.Calculations"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="errorpage6.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript" src="scripts/jquery.js"></script>
        <script type="text/javascript" src="scripts/jquery-ui.js"></script>
        <style>
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
            .col{
                text-align: center;
            }
            .fontss{
                font-size: xx-small;
            }

            .matrixs{
                border-left: 1px solid #000;
                border-right: 1px solid #000;
                border-top: 0px transparent;
                border-bottom: 0px transparent;
                border-radius: 10px;
                -moz-border-radius: 10px;
                -webkit-border-radius: 10px;


            }
            .matrixs1{
                border-left: 1px solid #000;
                border-right: 1px solid #000;
                border-top: 0px transparent;
                border-bottom: 0px transparent;
                border-radius: 10px;
                -moz-border-radius: 10px;
                -webkit-border-radius: 10px;


            }

            /*            matrixs1.spaced-table td
                        {
                           
                        }*/

        </style>

        <script type="text/javascript">
        
            $(document).ready(function(){
                var url;
                $("#generate").bind({
                    
                    
                
                    click: function(){
                        var opert=$("#operta").val();
                        
                        if(opert=="Floating Point Conversion"){
                            $.ajax({
                                url: 'FloatingPointConverterCodeGenerator',
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
                        if(opert=="Floating Point Arithmetics"){
                            $.ajax({
                                url: 'FloatingPointArithmeticsCodeGenerator',
                                type: "Post",
                                success:function(e){
                                    $("#laxdivk").attr("style","display: block");
                                },
                                fail:function(e){
                                    alert("Hi");
                                    $("#laxdiv").html("Not Generated");
                                }
                            
                            });
                        }
                        
                        
                        
                    }
                
                });
            
            });
        </script>
    </head>
    <body>
        <%


            String operation = request.getParameter("op6");
        %>
        <input type="hidden" name="operta" id="operta" value="<%=operation%>" />
        <%
            if (operation.equals("Floating Point Conversion")) {
                String globalAnswer = "";
                String globalHex = "";
                String givenDecimal = request.getParameter("givendecimal").trim();
                String decs[] = givenDecimal.split("\\.");
                System.out.println(givenDecimal + "/*/*/*/*/*/*/*/*/" + givenDecimal.split(".").length);
                String subOperation = request.getParameter("subop6");
                if (subOperation.equals("IEEE 754 format Half Precision")) {

                    Float myDec = Float.parseFloat(givenDecimal);

                    int decs1 = Integer.parseInt(decs[0]);
                    int decs2 = Integer.parseInt(decs[1]);
                    String dec1 = Integer.toBinaryString(Math.abs(decs1));
                    String dec2 = Integer.toBinaryString(decs2);

                    dec2 = new Calculations().calculateBinary((Math.abs(myDec) - Math.abs(decs1)), 10);
                    System.out.println("-----------------------------" + dec2.length());
                    // out.println(dec1 + "." + dec2);
                    String ans = "";
                    int exponent = 15;
                    int shiftCount = dec1.length() - 1;
                    int signBit = 0;
                    int nlShifts = new Calculations().numberOfLeftShiftRequired(dec2);
                    String mantissa = "";
                    if (myDec > 0) {
                        if (Math.abs(decs1) > 0) {
                            mantissa = dec1.substring(1) + dec2;
                            exponent += shiftCount;
                            signBit = 0;
                        }
                        if (Math.abs(decs1) < 1) {
                            dec2 = new Calculations().calculateBinary((Math.abs(myDec) - Math.abs(decs1)), 10 + nlShifts);
                            mantissa = dec2.substring(nlShifts);
                            exponent -= nlShifts;
                            signBit = 0;
                        }
                    } else {//FOR example 0.49

                        if (Math.abs(decs1) > 0) {

                            mantissa = dec1.substring(1) + dec2;
                            exponent += shiftCount;
                            signBit = 1;
                        }
                        if (Math.abs(decs1) < 1) {
                            dec2 = new Calculations().calculateBinary((Math.abs(myDec) - Math.abs(decs1)), 10 + nlShifts);
                            mantissa = dec2.substring(nlShifts);
                            exponent -= nlShifts;
                            signBit = 1;
                        }
                    }

                    String expo = "";
                    expo = Integer.toBinaryString(exponent);
                    if (expo.length() < 5) {
                        for (int i = 0; i < 5 - expo.length(); i++) {
                            expo = "0" + expo;
                        }
                    }//exponent correction
               /* else
                    {
                    for(int i=0;i<expo.length()-5;i++)
                    {
                    expo="0"+expo;
                    }
                    }*/

                    

                    //mantissa correction
                    if (mantissa.length() > 10) {
                        mantissa = mantissa.substring(0, 10);
                    }


                    ans = signBit + expo + mantissa;
                    System.out.println("Answer = " + ans);

                    globalAnswer = ans;
                    int tempval = 0;
                    for (int j = 0; j < ans.length() - 3; j = j + 4) {
                        tempval = Integer.parseInt(ans.substring(j, j + 4), 2);
                        System.out.println(ans.substring(j, j + 4));
                        globalHex += Integer.toHexString(tempval);
                    }
                    System.out.println("*/*/*/*/*///" + globalHex);

                }//half precision ends

                if (subOperation.equals("IEEE 754 format Single Precision")) {

                    Float myDec = Float.parseFloat(givenDecimal);



                    int decs1 = Integer.parseInt(decs[0]);
                    int decs2 = Integer.parseInt(decs[1]);





                    String dec1 = Integer.toBinaryString(Math.abs(decs1));
                    String dec2 = Integer.toBinaryString(decs2);

                    dec2 = new Calculations().calculateBinary((Math.abs(myDec) - Math.abs(decs1)), 23);
                    System.out.println("-----------------------------" + dec2.length());
                    // out.println(dec1 + "." + dec2);
                    String ans = "";
                    int exponent = 127;
                    int shiftCount = dec1.length() - 1;
                    int signBit = 0;
                    int nlShifts = new Calculations().numberOfLeftShiftRequired(dec2);

                    String mantissa = "";
                    if (myDec > 0) {
                        if (Math.abs(decs1) > 0) {
                            mantissa = dec1.substring(1) + dec2;
                            exponent += shiftCount;
                            signBit = 0;
                        }
                        if (Math.abs(decs1) < 1) {
                            dec2 = new Calculations().calculateBinary((Math.abs(myDec) - Math.abs(decs1)), 23 + nlShifts);
                            mantissa = dec2.substring(nlShifts);
                            exponent -= nlShifts;
                            signBit = 0;
                        }
                    } else {//FOR example 0.49

                        if (Math.abs(decs1) > 0) {

                            mantissa = dec1.substring(1) + dec2;
                            exponent += shiftCount;
                            signBit = 1;
                        }
                        if (Math.abs(decs1) < 1) {
                            dec2 = new Calculations().calculateBinary((Math.abs(myDec) - Math.abs(decs1)), 23 + nlShifts);
                            mantissa = dec2.substring(nlShifts);
                            exponent -= nlShifts;
                            signBit = 1;
                        }
                    }

                    String expo = "";
                    expo = Integer.toBinaryString(exponent);
                    if (expo.length() < 8) {
                        for (int i = 0; i < 8 - expo.length(); i++) {
                            expo = "0" + expo;
                        }
                    }//exponent correction



                    //mantissa correction
                    if (mantissa.length() > 23) {
                        mantissa = mantissa.substring(0, 23);
                    }


                    ans = signBit + expo + mantissa;
                    System.out.println("Answer = " + ans + "   " + expo.length() + "     " + mantissa.length());

                    globalAnswer = ans;
                    int tempval = 0;
                    for (int j = 0; j < ans.length() - 3; j = j + 4) {
                        tempval = Integer.parseInt(ans.substring(j, j + 4), 2);
                        System.out.println(ans.substring(j, j + 4));
                        globalHex += Integer.toHexString(tempval);
                    }
                    System.out.println("*/*/*/*/*///" + globalHex);

                }//single ends

                if (subOperation.equals("IEEE 754 format Double Precision")) {
                    Double myDec = Double.parseDouble(givenDecimal);

                    int decs1 = Integer.parseInt(decs[0]);
                    int decs2 = Integer.parseInt(decs[1]);
                    String dec1 = Integer.toBinaryString(Math.abs(decs1));
                    String dec2 = Integer.toBinaryString(decs2);

                    dec2 = new Calculations().calculateBinary((Math.abs(myDec) - Math.abs(decs1)), 52);
                    System.out.println("-----------------------------" + dec2.length());
                    // out.println(dec1 + "." + dec2);
                    String ans = "";
                    int exponent = 1023;
                    int shiftCount = dec1.length() - 1;
                    int signBit = 0;
                    int nlShifts = new Calculations().numberOfLeftShiftRequired(dec2);
                    String mantissa = "";
                    if (myDec > 0) {
                        if (Math.abs(decs1) > 0) {
                            mantissa = dec1.substring(1) + dec2;
                            exponent += shiftCount;
                            signBit = 0;
                        }
                        if (Math.abs(decs1) < 1) {
                            dec2 = new Calculations().calculateBinary((Math.abs(myDec) - Math.abs(decs1)), 52 + nlShifts);
                            mantissa = dec2.substring(nlShifts);
                            exponent -= nlShifts;
                            signBit = 0;
                        }
                    } else {//FOR example 0.49

                        if (Math.abs(decs1) > 0) {

                            mantissa = dec1.substring(1) + dec2;
                            exponent += shiftCount;
                            signBit = 1;
                        }
                        if (Math.abs(decs1) < 1) {
                            dec2 = new Calculations().calculateBinary((Math.abs(myDec) - Math.abs(decs1)), 52 + nlShifts);
                            mantissa = dec2.substring(nlShifts);
                            exponent -= nlShifts;
                            signBit = 1;
                        }
                    }

                    String expo = "";
                    expo = Integer.toBinaryString(exponent);
                    if (expo.length() < 11) {
                        for (int i = 0; i < 11 - expo.length(); i++) {
                            expo = "0" + expo;
                        }
                    }//exponent correction
               /* else
                    {
                    for(int i=0;i<expo.length()-5;i++)
                    {
                    expo="0"+expo;
                    }
                    }*/



                    //mantissa correction
                    if (mantissa.length() > 52) {
                        mantissa = mantissa.substring(0, 52);
                    }


                    ans = signBit + expo + mantissa;
                    System.out.println("Answer = " + ans);

                    globalAnswer = ans;
                    int tempval = 0;
                    for (int j = 0; j < ans.length() - 3; j = j + 4) {
                        tempval = Integer.parseInt(ans.substring(j, j + 4), 2);
                        System.out.println(ans.substring(j, j + 4));
                        globalHex += Integer.toHexString(tempval);
                    }
                    System.out.println("*/*/*/*/*///" + globalHex);

                }//double ends

        %>
        <div>
            <table style="width :120%">
                <tr>
                    <td style="width: 20%">
                        Operation 
                    </td>
                    <td>
                        :
                    </td>
                    <td> 
                        <%=operation%>
                    </td>
                </tr>
                <tr>
                    <td>
                        Type
                    </td>
                    <td>
                        :
                    </td>
                    <td> 
                        <%=subOperation%>
                    </td>
                </tr>
                <tr>
                    <td>

                    </td>
                    <td>

                    </td>
                    <td> 

                    </td>
                </tr>
                <tr>
                    <td>
                        Your Number
                    </td>
                    <td>
                        :
                    </td>
                    <td> 
                        <%=givenDecimal%>
                    </td>
                </tr>
                <tr>
                    <td>
                        Answer
                    </td>
                    <td>
                        :
                    </td>
                    <td> 
                        <%=globalAnswer%>
                    </td>
                </tr>
                <tr>
                    <td>
                        Hex Answer
                    </td>
                    <td>
                        :
                    </td>
                    <td> 
                        <%=globalHex.toUpperCase()%>
                    </td>
                </tr>
                <tr>
                    <td>
                        Decimal Answer
                    </td>
                    <td>
                        :
                    </td>
                    <td> 
                        <%=new BigInteger(globalHex, 16).toString()%>

                    </td>
                </tr>
            </table>
        </div>
        <%

                out.println(
                        "<br><div class='rnd' id='laxdivk' style='display: none' ><strong>"
                        + "<div id='laxdiv'> Verilog code generated successfully!! "
                        + "click on Load Program tab</div>"
                        + "</strong></div>");
                out.print(
                        "<br><input class=\"buttons\" type=\"button\" name=\"gen\" id=\"generate\" value=\"Generate Verilog code\" ");
                session = request.getSession();
                session.setAttribute("operation6", operation);
                session.setAttribute("suboperation6", subOperation);
                session.setAttribute("givendec6", givenDecimal);
                session.setAttribute("globalAns6", globalAnswer);
                session.setAttribute("globalHex6", globalHex);
                session.setAttribute("setvalexp6", "true");

            }//conversion ends
            if (operation.equals("Floating Point Arithmetics")) {
                String subOperation = request.getParameter("subop61");
                String globalAnswer = "", globalHex = "";
                String givenDecimal = "";/////in this case answer is stored................................................................
                String float1 = request.getParameter("floating1");
                double f1 = Double.parseDouble(float1);
                double f2 = 0;
                if (!subOperation.equals("Square Root")) {

                    String float2 = request.getParameter("floating2");
                    f2 = Double.parseDouble(float2);
                }

                if (subOperation.equals("Addition")) {
                    double f3 = f1 + f2;
                    System.out.println("************************" + f1 + "  " + f2 + "   " + f3);
                    givenDecimal = "" + f3;
                }//addition ends
                if (subOperation.equals("Multiplication")) {
                    double f3 = f1 * f2;
                    System.out.println("************************" + f1 + "  " + f2 + "   " + f3);
                    givenDecimal = "" + f3;
                }//multiplication ends
                if (subOperation.equals("Subtraction")) {
                    double f3 = f1 - f2;
                    System.out.println("************************" + f1 + "  " + f2 + "   " + f3);
                    givenDecimal = "" + f3;
                }//subtraction ends
                if (subOperation.equals("Division")) {
                    double f3 = f1 / f2;
                    System.out.println("************************" + f1 + "  " + f2 + "   " + f3);
                    givenDecimal = "" + f3;
                }//division ends
                if (subOperation.equals("Square Root")) {
                    double f3 = Math.sqrt(f1);
                    givenDecimal = "" + f3;
                }

                String decs[] = givenDecimal.split("\\.");
                int decs1 = Integer.parseInt(decs[0]);
                int decs2 = 0;
                if (decs[1].length() == 0) {
                    decs2 = Integer.parseInt(decs[1].substring(0));

                } else if (decs[1].length() == 1) {
                    decs2 = Integer.parseInt(decs[1].substring(0));

                } else if (decs[1].length() <= 8) {
                    decs2 = Integer.parseInt(decs[1].substring(0, decs[1].length() - 1));
                } else {
                    decs2 = Integer.parseInt(decs[1].substring(0, 8));
                }
                //String givenDecimal=request.getParameter("givendecimal");
                givenDecimal = decs1 + "." + decs2;
                double myDec = Double.parseDouble(givenDecimal);









                String dec1 = Integer.toBinaryString(Math.abs(decs1));
                String dec2 = Integer.toBinaryString(decs2);

                dec2 = new Calculations().calculateBinary((Math.abs(myDec) - Math.abs(decs1)), 23);
                System.out.println("-----------------------------" + dec2.length());
                // out.println(dec1 + "." + dec2);
                String ans = "";
                int exponent = 127;
                int shiftCount = dec1.length() - 1;
                int signBit = 0;
                int nlShifts = new Calculations().numberOfLeftShiftRequired(dec2);

                String mantissa = "";
                if (myDec > 0) {
                    if (Math.abs(decs1) > 0) {
                        mantissa = dec1.substring(1) + dec2;
                        exponent += shiftCount;
                        signBit = 0;
                    }
                    if (Math.abs(decs1) < 1) {
                        dec2 = new Calculations().calculateBinary((Math.abs(myDec) - Math.abs(decs1)), 23 + nlShifts);
                        mantissa = dec2.substring(nlShifts);
                        exponent -= nlShifts;
                        signBit = 0;
                    }
                } else {//FOR example 0.49

                    if (Math.abs(decs1) > 0) {

                        mantissa = dec1.substring(1) + dec2;
                        exponent += shiftCount;
                        signBit = 1;
                    }
                    if (Math.abs(decs1) < 1) {
                        dec2 = new Calculations().calculateBinary((Math.abs(myDec) - Math.abs(decs1)), 23 + nlShifts);
                        mantissa = dec2.substring(nlShifts);
                        exponent -= nlShifts;
                        signBit = 1;
                    }
                }

                String expo = "";
                expo = Integer.toBinaryString(exponent);
                if (expo.length() < 8) {
                    for (int i = 0; i < 8 - expo.length(); i++) {
                        expo = "0" + expo;
                    }
                }//exponent correction



                //mantissa correction
                if (mantissa.length() > 23) {
                    mantissa = mantissa.substring(0, 23);
                }


                ans = signBit + expo + mantissa;
                System.out.println("Answer = " + ans + "   " + expo.length() + "     " + mantissa.length());

                globalAnswer = ans;
                int tempval = 0;
                for (int j = 0; j < ans.length() - 3; j = j + 4) {
                    tempval = Integer.parseInt(ans.substring(j, j + 4), 2);
                    System.out.println(ans.substring(j, j + 4));
                    globalHex += Integer.toHexString(tempval);
                }
                System.out.println("*/*/*/*/*///" + globalHex);



        %>

        <div>
            <table style="width :120%">
                <tr>
                    <td style="width: 20%">
                        Operation 
                    </td>
                    <td>
                        :
                    </td>
                    <td> 
                        <%=operation%>
                    </td>
                </tr>
                <tr>
                    <td>
                        Type
                    </td>
                    <td>
                        :
                    </td>
                    <td> 
                        <%=subOperation%>
                    </td>
                </tr>
                <tr>
                    <td>

                    </td>
                    <td>

                    </td>
                    <td> 

                    </td>
                </tr>
                <tr>
                    <td>
                        Your 1<sup>st</sup> Number
                    </td>
                    <td>
                        :
                    </td>
                    <td> 
                        <%=float1%>
                    </td>
                </tr>
                <%if (!subOperation.equals("Square Root")) {%>
                <tr>
                    <td>
                        Your 2<sup>nd</sup> Number
                    </td>
                    <td>
                        :
                    </td>
                    <td> 
                        <%="" + f2%>
                    </td>
                </tr>
                <%}%>
                <tr>
                    <td>
                        Answer
                    </td>
                    <td>
                        :
                    </td>
                    <td> 
                        <%=globalAnswer%>
                    </td>
                </tr>
                <tr>
                    <td>
                        Hex Answer
                    </td>
                    <td>
                        :
                    </td>
                    <td> 
                        <%=globalHex.toUpperCase()%>
                    </td>
                </tr>
                <tr>
                    <td>
                        Decimal Answer
                    </td>
                    <td>
                        :
                    </td>
                    <td> 
                        <%=new BigInteger(globalHex, 16).toString()%>

                    </td>
                </tr>
            </table>
        </div>

        <%



                out.println(
                        "<br><div class='rnd' id='laxdivk' style='display: none' ><strong>"
                        + "<div id='laxdiv'> Verilog code generated successfully!! "
                        + "click on Load Program tab</div>"
                        + "</strong></div>");
                out.print(
                        "<br><input class=\"buttons\" type=\"button\" name=\"gen\" id=\"generate\" value=\"Generate Verilog code\" ");
                session = request.getSession();
                session.setAttribute("operation6", operation);
                session.setAttribute("suboperation61", subOperation);
                session.setAttribute("givendec61", float1);
                session.setAttribute("givendec62", "" + f2);
                session.setAttribute("globalAns61", globalAnswer);
                session.setAttribute("globalHex61", globalHex);
                session.setAttribute("setvalexp6", "true");
            }//Arithmetics end
        %>
    </body>
</html>
