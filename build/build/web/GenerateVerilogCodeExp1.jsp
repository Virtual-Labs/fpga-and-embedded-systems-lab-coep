<%-- 
    Document   : GenerateVerilogCodeExp1
    Created on : 15 Dec, 2011, 11:01:11 AM
    Author     : root
--%>

<%@page import="JavaFiles.Calculations"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="errorexp1.jsp"%>
<!DOCTYPE html>
<%

    String progType = request.getParameter("intsel");
    session = request.getSession();
%>


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


        </style>
        <script type="text/javascript">
        
            $(document).ready(function(){
                //alert();
                var progType=$("#progType").val();
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
                          
                        if(progType=="Hello World")
                        {
                            url="helloWorldSave.jsp";
                        }
                        if(progType=="Asynchronous Design")
                        {
                            url="asyncSave.jsp";
                        }
                        if(progType=="Synchronous Design")
                        {
                            url="syncSave.jsp";
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
        <div>
            <input type="hidden" name="progType" id="progType" value="<%=progType%>"/>
            <%
                if (progType.equals("Hello World")) {

                    String msg = request.getParameter("htext");
                    session.setAttribute("yourmsg", msg);
            %>
            <div>
                <table>
                    <tr>
                        <td  class="col">
                            Hello World Demo
                            <hr>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Your string to display : <%=msg%>
                        </td>
                    </tr>
                </table>

            </div>



            <%
                }

                if (progType.equals("Asynchronous Design")) {

                    String flipflop = request.getParameter("intsubsel1");
                    String answer = "";
                    boolean checked = true;//true if checked
                    Calculations cal = new Calculations();
                    String check = "";
                    int result = 0;
                    String data = "";
                    String data1 = "";
                    if (flipflop.equals("D Flip Flop")) {
                        check = request.getParameter("adcheck");
                        data = request.getParameter("adtext");
                        if (check != null) {//if reset checked

                            result = Integer.parseInt(data, 2);
                            // System.out.println("/*/*/*/*/*/*" + Integer.toBinaryString(result));
                            checked = true;
                        } else {
                            result = 0;

                            checked = false;
                        }

                        answer = result + "";

                    } else {//for T flip flop
                        check = request.getParameter("atcheck");
                        data = request.getParameter("attext");
                        if (check != null) {//checked
                            int arr[] = cal.toIntArray(data);
                            data1 = cal.toString(cal.bitwiseNOT(arr));
                            // System.out.println("@@@@@@@@@@@@@@@@@@@@@@@ laxp" +data1);
                            result = (int) cal.toDecimal(data1);
                            checked = true;
                        } else {
                            result = 0;

                            checked = false;
                        }
                        answer = result + "";
                    }


            %>

            <div>
                <table>
                    <tr>
                        <td colspan="3" class="col">
                            <%=progType + " " + flipflop%>
                            <hr>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Data
                        </td>
                        <td>
                            :
                        </td>
                        <td>

                            <%=data%>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            Reset
                        </td>
                        <td>
                            :
                        </td>
                        <td>

                            <%if (checked) {%>Yes<%} else {%>No<%}%>
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
                            <table>
                                <tr>
                                    <td>
                                        <%if (flipflop.equals("D Flip Flop")) {%>
                                        <%if (checked) {%><%=data%><%} else {%>0<%}%>
                                        <%}%>
                                        <%if (flipflop.equals("T Flip Flop")) {%>
                                        <%if (checked) {%><%=data1%><%} else {%>0<%}%>
                                        <%}%>
                                    </td>
                                    <td>
                                        Binary Format
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%if (checked) {%><%=result%><%} else {%>0<%}%>
                                    </td>
                                    <td>
                                        Decimal Format
                                    </td>
                                </tr>
                            </table>


                        </td>
                    </tr>
                </table>

            </div>

            <%
                    session.setAttribute("flipfloptasync", flipflop);
                    session.setAttribute("dataasync", data);
                    session.setAttribute("answerasync", answer);
                    session.setAttribute("checkedasync", checked);


                }
                if (progType.equals("Synchronous Design")) {

                    String flipflop = request.getParameter("intsubsel2");
                    String answer = "";
                    boolean checked = true;//true if checked
                    Calculations cal = new Calculations();
                    String check = "";
                    int result = 0;
                    String data = "", data1 = "";
                    if (!flipflop.equals("Counter")) {
                        if (flipflop.equals("D Flip Flop")) {
                            check = request.getParameter("sdcheck");
                            data = request.getParameter("sdtext");
                            if (check != null) {//if reset checked

                                result = Integer.parseInt(data, 2);
                                System.out.println("/*/*/*/*/*/*" + Integer.toBinaryString(result));
                                checked = true;
                            } else {
                                result = 0;

                                checked = false;
                            }

                            answer = result + "";

                        } else {//for T flip flop
                            check = request.getParameter("stcheck");
                            data = request.getParameter("sttext");
                            if (check != null) {//checked
                                int arr[] = cal.toIntArray(data);
                                data1 = cal.toString(cal.bitwiseNOT(arr));
                                result = (int) cal.toDecimal(data1);
                                checked = true;
                            } else {
                                result = 0;

                                checked = false;
                            }
                            answer = result + "";
                        }


            %>

            <div>
                <table>
                    <tr>
                        <td colspan="3" class="col">
                            <%=progType + " " + flipflop%>
                            <hr>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Data
                        </td>
                        <td>
                            :
                        </td>
                        <td>

                            <%=data%>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            Reset
                        </td>
                        <td>
                            :
                        </td>
                        <td>

                            <%if (checked) {%>Yes<%} else {%>No<%}%>
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
                            <table>
                                <tr>
                                    <td>
                                        <%if (flipflop.equals("D Flip Flop")) {%>
                                        <%if (checked) {%><%=data%><%} else {%>0<%}%>
                                        <%}%>
                                        <%if (flipflop.equals("T Flip Flop")) {%>
                                        <%if (checked) {%><%=data1%><%} else {%>0<%}%>
                                        <%}%>
                                    </td>
                                    <td>
                                        Binary Format
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%if (checked) {%><%=result%><%} else {%>0<%}%>
                                    </td>
                                    <td>
                                        Decimal Format
                                    </td>
                                </tr>
                            </table>


                        </td>
                    </tr>
                </table>

            </div>

            <%

                    session.setAttribute("dataasync", data);
                    session.setAttribute("answerasync", answer);
                    session.setAttribute("checkedasync", checked);

                }//if not counter
                if (flipflop.equals("Counter")) {
                    String counterType = request.getParameter("intsubsel3");
                    String bound = "";
                    boolean enable = true;
                    if (counterType.equals("Up Counter")) {
                        bound = request.getParameter("sultext");
                        String chk = request.getParameter("suenchk");
                        if (chk != null) {
                            enable = true;
                        } else {
                            enable = false;
                        }

                    } else {

                        bound = request.getParameter("sdutext");
                        String chk = request.getParameter("sdenchk");
                        if (chk != null) {
                            enable = true;
                        } else {
                            enable = false;
                        }
                    }


            %>

            <table>
                <tr>
                    <td colspan="3" class="col">
                        <%=flipflop + " " + counterType%>
                        <hr>
                    </td>
                </tr>
                <tr>
                    <td>
                        Enabled
                    </td>
                    <td>
                        :
                    </td>
                    <td>
                        <%if (enable) {%>YES<%} else {%>NO<%}%>
                    </td>
                </tr>
            </table>

            <%
                        session.setAttribute("enabled", enable);
                        session.setAttribute("bound", bound);
                        session.setAttribute("countertype", counterType);
                    }
                    session.setAttribute("flipfloptasync", flipflop);

                }//sync end

                session.setAttribute("exp1value", "true");
                session.setAttribute("exp1type", progType);

            %>

            <table>
                <tr>
                    <td >
                        <%out.println("<br><div class='rnd' id='laxdivk' style='display: none' ><strong>"
                                    + "<div id='laxdiv'>Verilog code generated successfully!! "
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
