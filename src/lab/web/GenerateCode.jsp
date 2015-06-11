<%-- 
    Document   : GenerateCode.jsp
    Created on : 29 Nov, 2011, 3:01:54 PM
    Author     : root
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="org.apache.commons.math.linear.*" %>
<%@page import="JavaFiles.GenerateVerilogCode"%>
<%@page import="java.io.PrintStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="errorPages.jsp"%>
<%
    String operType = "";
%>

<!DOCTYPE html>
<html>
    <head>
        <script type="text/javascript" src="scripts/jquery.js"></script>
        <script type="text/javascript" src="scripts/jquery-ui.js"></script>
        <script type="text/javascript" src="SimFPGAAction.js">
        </script>
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
            .matrixs{
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
            var laxp=0;

            
      
        
        </script>
        <style>
            .rnd {
                border: solid 1px black;
                height: 50px;
                width: 75%;
                border-radius: 10px;
                -moz-border-radius: 10px;
                -webkit-border-radius: 10px;
                background-color: #000;
                color: #00ff00;

                visibility: visible;
            }


        </style>
    </head>
    <body >
        <%
            String ws = (String) session.getAttribute("workspace");
            String device = (String) session.getAttribute("device");
            File fp = new File(constants.Constants.PATH + ws + "/" + "demo1.vl");
            FileOutputStream fos = null;
            PrintStream p = null;
            operType = request.getParameter("opera");

            System.out.println(operType);

        %>
        <input type="hidden" name="operat" id="operat" value="<%=operType%>" />
        <%

            fos = new FileOutputStream(fp);
            p = new PrintStream(fos, true);
            int m = Integer.parseInt(request.getParameter("matarow"));//rows of  matrix 1
            int n = Integer.parseInt(request.getParameter("matacol"));//columns of matrix 1
            // x and y are not required for addition bcoz there m=x and n=y
            //below lines to be modified as per requirement
            int mat1[][] = new int[m][n];
            int mat2[][] = new int[10][10];
            int x = 0, y = 0;
            long ans[][];
            GenerateVerilogCode gvc = new GenerateVerilogCode();
            for (int i = 0; i < m; i++) {
                for (int j = 0; j < n; j++) {
                    //System.out.println(request.getParameter("txta"+i+j)+" "+request.getParameter("txtb"+i+j));
                    mat1[i][j] = Integer.parseInt(request.getParameter("txta" + i + j));
                    /* if (operType.equals("Addition") || operType.equals("Subtraction") || operType.equals("Multiplication")) {
                    mat2[i][j] = Integer.parseInt(request.getParameter("txtb" + i + j));
                    }*/
                }
            }
            if (operType.equals("Addition") || operType.equals("Subtraction") || operType.equals("Multiplication")) {

                x = Integer.parseInt(request.getParameter("matbrow"));//rows of matrix 2
                y = Integer.parseInt(request.getParameter("matbcol"));//columns of matrix 2

                mat2 = new int[x][y];
                for (int i = 0; i < x; i++) {
                    for (int j = 0; j < y; j++) {
                        //System.out.println(request.getParameter("txta"+i+j)+" "+request.getParameter("txtb"+i+j));
                        //mat1[i][j] = Integer.parseInt(request.getParameter("txta" + i + j));


                        mat2[i][j] = Integer.parseInt(request.getParameter("txtb" + i + j));
                    }
                }
            }
            //p.println("laxmikant");
            //p.println("kumbhare p");

            if (operType.equals("Addition")) {

                //for addition m=x and n=y

                ans = new long[m][n];

//                gvc.generateAlgoAddition(p, m, n, mat1, mat2);

                //session=request.getSession();
                //session.setAttribute("calculatedans", ans);

                for (int i = 0; i < m; i++) {
                    for (int j = 0; j < n; j++) {
                        // ans[i][j]=0;
                        //for(int k=0;k<3;k++)
                        //{
                        //ans[i][j]+=mat1[i][k]*mat2[k][j];
                        ans[i][j] = mat1[i][j] + mat2[i][j];
                        //}
                    }
                    System.out.println();
                }
                /*
                double matd[][]=new double[m][n];
                for (int i = 0; i < m; i++) {
                for (int j = 0; j < n; j++) {
                matd[i][j]=(double)mat1[i][j];
                }
                }
                
                if(gvc.detrm( matd, m )==0){
                System.out.print( "\nMATRIX IS NOT INVERSIBLE\n" );}
                else
                gvc.cofact( matd, m );
                 */
                //gvc.cofact(matd,m);
                session = request.getSession();
                session.setAttribute("operator", "+");
                session.setAttribute("laxp", p);
                session.setAttribute("laxm", m);
                session.setAttribute("laxn", n);
                session.setAttribute("laxmat1", mat1);
                session.setAttribute("laxmat2", mat2);
                session.setAttribute("answers", ans);
                gvc.displayOutput(out, m, n, m, n, mat1, mat2, ans, "+");

            }

            //end addition

            //multiplication
            if (operType.equals("Multiplication")) {


                //for mult it should be m=y and n=x

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
                session.setAttribute("laxp", p);
                session.setAttribute("laxm", m);
                session.setAttribute("operator", "X");
                session.setAttribute("laxn", n);
                session.setAttribute("laxx", x);
                session.setAttribute("laxy", y);
                session.setAttribute("laxmat1", mat1);
                session.setAttribute("laxmat2", mat2);
                session.setAttribute("answers", ans);
                gvc.displayOutput(out, m, n, x, y, mat1, mat2, ans, "X");


            }

            //end multiplication

            //matrix inverse


            if (operType.equals("Inverse")) {

                String inverseMethod = request.getParameter("inversetype");

                //for mult it should be m=y and n=x

                ans = new long[m][n];
                y = n;
                x = m;
                System.out.println("====" + m + " " + n);
                //gvc.generateAlgoMultiplication(p, m, n, x, y, mat1, mat2,device);





                //trying

                double d[][] = new double[m][n];
                for (int i = 0; i < m; i++) {
                    for (int j = 0; j < n; j++) {

                        d[i][j] = mat1[i][j];
                        System.out.print(d[i][j]);
                    }
                }



                double[][] values = {{2, 0, 0}, {0, 2, 0}, {0, 0, 2}};
                double[] rhs = new double[n];
                for (int j = 0; j < n; j++) {

                    rhs[j] = (j + 3) % (j + 2);
                }

                RealMatrix a = new Array2DRowRealMatrix(d);
                //System.out.println("solution x: " + a);
                RealMatrix b1;
                System.out.println("a matrix: " + a);
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
                for (int i = 0; i < m; i++) {
                    for (int j = 0; j < n; j++) {

                        d[i][j] = Double.valueOf(df.format(d[i][j]));
                        System.out.print(d[i][j]);
                    }
                }





                session = request.getSession();
                session.setAttribute("inversetype", inverseMethod);
                session.setAttribute("laxp", p);
                session.setAttribute("laxm", m);
                session.setAttribute("operator", "^");
                session.setAttribute("laxn", n);
                session.setAttribute("laxmat1", mat1);
                session.setAttribute("answers", d);
                gvc.displaySingleOutput(out, m, n, mat1, d, "^");


            }

            //end of inverse


            session.setAttribute("setvalue", "true");//to display previous result

            out.println("<br><div class='rnd' id='laxdivk' style='display: none' ><strong>"
                    + "<div id='laxdiv'> Verilog code generated successfully!! "
                    + "click on Load Program tab</div>"
                    + "</strong></div>");
            out.print("<br><input class=\"buttons\" type=\"button\" name=\"gen\" id=\"generate\" value=\"Generate Verilog code\" ");

        %>



    </body>

    <script type="text/javascript">
        
        $(document).ready(function(){
            var opert=$("#operat").val();
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
                    if(opert=="Addition"){
                        //alert("hi");
                        url="matAdditionSave.jsp";
                        
                        //alert(url);
                        
                     
                    }
                    else if(opert=="Multiplication")
                    {
                        url="matMultiSave.jsp";
                    }
                    else if(opert=="Inverse")
                    {
                        url="matInverseSave.jsp";
                    }
                    
                    xmlhttp.open("GET",url,false);
                    xmlhttp.send(null);
                        
                    parent.callFromChildPage();
                    $("#laxdivk").attr("style","display: block");
                }
                
            });
            
        });
    </script>

</html>
