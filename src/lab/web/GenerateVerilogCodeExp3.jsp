<%--  
    Document   : GenerateVerilogCodeExp3
    Created on : 28 Dec, 2011, 11:33:12 AM
    Author     : root

--%>

<%@page import="JavaFiles.GenerateVerilogCode"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="errorexp3.jsp" %>
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
        </style>

        <script type="text/javascript">
        
            $(document).ready(function(){
                var url;
                $("#generate").bind({
                
                    click: function(){
                        $.ajax({
                            url: 'SaveExp3',
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

            String architecture = request.getParameter("selarch");
            if (architecture.equals("1")) {
                architecture = "Serial (Single PE) Architecture";
            } else if (architecture.equals("2")) {
                architecture = "Parallel (N - PE) Architecture";
            } else {
                architecture = "Iterative (4 - PE) Architecture";
            }


            String operation = request.getParameter("seloper");

            System.out.println("    " + architecture + "    " + operation);

            if (operation.equals("4"))//quadratic starts
            {

                operation = "Roots of Quadratic Equations";
                int b = Integer.parseInt(request.getParameter("pos10"));
                int a = Integer.parseInt(request.getParameter("pos100"));
                int c = Integer.parseInt(request.getParameter("pos1"));
                if (a == 0) {

                    out.println("<h3>Your Equation is Linear........");
                } else {
                    DecimalFormat df = new DecimalFormat("#.###");
                    double[] roots = new double[2];

                    double lax = (b * b) - (4 * a * c);
                    double lax1 = (b * b) - (4 * a * c);

                    if (lax < 0 || lax1 < 0) {
                        out.println("<h3>Your Equation is Unsolvable........");
                    } else {
                        lax = Math.sqrt(lax);
                        lax = (-b) + lax;
                        lax = lax / (2 * a);
                        System.out.println("x1=" + lax);
                        roots[0] = Double.valueOf(df.format(lax));
//out.println("x1="+lax);

                        lax1 = Math.sqrt(lax1);
                        lax1 = (-b) - lax1;
                        lax1 = lax1 / (2 * a);
                        roots[1] = Double.valueOf(df.format(lax1));
                        System.out.println("x2=" + lax1);
//out.println("x2="+lax);
        %>

        <table>
            <tr>
                <td>
                    Your Equation
                </td>
                <td>:</td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <%if (a == 1) {%>
                                x<sup>2</sup> 
                                <%} else {%>
                                <%=a%>x<sup>2</sup>  
                                <%}%>
                            </td>
                            <td>
                                <%if (b == 0) {%>

                                <%} else if (b > 0) {%>
                                + <%=b%>x 
                                <%} else {%>
                                - <%=-b%>x <%}%>
                            </td>
                            <td>
                                <%if (c == 0) {%>

                                <%} else if (c > 0) {%>
                                + <%=c%>
                                <%} else {%>
                                - <%=-c%><%}%>
                            </td>
                            <td> = 0</td>
                        </tr>
                    </table>



                </td>
            </tr>
            <tr>
                <td>
                    Roots
                </td>
                <td>:</td>
                <td>
                    <table>
                        <tr>
                            <td>
                                x<sub>1</sub>
                            </td>
                            <td>=</td>
                            <td><%=roots[0]%></td>
                        </tr>
                        <tr>
                            <td>
                                x<sub>2</sub>
                            </td>
                            <td>=</td>
                            <td><%=roots[1]%></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <%
                        out.println(
                                "<br><div class='rnd' id='laxdivk' style='display: none' ><strong>"
                                + "<div id='laxdiv'> Verilog code generated successfully!! "
                                + "click on Load Program tab</div>"
                                + "</strong></div>");
                        out.print("<br><input class=\"buttons\" type=\"button\" name=\"gen\" id=\"generate\" value=\"Generate Verilog code\" /><br> ");

                        session = request.getSession();

                        session.setAttribute("rootsexp3", roots);
                        session.setAttribute("aexp3", a);
                        session.setAttribute("bexp3", b);
                        session.setAttribute("cexp3", c);
                        session.setAttribute("operationsexp3", operation);
                        session.setAttribute("architectureexp3", architecture);
                        session.setAttribute("exp3laxvalue", "true");

                    }
                }

            }//quadratic ends

            if (operation.equals("5"))//Multiplication starts
            {
                operation = "Matrix Multiplication";
                int m = Integer.parseInt(request.getParameter("matarow"));//rows of  matrix 1
                int n = Integer.parseInt(request.getParameter("matacol"));//columns of matrix 1
                int mat1[][] = new int[m][n];

                int x = 0, y = 0;
                x = Integer.parseInt(request.getParameter("matbrow"));//rows of matrix 2
                y = Integer.parseInt(request.getParameter("matbcol"));//columns of matrix 2
                int mat2[][] = new int[x][y];
                long ans[][];
                GenerateVerilogCode gvc = new GenerateVerilogCode();
                for (int i = 0; i < m; i++) {
                    for (int j = 0; j < n; j++) {
                        mat1[i][j] = Integer.parseInt(request.getParameter("txta" + i + j));
                        mat2[i][j] = Integer.parseInt(request.getParameter("txtb" + i + j));

                    }
                }
                ans = new long[m][y];
                System.out.println("====" + m + " " + y);
                //gvc.generateAlgoMultiplication(p, m, n, x, y, mat1, mat2);

                //gvc.displayOutput(out, m, n, m, n, mat1, mat2, ans);

                for (int i = 0; i < m; i++) {
                    for (int j = 0; j < y; j++) {
                        ans[i][j] = 0;
                        for (int k = 0; k < n; k++)//cols of matrix 1
                        {

                            ans[i][j] += mat1[i][k] * mat2[k][j];
                            //ans[i][j]=mat1[i][k]+mat2[k][j];
                        }
                    }
                    System.out.println();
                }

                session = request.getSession();
                session.setAttribute("laxm", m);
                session.setAttribute("laxn", n);
                session.setAttribute("laxx", x);
                session.setAttribute("laxy", y);
                session.setAttribute("laxmat1", mat1);
                session.setAttribute("laxmat2", mat2);
                session.setAttribute("answers", ans);
                session.setAttribute("exp3laxvalue", "true");
                gvc.displayOutput(out, m, n, x, y, mat1, mat2, ans, "X");


                out.println("<br><div class='rnd' id='laxdivk' style='display: none' ><strong>"
                        + "<div id='laxdiv'> Verilog code generated successfully!! "
                        + "click on Load Program tab</div>"
                        + "</strong></div>");
                out.print("<br><input class=\"buttons\" type=\"button\" name=\"gen\" id=\"generate\" value=\"Generate Verilog code\" /> <br>");

                session = request.getSession();
                session.setAttribute("operationsexp3", operation);
                session.setAttribute("architectureexp3", architecture);
            }//multiplication ends
            String srx = "";
            if (architecture.equals("Serial (Single PE) Architecture")) {
                srx = "";
            }
            if (architecture.equals("Parallel (N - PE) Architecture")) {
                srx = "";
            }
            if (architecture.equals("Iterative (4 - PE) Architecture")) {
                srx = "images/coep_logo.png";
            }
            /*   out.println("<br>"
            + "<div style=\"border: 2px solid black; text-align: center\">");
            out.print("<img src=\"" + srx + "\" alt=" + architecture + "\" /><br> "
            + "fig. <i>" + architecture + "</i></div>");*/

        %>







    </body>
</html>
