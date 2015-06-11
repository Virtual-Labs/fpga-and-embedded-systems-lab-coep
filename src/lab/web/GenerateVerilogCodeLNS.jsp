<%-- 
    Document   : GenerateVerilogCodeLNS
    Created on : 26 Jul, 2012, 11:50:54 AM
    Author     : shree
--%>

<%@page import="java.math.BigInteger"%>
<%@page import="JavaFiles.Calculations"%>
<%@page import="jsc.util.Logarithm"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <script type="text/javascript" src="scripts/jquery.js"></script>
        <script type="text/javascript" src="scripts/jquery-ui.js"></script>

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

            .division{
                border:1px solid black;
                border-collapse:collapse;
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
                $("#generate").bind({
                    
                    click: function(){
                        $.ajax({
                            url: 'LNSController',
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
            String operation = request.getParameter("opLNS");
            System.out.println("operation :" + operation);

            session.setAttribute("selected-op", operation);
            session.setAttribute("setvalexpLNS", "true");
        %>
        <input type="hidden" name="operta" id="operta" value="<%=operation%>" />
        <%
            double ans = 0;
            String givenDecimal = "";
            String globalAnswer = "";
            String globalHex = "";
            Logarithm l = new Logarithm(2.0);
            if (operation.equals("Log of a Number (Base 2)") || operation.equals("Antilog of a Number (Base 2)")) {
                String number = "";
                double num = 0;
                if (operation.equals("Log of a Number (Base 2)")) {
                    number = request.getParameter("decimal-number");
                    num = Double.parseDouble(number);
                    ans = Math.log(num) / Math.log(2);
                    System.out.println("Ans :" + ans);

                    givenDecimal = "" + ans;
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
                    String ans1 = "";
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


                    ans1 = signBit + expo + mantissa;
                    System.out.println("Answer = " + ans1 + "   " + expo.length() + "     " + mantissa.length());

                    globalAnswer = ans1;
                    int tempval = 0;
                    for (int j = 0; j < ans1.length() - 3; j = j + 4) {
                        tempval = Integer.parseInt(ans1.substring(j, j + 4), 2);
                        System.out.println(ans1.substring(j, j + 4));
                        globalHex += Integer.toHexString(tempval);
                    }
                    System.out.println("*/*/*/*/*///" + globalHex);

                } else if (operation.equals("Antilog of a Number (Base 2)")) {
                    number = request.getParameter("decimal-number");
                    num = Double.parseDouble(number);
                    ans = l.antilog(num);
                    System.out.println("Ans :" + ans);

                    givenDecimal = "" + ans;
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
                    String ans1 = "";
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


                    ans1 = signBit + expo + mantissa;
                    System.out.println("Answer = " + ans1 + "   " + expo.length() + "     " + mantissa.length());

                    globalAnswer = ans1;
                    int tempval = 0;
                    for (int j = 0; j < ans1.length() - 3; j = j + 4) {
                        tempval = Integer.parseInt(ans1.substring(j, j + 4), 2);
                        System.out.println(ans1.substring(j, j + 4));
                        globalHex += Integer.toHexString(tempval);
                    }
                    System.out.println("*/*/*/*/*///" + globalHex);
                }
        %>

        <div>
            <table>
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
                    <td style="width: 30%">
                        Your Number
                    </td>
                    <td style="width: 10%">
                        :
                    </td>
                    <td style="width: 60%">
                        <%= number%>
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
                        <%= ans%>
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
                        <%=globalHex.toUpperCase()%>
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
                        <%=new BigInteger(globalHex, 16).toString()%>
                    </td>
                </tr>
            </table>
        </div>

        <%
                session.setAttribute("number-log", number);
                session.setAttribute("answer", ans);
                session.setAttribute("globalHex", globalHex);

                out.println(
                        "<br><div class='rnd' id='laxdivk' style='display: none' ><strong>"
                        + "<div id='laxdiv'> Verilog code generated successfully!! "
                        + "click on Load Program tab</div>"
                        + "</strong></div>");
                out.print(
                        "<br><input class=\"buttons\" type=\"button\" name=\"gen\" id=\"generate\" value=\"Generate Verilog code\" ");
            }
            if (operation.equals("Division")) {
                String number1 = request.getParameter("decimal-number-1");
                String number2 = request.getParameter("decimal-number-2");
                double num1 = Double.parseDouble(number1);
                double num2 = Double.parseDouble(number2);

                double log1 = Math.log(num1) / Math.log(2);
                double log2 = Math.log(num2) / Math.log(2);
                double temp = log1 - log2;
                ans = l.antilog(temp);
                System.out.println("ans : " + ans);

                givenDecimal = "" + ans;
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
                String ans1 = "";
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


                ans1 = signBit + expo + mantissa;
                System.out.println("Answer = " + ans1 + "   " + expo.length() + "     " + mantissa.length());

                globalAnswer = ans1;
                int tempval = 0;
                for (int j = 0; j < ans1.length() - 3; j = j + 4) {
                    tempval = Integer.parseInt(ans1.substring(j, j + 4), 2);
                    System.out.println(ans1.substring(j, j + 4));
                    globalHex += Integer.toHexString(tempval);
                }
                System.out.println("*/*/*/*/*///" + globalHex);

        %>
        <div>
            <table>
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
                    <td style="width: 30%">
                        Your Dividend
                    </td>
                    <td style="width: 10%">
                        :
                    </td>
                    <td style="width: 60%">
                        <%= number1%>
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
                        <%= number2%>
                    </td>
                </tr>
            </table>
            <div>
                <u><h4>Step 1 :</h4></u>
                <table class="division" style="margin-left: 20px">
                    <tr class="division">
                        <th class="division" style="width: 20%">

                        </th>
                        <th class="division" style="width: 40%">
                            Dividend
                        </th>
                        <th class="division" style="width: 40%">
                            Divisor
                        </th>
                    </tr>
                    <tr class="division">
                        <td class="division" style="width: 20%">
                            Log<sub> 2</sub>
                        </td>
                        <td class="division" style="width: 40%">
                            <%= log1%>
                        </td>
                        <td class="division" style="width: 40%">
                            <%= log2%>
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <u><h4>Step 2 :</h4></u>
                <table style="margin-left: 20px">
                    <tr>
                        <td style="width: 30%">
                            Log<sub> 2</sub> Difference
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%= temp%> 
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <u><h4>Step 3 :</h4></u>
                <table style="margin-left: 20px">
                    <tr>
                        <td style="width: 30%">
                            Antilog<sub> 2</sub>
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%= ans%> 
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <br/><br/>
                <table>
                    <tr>
                        <td style="width: 30%">
                            Answer
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%= ans%> 
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
                            <%=globalHex.toUpperCase()%>
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
                            <%=new BigInteger(globalHex, 16).toString()%>
                        </td>
                    </tr>
                </table>

            </div>
        </div>
        <%


                session.setAttribute("number-div-1", number1);
                session.setAttribute("number-div-2", number2);
                session.setAttribute("number-div-11", num1);
                session.setAttribute("number-div-22", num2);
                session.setAttribute("answer", ans);
                session.setAttribute("globalHex", globalHex);

                out.println(
                        "<br><div class='rnd' id='laxdivk' style='display: none' ><strong>"
                        + "<div id='laxdiv'> Verilog code generated successfully!! "
                        + "click on Load Program tab</div>"
                        + "</strong></div>");
                out.print(
                        "<br><input class=\"buttons\" type=\"button\" name=\"gen\" id=\"generate\" value=\"Generate Verilog code\" ");
            }
            if (operation.equals("Square Root")) {
                String numberSq = request.getParameter("decimal-number");
                double numSq = Double.parseDouble(numberSq);
                double numSqLog = Math.log(numSq) / Math.log(2);
                double tempSq = numSqLog / 2;
                ans = l.antilog(tempSq);
                System.out.println("ans: " + ans);

                givenDecimal = "" + ans;
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
                String ans1 = "";
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


                ans1 = signBit + expo + mantissa;
                System.out.println("Answer = " + ans1 + "   " + expo.length() + "     " + mantissa.length());

                globalAnswer = ans1;
                int tempval = 0;
                for (int j = 0; j < ans1.length() - 3; j = j + 4) {
                    tempval = Integer.parseInt(ans1.substring(j, j + 4), 2);
                    System.out.println(ans1.substring(j, j + 4));
                    globalHex += Integer.toHexString(tempval);
                }
                System.out.println("*/*/*/*/*///" + globalHex);
        %>
        <div>
            <div>
                <table>
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
                        <td style="width: 30%">
                            Your Number
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%= numberSq%>
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <u><h4>Step 1 :</h4></u>
                <table style="margin-left: 20px">
                    <tr>
                        <td style="width: 30%">
                            Log<sub> 2</sub> of number
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%= numSqLog%> 
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <u><h4>Step 2 :</h4></u>
                <table style="margin-left: 20px">
                    <tr>
                        <td style="width: 30%">
                            Divide log<sub> 2</sub> by 2
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%= tempSq%> 
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <u><h4>Step 3 :</h4></u>
                <table style="margin-left: 20px">
                    <tr>
                        <td style="width: 30%">
                            Antilog<sub> 2</sub>
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%= ans%> 
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <br/><br/>
                <table>
                    <tr>
                        <td style="width: 30%">
                            Answer
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%= ans%> 
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
                            <%=globalHex.toUpperCase()%>
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
                            <%=new BigInteger(globalHex, 16).toString()%>
                        </td>
                    </tr>
                </table>

            </div>
        </div>
        <%


                session.setAttribute("number-sq", numberSq);

                session.setAttribute("number-sq-1", numSq);
                session.setAttribute("answer", ans);
                session.setAttribute("globalHex", globalHex);

                out.println(
                        "<br><div class='rnd' id='laxdivk' style='display: none' ><strong>"
                        + "<div id='laxdiv'> Verilog code generated successfully!! "
                        + "click on Load Program tab</div>"
                        + "</strong></div>");
                out.print(
                        "<br><input class=\"buttons\" type=\"button\" name=\"gen\" id=\"generate\" value=\"Generate Verilog code\" ");
            }
            if (operation.equals("Power")) {
                String numberPower = request.getParameter("decimal-number");
                String powerFactor = request.getParameter("decimal-number-3");
                double numPower = Double.parseDouble(numberPower);
                double numFactor = Double.parseDouble(powerFactor);
                double numPowerLog = Math.log(numPower) / Math.log(2);
                double tempPower = numFactor * numPowerLog;
                ans = l.antilog(tempPower);
                System.out.println("ans :" + ans);

                givenDecimal = "" + ans;
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
                String ans1 = "";
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


                ans1 = signBit + expo + mantissa;
                System.out.println("Answer = " + ans1 + "   " + expo.length() + "     " + mantissa.length());

                globalAnswer = ans1;
                int tempval = 0;
                for (int j = 0; j < ans1.length() - 3; j = j + 4) {
                    tempval = Integer.parseInt(ans1.substring(j, j + 4), 2);
                    System.out.println(ans1.substring(j, j + 4));
                    globalHex += Integer.toHexString(tempval);
                }
                System.out.println("*/*/*/*/*///" + globalHex);
        %>
        <div>
            <div>
                <table>
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
                        <td style="width: 30%">
                            Your Number
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%= numberPower%>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 30%">
                            Power Factor
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%= powerFactor%>
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <u><h4>Step 1 :</h4></u>
                <table style="margin-left: 20px">
                    <tr>
                        <td style="width: 30%">
                            Log<sub> 2</sub> of <%=numberPower%>
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%= numPowerLog%> 
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <u><h4>Step 2 :</h4></u>
                <table style="margin-left: 20px">
                    <tr>
                        <td style="width: 30%">
                            Multiply log<sub> 2</sub> by Power Factor (<%=powerFactor%>)
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%= tempPower%> 
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <u><h4>Step 3 :</h4></u>
                <table style="margin-left: 20px">
                    <tr>
                        <td style="width: 30%">
                            Antilog<sub> 2</sub>
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%= ans%> 
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <br/><br/>
                <table>
                    <tr>
                        <td style="width: 30%">
                            Answer
                        </td>
                        <td style="width: 10%">
                            :
                        </td>
                        <td style="width: 60%">
                            <%= ans%> 
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
                            <%=globalHex.toUpperCase()%>
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
                            <%=new BigInteger(globalHex, 16).toString()%>
                        </td>
                    </tr>
                </table>

            </div>
        </div>
        <%


                session.setAttribute("number-pow", numberPower);
                session.setAttribute("number-pow-factor", powerFactor);
                session.setAttribute("answer", ans);
                session.setAttribute("globalHex", globalHex);

                out.println(
                        "<br><div class='rnd' id='laxdivk' style='display: none' ><strong>"
                        + "<div id='laxdiv'> Verilog code generated successfully!! "
                        + "click on Load Program tab</div>"
                        + "</strong></div>");
                out.print(
                        "<br><input class=\"buttons\" type=\"button\" name=\"gen\" id=\"generate\" value=\"Generate Verilog code\" ");
            }
        %>
    </body>
</html>
