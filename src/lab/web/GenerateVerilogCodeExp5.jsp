<%-- 
    Document   : GenerateVerilogCodeExp5
    Created on : 19 Dec, 2011, 4:09:30 PM
    Author     : root
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="org.apache.commons.math.linear.RealVector"%>
<%@page import="org.apache.commons.math.linear.ArrayRealVector"%>
<%@page import="org.apache.commons.math.linear.LUDecompositionImpl"%>
<%@page import="org.apache.commons.math.linear.DecompositionSolver"%>
<%@page import="org.apache.commons.math.linear.RealMatrix"%>
<%@page import="org.apache.commons.math.linear.Array2DRowRealMatrix"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="errorexp5.jsp" %>
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
                        $.ajax({
                            url: 'LinearEquationSolver',
                            type: "Post",
                            success:function(e){
                                $("#laxdivk").attr("style","display: block");
                                parent.callFromChildPage();
                            },
                            fail:function(e){
                                //alert("Hi");
                                $("#laxdiv").html("Not Generated");
                            }
                            
                        });
                        
                        
                        /*/alert();
                        if (window.XMLHttpRequest)
                        {// code for IE7+, Firefox, Chrome, Opera, Safari
                            xmlhttp=new XMLHttpRequest();
                        }
                        else
                        {// code for IE6, IE5
                            xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                        }
                        //alert(opert);
                    
                        var url="LinearEquationSolver";
                        xmlhttp.open("GET",url,false);
                        xmlhttp.send(null);*/
                        
                        
                    }
                
                });
            
            });
        </script>

    </head>
    <body>
        <%
            String dataType = request.getParameter("dtype");
            int rank = Integer.valueOf(request.getParameter("ranks"));
            String floatType = "";
            String equations[] = new String[rank];
            for (int i = 0; i < rank; i++) {
                equations[i] = "";
            }
            int equ1[][] = new int[rank][rank];
            int answer[] = new int[rank];
            double equ2[][] = new double[rank][rank];
            double answer2[] = new double[rank];
            String solveMethod = request.getParameter("solvemethod");
            if (dataType.equals("Fix Point")) {
                for (int i = 0; i < rank; i++) {
                    for (int j = 0; j < rank; j++) {
                        equ1[i][j] = Integer.valueOf(request.getParameter("txt" + i + j));
                        equ2[i][j] = Integer.valueOf(request.getParameter("txt" + i + j));
                    }
                    answer[i] = Integer.valueOf(request.getParameter("answers0" + i));
                    answer2[i] = Integer.valueOf(request.getParameter("answers0" + i));
                }

            } else {
                floatType = request.getParameter("subdtype");
                for (int i = 0; i < rank; i++) {
                    for (int j = 0; j < rank; j++) {
                        equ2[i][j] = Double.valueOf(request.getParameter("txt" + i + j));
                    }
                    answer2[i] = Double.valueOf(request.getParameter("answers0" + i));
                }
            }

            /*JUST CHECKING*/
            int n = rank;
            int m = rank;
            double d[][] = equ2;
            double k1[] = answer2;
            double[] rhs = new double[n];
            for (int j = 0; j < n; j++) {

                rhs[j] = (j + 3) % (j + 2);
            }

            RealMatrix a = new Array2DRowRealMatrix(d);
            RealMatrix b1;
            DecompositionSolver solver = new LUDecompositionImpl(a).getSolver();
            RealVector b = new ArrayRealVector(rhs);
            RealVector x1 = solver.solve(b);
            RealVector residual = a.operate(x1).subtract(b);
            double rnorm = residual.getLInfNorm();
            System.out.println("residual: " + rnorm);
            b1 = solver.getInverse();

            DecimalFormat df = new DecimalFormat("#.###");
            // System.out.println("solution x: " + b1);
            d = b1.getData();

            int y = 1;
            double ans[] = new double[m];
            for (int i = 0; i < m; i++) {
                for (int j = 0; j < y; j++) {
                    ans[i] = 0;
                    for (int k = 0; k < n; k++)//cols of matrix 1
                    {
                        String p = "";
                        if (dataType.equals("Fix Point")) {
                            p = Math.abs(equ1[i][k]) + "";
                        } else {
                            p = Math.abs(equ2[i][k]) + "";
                        }
                        ans[i] += d[i][k] * k1[k];
                        if (equ2[i][k] != 0) {
                            equations[i] += (p + " x<sub>" + k + "</sub>");
                        }

                        if (k < n - 1) {
                            if (equ2[i][k] == 0) {
                                equations[i] += " ";
                            } else if (equ2[i][k + 1] > 0) {
                                equations[i] += " + ";
                            } else if (equ2[i][k + 1] < 0) {
                                equations[i] += " - ";
                            } else {
                                equations[i] += " ";
                            }

                        }
                        if (k == n - 1) {
                            equations[i] += " = " + answer2[i] + "";
                        }
                        //ans[i][j]=mat1[i][k]+mat2[k][j];
                    }
                }
                System.out.println();
            }

            for (int i = 0;
                    i < m;
                    i++) {
                for (int j = 0; j < n; j++) {

                    d[i][j] = Double.valueOf(df.format(d[i][j]));
                    System.out.print(d[i][j]);
                }
                answer2[i] = Double.valueOf(df.format(answer2[i]));
                ans[i] = Double.valueOf(df.format(ans[i]));
            }

            /*Check Ends*/
            out.println(
                    "Your Equations  :");


            for (int i = 0;
                    i < rank;
                    i++) {

        %>
        <br>

        <%=equations[i]%>
        <%}%>
        <div>
            <hr>
            Generated Matrices : 

            <table>
                <tr>
                    <td>
                        <table cellpadding="10px" cellspacing="2px" class="matrixs1">
                            <%for (int i = 0;
                                        i < rank;
                                        i++) {

                            %>
                            <tr>
                                <%
                                    for (int j = 0; j < rank; j++) {

                                        if (dataType.equals("Fix Point")) {

                                %>
                                <td>
                                    <%=equ1[i][j]%>
                                </td>    
                                <%  }
                                    if (dataType.equals("Floating Point")) {

                                %>
                                <td>
                                    <%=equ2[i][j]%>
                                </td>    
                                <%  }

                                    }
                                %>


                            </tr>
                            <%    }
                            %>


                        </table>
                    </td>
                    <td>
                        <table cellpadding="10px" cellspacing="2px" class="matrixs">
                            <%for (int i = 0;
                                        i < rank;
                                        i++) {

                            %>
                            <tr>
                                <%


                                %>
                                <td>
                                    x<sub><%=i%></sub>
                                </td>    
                                <%
                                %>


                            </tr>
                            <%    }
                            %>

                        </table>
                    </td>

                    <td>
                        <table cellpadding="10px" cellspacing="2px"> 

                            <tr><td rowspan="<%=rank%>">=</td></tr>

                        </table> 



                    </td>


                    <td>
                        <table cellpadding="10px" cellspacing="2px" class="matrixs">

                            <%for (int i = 0;
                                        i < rank;
                                        i++) {

                            %>
                            <tr>
                                <%


                                %>
                                <td>
                                    <%=answer2[i]%>
                                </td>    
                                <%
                                %>


                            </tr>
                            <%    }
                            %>

                        </table>



                    </td>




                </tr>

            </table>

            <hr>

            Solutions :


            <%
                for (int i = 0;
                        i < rank;
                        i++) {
                    out.println("<br>x<sub>" + i + "</sub> = " + ans[i]);
                }
            %>
        </div>

        <%            out.println(
                    "<br><div class='rnd' id='laxdivk' style='display: none' ><strong>"
                    + "<div id='laxdiv'> Verilog code generated successfully!! "
                    + "click on Load Program tab</div>"
                    + "</strong></div>");
            out.print(
                    "<br><input class=\"buttons\" type=\"button\" name=\"gen\" id=\"generate\" value=\"Generate Verilog code\" ");
            session = request.getSession();

            session.setAttribute(
                    "equ2exp5", equ2);
            session.setAttribute(
                    "answerexp5", answer2);
            session.setAttribute(
                    "ansexp5", ans);
            session.setAttribute(
                    "rankexp5", rank);
            session.setAttribute(
                    "datatypeexp5", dataType);
            session.setAttribute(
                    "equationsexp5", equations);
            session.setAttribute(
                    "solveexp5", solveMethod);
            session.setAttribute(
                    "setvalexp5", "true");

        %>
        %>
    </body>
</html>
