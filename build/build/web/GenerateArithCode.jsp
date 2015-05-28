<%-- 
    Document   : GenerateArithCode
    Created on : 8 Dec, 2011, 5:41:19 PM
    Author     : root

for exp 2
--%>

<%@page import="JavaFiles.Calculations"%>
<%@page import="javax.script.ScriptEngine"%>
<%@page import="javax.script.ScriptEngineManager"%>
<%@page import="org.apache.jasper.el.ExpressionEvaluatorImpl"%>
<%@page import="java.io.PrintStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="JavaFiles.ExpressionEvaluator"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="errorexp2.jsp"%>
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


        </style>

        <script type="text/javascript">
        
            $(document).ready(function(){
                //alert();
                var opert=$("#operat").val();
                //alert(opert);
                var url;
                $("#generate").bind({
                
                    click: function(){
                        //alert();
                        if (window.XMLHttpRequest)
                        {// code for IE7+, Firefox, Chrome, Opera, Safari
                            xmlhttp=new XMLHttpRequest();
                        }
                        else
                        {// code for IE6, IE5
                            xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                        }
                        //alert(opert);
                        if(opert=="Arithmetical Operation"){
                            // alert("hi");
                            url="arithSave.jsp";
                        
                            //alert(url);
                        
                         
                        }
                        if(opert=="Shift Operation"){
                            // alert("hi");
                            var par=$("#bitlength").val();
                            var pa1=$("#shiftType").val();
                            var pa2=$("#dataType").val();
                            url="shiftSave.jsp?length="+par+"&shiftType="+pa1+"&datatype="+pa2;
                        
                            //alert(url);
                        
                         
                        }
                        if(opert=="Relational Operation"){
                            // alert("hi");
                            var par=$("#da1").val();
                            var par1=$("#da2").val();
                            var par2=$("#dp1").val();
                            var par3=$("#dp2").val();
                            var par4=$("#dc1").val();
                            url="relationalSave.jsp?data1="+par+"&data2="+par1+"&type1="+par2+"&type2="+par3+"&operator="+par4;
                        
                            //alert(url);
                        
                         
                        }
                        if(opert=="Bitwise Operation"){
                            url="bitwiseSave.jsp";
                        }
                        if(opert=="Logical Operation"){
                            url="logicalSave.jsp";
                        }
                        if(opert=="Reduction Operation"){
                            url="reductionSave.jsp";
                        }
                        xmlhttp.open("GET",url,false);
                        xmlhttp.send(null);
                        
                        parent.callFromChildPage();
                        $("#laxdivk").attr("style","display: block");
                    }
                
                });
            
            });
        </script>
    </head>
    <body>
        <%


            String operType = request.getParameter("selops");

        %>
        <input type="hidden" name="operat" id="operat" value="<%=operType%>" />
        <%

            if (operType.equals("Arithmetical Operation")) {
                String expr = request.getParameter("labelarith");
                int counter = 1;
                int num = 0;

                String[] vals = expr.split(" ");
                String[] allexprs = new String[100];
                allexprs = new ExpressionEvaluator().evaluate(vals, expr);
                for (int i = 1; i < allexprs.length; i++) {
                    if (allexprs[i] == null) {
                        break;
                    }
                    counter++;
                }
                String[] allexprsfinal = new String[counter + 1];
                System.out.println("***************" + counter);

                for (int i = 0; i < allexprs.length; i++) {
                    if (allexprs[i] == null) {
                        break;
                    }
                    allexprsfinal[i] = allexprs[i];
                }
                session = request.getSession();
                session.setAttribute("arithans", allexprsfinal);
                session.setAttribute("arithansar", allexprs);
                for (int i = 1; i < allexprs.length; i++) {
                    if (allexprs[i] == null) {
                        break;
                    }
                    counter++;
                }

                /**/

                ScriptEngineManager sem = new ScriptEngineManager();
                ScriptEngine se = sem.getEngineByName("js");
                Object result = null;

                result = se.eval(allexprs[0]);

                //System.out.println("*************\n\n\n"+(Integer)result+"\n\n\n*********");


                /**/
//for(i=)
                // for(int i=0;i<vals.length;i++)
                //  System.out.println(vals[i]);
%>

        <div>
            <table>
                <tr>
                    <td>Your Expression  </td>
                    <td>:</td>
                    <td><%=allexprs[0]%>
                </tr>

                <%
                    for (int i = 1; i < allexprs.length; i++) {
                        if (allexprs[i] == null) {
                            break;
                        }

                %>
                <tr>
                    <td>Priority <%=i%>

                    </td>
                    <td>:</td>
                    <td><%=allexprs[i]%>

                </tr>

                <%
                        num = i;//last

                    }


                %>
                <tr>
                    <td>Answer

                    </td>
                    <td>:</td>
                    <td><%=allexprs[num].split("=")[0].charAt(0)%>&nbsp;=&nbsp;<%=String.valueOf(result)%></td>

                </tr>
            </table>
            <%
                    session.setAttribute("arithres", result);
                } //Arithmetical operations end

                if (operType.equals("Shift Operation")) {
                    Object answer = "";
                    String data = request.getParameter("soptxt");
                    String dataType = request.getParameter("sdtype");
                    int lebg = 0;
            %>
            <input type="hidden" id="dataType" name="dataType" value="<%=dataType%>" />
            <%
                String shiftType = request.getParameter("shift");
                String nShifts = request.getParameter("nshifts");
                String charl = "", shiftSymbol = ">>";
                String expr = "";


                if (dataType.equals("Binary")) {
                    charl = "b";
                    lebg = data.length();
                    if (shiftType.equals("Left")) {
                        shiftSymbol = "<<";
                        expr = " " + data.length() + "'" + charl + data + " " + shiftSymbol + " " + nShifts;
                        Calculations cal = new Calculations();

                        int arr[] = cal.toIntArray(data);

                        int num = Integer.valueOf(nShifts);
                        answer = cal.toString(cal.leftShift(arr, num));

                    } else {
                        shiftSymbol = ">>";
                        expr = " " + data.length() + "'" + charl + data + " " + shiftSymbol + " " + nShifts;
                        Calculations cal = new Calculations();
                        int arr[] = cal.toIntArray(data);
                        int num = Integer.valueOf(nShifts);
                        answer = cal.toString(cal.rightShift(arr, num));
                    }
                } else {
                    charl = "d";
                    lebg = 16;
                    if (shiftType.equals("Left")) {//to be changed for decimals
                        shiftSymbol = "<<";
                        expr = " " + data + " " + shiftSymbol + " " + nShifts;
                        ScriptEngineManager sem = new ScriptEngineManager();
                        ScriptEngine se = sem.getEngineByName("js");


                        answer = se.eval(expr);

                        //answer = cal.toString(cal.leftShift(arr, num));

                    } else {
                        shiftSymbol = ">>";
                        expr = " " + data + " " + shiftSymbol + " " + nShifts;
                        Calculations cal = new Calculations();
                        ScriptEngineManager sem = new ScriptEngineManager();
                        ScriptEngine se = sem.getEngineByName("js");


                        answer = se.eval(expr);
                    }
                }
                //String result="Lax";



            %>
            <input type="hidden" id="shiftType" name="shiftType" value="<%=shiftType%>" />
            <input type="hidden" id="bitlength" name="bitlength" value="<%=lebg%>" />
            <div>
                <table>
                    <tr>
                        <td>
                            Your Expression : 
                        </td>
                        <td>
                            a=<%=expr%>
                        </td>

                    </tr>
                    <tr>
                        <td>
                            Answer : 
                        </td>
                        <td>
                            a=<%=" " + String.valueOf(answer)%>
                        </td>

                    </tr>
                </table>
            </div>



            <%

                    session.setAttribute("exprs", expr);
                    session.setAttribute("shiftanswer", answer);

                }//Shift operation end

                if (operType.equals("Bitwise Operation")) {

                    String answer = "";
                    String data1 = request.getParameter("textbit");
                    String data2 = "";
                    int dat2[] = new int[data1.length()];
                    String operator = request.getParameter("bitopsub");
                    Calculations cal = new Calculations();


                    if (!operator.equals("NEGATION")) {
                        data2 = request.getParameter("textbit2");

                        int k = data1.length() - data2.length();
                        if (k < 0) {

                            dat2 = new int[data2.length()];
                            for (int i = 0; i < Math.abs(k); i++) {

                                data1 = "0" + data1;
                            }

                        }
                        if (k > 0) {

                            dat2 = new int[data1.length()];
                            for (int i = 0; i < k; i++) {
                                data2 = "0" + data2;

                            }
                        }
                        dat2 = cal.toIntArray(data2);
                    }



                    int lax[] = new int[data1.length()];

                    int dat1[] = cal.toIntArray(data1);

                    if (operator.equals("AND")) {
                        lax = cal.bitwiseAND(dat1, dat2);

                    }
                    if (operator.equals("OR")) {
                        lax = cal.bitwiseOR(dat1, dat2);
                    }
                    if (operator.equals("XOR")) {
                        lax = cal.bitwiseXOR(dat1, dat2);
                    }
                    if (operator.equals("NOR")) {
                        lax = cal.bitwiseXNOR(dat1, dat2);
                    }
                    if (operator.equals("NEGATION")) {
                        lax = cal.bitwiseNOT(dat1);

                    }
                    answer = cal.toString(lax);

            %>

            <div>
                <table>
                    <tr>
                        <td class="col">
                            Data 
                        </td>
                        <td class="col">
                            Operator
                        </td>
                        <%if (!operator.equals("NEGATION")) {
                        %>
                        <td class="col">
                            Data 
                        </td>
                        <%}%>
                        <td>
                            &nbsp;
                        </td>

                        <td class="col">
                            Answer
                        </td>

                    </tr>
                    <tr>
                        <td class="col">
                            <%=data1%> 
                        </td>
                        <td class="col">
                            <%=operator%> 
                        </td>
                        <%if (!operator.equals("NEGATION")) {
                        %>
                        <td class="col">
                            <%=data2%> 
                        </td>
                        <%}%>
                        <td>
                            &nbsp;
                        </td>
                        <td class="col">
                            <%=String.valueOf(answer)%>
                        </td>

                    </tr>
                </table>
            </div>

            <%
                    session.setAttribute("bitdata1", data1);
                    if (!operator.equals("NEGATION")) {
                        session.setAttribute("bitdata2", data2);
                    }
                    session.setAttribute("bitans", cal.toString(lax));
                    session.setAttribute("bitop", operator);
                }//Bitwise operation end


                if (operType.equals("Relational Operation")) {

                    double dat1 = 0;
                    double dat2 = 0;
                    int answer = 0;
                    String laxk = "";
                    Calculations cal = new Calculations();
                    String data1 = request.getParameter("textrel");
                    String data2 = request.getParameter("textrel2");
                    String reldtype1 = request.getParameter("reldtype1");
                    String reldtype2 = request.getParameter("reldtype2");
                    String relop = request.getParameter("relopsub");

                    if (reldtype1.equals("Decimal")) {
                        dat1 = Integer.parseInt(data1);

                    } else {
                        dat1 = cal.toDecimal(data1);

                    }

                    if (reldtype2.equals("Decimal")) {
                        dat2 = Integer.parseInt(data2);

                    } else {
                        dat2 = cal.toDecimal(data2);

                    }

                    if (relop.equals("<=")) {
                        if (dat1 <= dat2) {
                            answer = 1;
                        } else {
                            answer = 0;
                        }
                    } else {
                        if (dat1 >= dat2) {
                            answer = 1;
                        } else {
                            answer = 0;
                        }
                    }
                    if (answer == 0) {
                        laxk = "0 (false)";
                    } else {
                        laxk = "1 (true)";
                    }

            %>

            <input type="hidden" name="da1" id="da1" value="<%=data1%>"/>
            <input type="hidden" name="da2" id="da2" value="<%=data2%>"/>
            <input type="hidden" name="dp1" id="dp1" value="<%=reldtype1%>"/>
            <input type="hidden" name="dp2" id="dp2" value="<%=reldtype2%>"/>
            <input type="hidden" name="dc1" id="dc1" value="<%=relop%>"/>
            <div>
                <table>
                    <tr>
                        <td class="col">
                            data1
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td class="col">
                            <%=data1 + " (" + reldtype1 + ")"%>
                        </td>

                    </tr>

                    <tr>
                        <td class="col">
                            Operator
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td class="col">
                            <%=relop%>
                        </td>

                    </tr>

                    <tr>
                        <td class="col">
                            data2
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td class="col">
                            <%=data2 + " (" + reldtype2 + ")"%>
                        </td>

                    </tr>
                    <tr>
                        <td class="col">
                            &nbsp;
                        </td>
                        <td class="col">
                            &nbsp;
                        </td>
                        <td class="col">
                            &nbsp;
                        </td>

                    </tr>
                    <tr>
                        <td class="col">
                            Answer
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td class="col">
                            <%=data1 + " " + relop + " " + data2 + " = " + laxk%>

                        </td>

                    </tr>
                </table>

            </div>

            <%

                    session.setAttribute("reldata1", data1);
                    session.setAttribute("reldata2", data2);
                    session.setAttribute("reldtype1", reldtype1);
                    session.setAttribute("reldtype2", reldtype2);
                    session.setAttribute("relop", relop);
                    session.setAttribute("answerrel", laxk);

                }//Relational Operation end

                if (operType.equals("Logical Operation")) {
                    int answer = 99;
                    String laxk = "";
                    Calculations cal = new Calculations();
                    String data1 = request.getParameter("textlog");
                    String data2 = request.getParameter("textlog2");
                    String logdtype1 = request.getParameter("logdtype1");
                    String logdtype2 = request.getParameter("logdtype2");
                    String logop = request.getParameter("logopsub");
                    int[] adata1 = cal.toIntArray(data1);
                    int[] adata2 = cal.toIntArray(data2);

                    if (logop.equals("===")) {
                        String adat1 = "", adat2 = "";
                        if (logdtype1.equals("Decimal")) {
                            adat1 = Integer.toBinaryString(Integer.valueOf(data1));
                        } else {
                            adat1 = data1;
                        }
                        if (logdtype2.equals("Decimal")) {
                            adat2 = Integer.toBinaryString(Integer.valueOf(data2));
                        } else {
                            adat2 = data2;
                        }

                        int k = adat1.length() - adat2.length();
                        if (k > 0) {
                            for (int l = 0; l < k; l++) {
                                adat2 = "0" + adat2;
                            }
                        }
                        if (k < 0) {
                            for (int l = 0; l < (-k); l++) {
                                adat1 = "0" + adat1;
                            }
                        }
                        adata1 = cal.toIntArray(adat1);
                        adata2 = cal.toIntArray(adat2);
                        boolean p = cal.checkCaseEquality(adata1, adata2);
                        if (p) {
                            answer = 1;
                        } else {
                            answer = 0;
                        }

                    }
                    if (logop.equals("!==")) {
                        String adat1 = "", adat2 = "";
                        if (logdtype1.equals("Decimal")) {
                            adat1 = Integer.toBinaryString(Integer.valueOf(data1));
                        } else {
                            adat1 = data1;
                        }
                        if (logdtype2.equals("Decimal")) {
                            adat2 = Integer.toBinaryString(Integer.valueOf(data2));
                        } else {
                            adat2 = data2;
                        }

                        int k = adat1.length() - adat2.length();
                        if (k > 0) {
                            for (int l = 0; l < k; l++) {
                                adat2 = "0" + adat2;
                            }
                        }
                        if (k < 0) {
                            for (int l = 0; l < (-k); l++) {
                                adat1 = "0" + adat1;
                            }
                        }
                        adata1 = cal.toIntArray(adat1);
                        adata2 = cal.toIntArray(adat2);
                        boolean p = cal.checkCaseEquality(adata1, adata2);
                        if (p) {
                            answer = 0;
                        } else {
                            answer = 1;
                        }
                    }
                    if (logop.equals("==")) {
                        int adt1 = 0;
                        int adt2 = 0;
                        if (logdtype1.equals("Decimal")) {
                            adt1 = Integer.valueOf(data1);
                        } else {
                            //adt1 =Integer.valueOf(""+cal.toDecimal(data1));
                            adt1 = (int) cal.toDecimal(data1);
                        }
                        if (logdtype2.equals("Decimal")) {
                            adt2 = Integer.valueOf(data2);
                        } else {
                            //adt2 = Integer.valueOf(""+cal.toDecimal(data2));
                            adt2 = (int) cal.toDecimal(data2);
                        }
                        if (adt1 == adt2) {
                            answer = 1;
                        } else {
                            answer = 0;
                        }

                    }
                    if (logop.equals("!=")) {
                        int adt1 = 0;
                        int adt2 = 0;
                        if (logdtype1.equals("Decimal")) {
                            adt1 = Integer.valueOf(data1);
                        } else {
                            //adt1 = Integer.valueOf(""+cal.toDecimal(data1));
                            adt1 = (int) cal.toDecimal(data1);
                        }
                        if (logdtype2.equals("Decimal")) {
                            adt2 = Integer.valueOf(data2);
                        } else {
                            //adt2 = Integer.valueOf(""+cal.toDecimal(data2));
                            adt2 = (int) cal.toDecimal(data2);
                        }
                        if (adt1 == adt2) {
                            answer = 0;
                        } else {
                            answer = 1;
                        }
                    }
                    if (logop.equals("&&")) {
                        int adt1 = Integer.valueOf(data1);
                        int adt2 = Integer.valueOf(data2);
                        if (adt1 == 1 && adt2 == 1) {
                            answer = 1;
                        } else {
                            answer = 0;
                        }
                    }
                    if (logop.equals("||")) {
                        int adt1 = Integer.valueOf(data1);
                        int adt2 = Integer.valueOf(data2);
                        if (adt1 == 1 || adt2 == 1) {
                            answer = 1;
                        } else {
                            answer = 0;
                        }

                    }

                    if (answer == 0) {
                        laxk = "0 (false)";
                    }
                    if (answer == 1) {
                        laxk = "1 (true)";
                    }

            %>
            <div>
                <table>
                    <tr>
                        <td class="col">
                            data1
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td class="col">
                            <%=data1 + " (" + logdtype1 + ")"%>
                        </td>

                    </tr>

                    <tr>
                        <td class="col">
                            Operator
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td class="col">
                            <%=logop%>
                        </td>

                    </tr>

                    <tr>
                        <td class="col">
                            data2
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td class="col">
                            <%=data2 + " (" + logdtype2 + ")"%>
                        </td>

                    </tr>
                    <tr>
                        <td class="col">
                            &nbsp;
                        </td>
                        <td class="col">
                            &nbsp;
                        </td>
                        <td class="col">
                            &nbsp;
                        </td>

                    </tr>
                    <tr>
                        <td class="col">
                            Answer
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td class="col">
                            <%=data1 + " " + logop + " " + data2 + " = " + laxk%>

                        </td>

                    </tr>
                </table>

            </div>


            <%
                    session.setAttribute("logdata1", data1);
                    session.setAttribute("logdata2", data2);
                    session.setAttribute("logop", logop);
                    session.setAttribute("answerlog", laxk);
                    session.setAttribute("logdtype1", logdtype1);
                    session.setAttribute("logdtype2", logdtype2);
                }//logical end

                if (operType.equals("Reduction Operation")) {

                    String data1 = request.getParameter("textred");
                    String operator = request.getParameter("redopsub");
                    Calculations cal = new Calculations();
                    int[] dat1 = cal.toIntArray(data1);
                    int answer = 99;
                    if (operator.equals("&")) {
                        answer = cal.reductionAND(dat1);
                        // out.println(answer);
                    }
                    if (operator.equals("~&")) {
                        answer = cal.reductionAND(dat1);
                        if (answer == 0) {
                            answer = 1;
                        } else {
                            answer = 0;
                        }
                        //out.println(answer);
                    }
                    if (operator.equals("|")) {
                        answer = cal.reductionOR(dat1);
                        // out.println(answer);
                    }
                    if (operator.equals("~|")) {
                        answer = cal.reductionOR(dat1);
                        if (answer == 0) {
                            answer = 1;
                        } else {
                            answer = 0;
                        }
                        // out.println(answer);
                    }
                    if (operator.equals("^")) {
                        answer = cal.reductionXOR(dat1);
                        //out.println(answer);
                    }
                    if (operator.equals("~^")) {
                        answer = cal.reductionXOR(dat1);
                        if (answer == 0) {
                            answer = 1;
                        } else {
                            answer = 0;
                        }
                        //  out.println(answer);
                    }


            %>
            <div>
                <table>
                    <tr>
                        <td>
                            Operator
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td>
                            <%=operator%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Data
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td>
                            <%=data1%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Answer
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td>
                            <%=operator + " " + data1.length() + "'b" + data1 + " = " + answer%>
                        </td>
                    </tr>
                </table>
            </div>
            <%

                    session.setAttribute("reddata", data1);
                    session.setAttribute("redanswer", answer);
                    session.setAttribute("redoperator", operator);
                }
                session.setAttribute("arithvalue", "true");
                session.setAttribute("arithtype", operType);
                //session.setAttribute("arithres",result);
            %>
            <table>
                <tr>
                    <td >
                        <%out.println("<br><div class='rnd' id='laxdivk' style='display: none' ><strong>"
                                    + "<div id='laxdiv'> Verilog code generated successfully!! "
                                    + "click on Load Program tab</div>"
                                    + "</strong></div>");
                        %>


                        <input class="buttons" type="button" name="gen" id="generate" value="Generate Verilog code"/>
                    </td>
                </tr>
            </table>

        </div>
    </body>


</html>
