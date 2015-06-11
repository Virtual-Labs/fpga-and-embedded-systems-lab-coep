<%-- 
    Document   : GenerateVerilogCodeExp7new
    Created on : 20 Apr, 2012, 1:09:01 PM
    Author     : shree
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                            url: 'PidControllerExpnew7',
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

        <script src="highcharts.js"></script>
        <script src="exporting.js"></script>

        <style>
            .table
            {
                width : 100%;
            }
        </style>
    </head>
    <body>

        <%
            String transfer = request.getParameter("opnew6");
            String operation = request.getParameter("oprnew7");
            String typeop = request.getParameter("typenew7");
            String time = request.getParameter("samp-time");
            String setpoint = request.getParameter("setpt");
            String kpval = request.getParameter("kp");
            String kdval = request.getParameter("kd");
            String kival = request.getParameter("ki");

            session = request.getSession();
            session.setAttribute("transferFunction", transfer);
            session.setAttribute("operation", operation);
            session.setAttribute("typeofop", typeop);
            session.setAttribute("samplingTime", time);
            session.setAttribute("setPoint", setpoint);
            session.setAttribute("kp", kpval);
            session.setAttribute("kd", kdval);
            session.setAttribute("ki", kival);
            session.setAttribute("setvalexp7", "true");


            double sp = Double.parseDouble(setpoint);
            double kp = Double.parseDouble(kpval);
            double kd1 = Double.parseDouble(kdval);
            double ki = Double.parseDouble(kival);
            double t = Double.parseDouble(time);

            double kd = kd1 * 1000;


            Vector<Double> u_res = new Vector<Double>();
            Vector<Double> e = new Vector<Double>();
            Vector<Double> t1 = new Vector<Double>();
            Vector<Double> s1 = new Vector<Double>();
            Vector<Double> errorSum = new Vector<Double>();

            if (transfer.equals("Third Order")) {
                double y = 0;
                double u = 0;
                double ecur = 0;
                double epre = 0;
                double x1 = 0;
                double x2 = 0;
                double x3 = 0;
                double k1[][] = new double[3][1];
                double k2[][] = new double[3][1];
                double k3[][] = new double[3][1];
                double k4[][] = new double[3][1];

                double h = 0.001;

                double a[][] = {{-3, -3, -1}, {1, 0, 0}, {0, 1, 0}};
                double b[][] = {{1}, {0}, {0}};
                double c[][] = {{0, 0, 1}};

                int countError = 0;

                for (int i = 0; i <= 15000; i++) {

                    s1.add(sp);
                    double x[][] = {{x1}, {x2}, {x3}};

                    // k1
                    double k1_r1[][] = new double[3][1];
                    for (int n1 = 0; n1 < 3; n1++) {
                        for (int n2 = 0; n2 < 1; n2++) {
                            k1_r1[n1][n2] = 0;
                            for (int n3 = 0; n3 < 3; n3++) {
                                k1_r1[n1][n2] += a[n1][n3] * x[n3][n2];

                            }
                        }
                    }

                    double k1_r2[][] = new double[3][1];
                    for (int n1 = 0; n1 < 3; n1++) {
                        for (int n2 = 0; n2 < 1; n2++) {

                            k1_r2[n1][n2] = b[n1][n2] * u;


                        }
                    }

                    for (int n1 = 0; n1 < 3; n1++) {
                        for (int n2 = 0; n2 < 1; n2++) {
                            k1[n1][n2] = k1_r1[n1][n2] + k1_r2[n1][n2];

                        }

                    }

                    //k2
                    double k2_r1 = x1 + ((h / 2) * k1[0][0]);
                    double k2_r2 = x2 + ((h / 2) * k1[1][0]);
                    double k2_r3 = x3 + ((h / 2) * k1[2][0]);

                    double k2_r4[][] = {{k2_r1}, {k2_r2}, {k2_r3}};
                    double k2_r[][] = new double[3][1];

                    for (int n1 = 0; n1 < a.length; n1++) {
                        for (int n2 = 0; n2 < k2_r4.length - 2; n2++) {
                            k2_r[n1][n2] = 0;
                            for (int n3 = 0; n3 < a.length; n3++) {
                                k2_r[n1][n2] += a[n1][n3] * k2_r4[n3][n2];

                            }
                        }
                    }


                    for (int n1 = 0; n1 < 3; n1++) {
                        for (int n2 = 0; n2 < 1; n2++) {
                            k2[n1][n2] = k2_r[n1][n2] + k1_r2[n1][n2];

                        }

                    }

                    // k3    
                    double k3_r1 = x1 + ((h / 2) * k2[0][0]);
                    double k3_r2 = x2 + ((h / 2) * k2[1][0]);
                    double k3_r3 = x3 + ((h / 2) * k2[2][0]);

                    double k3_r4[][] = {{k3_r1}, {k3_r2}, {k3_r3}};
                    double k3_r[][] = new double[3][1];

                    for (int n1 = 0; n1 < a.length; n1++) {
                        for (int n2 = 0; n2 < k3_r4.length - 2; n2++) {
                            k3_r[n1][n2] = 0;
                            for (int n3 = 0; n3 < a.length; n3++) {
                                k3_r[n1][n2] += a[n1][n3] * k3_r4[n3][n2];
                            }
                        }
                    }

                    for (int n1 = 0; n1 < 3; n1++) {
                        for (int n2 = 0; n2 < 1; n2++) {
                            k3[n1][n2] = k3_r[n1][n2] + k1_r2[n1][n2];
                        }

                    }

                    //k4      
                    double k4_r1 = x1 + ((h) * k3[0][0]);
                    double k4_r2 = x2 + ((h) * k3[1][0]);
                    double k4_r3 = x3 + ((h) * k3[2][0]);

                    double k4_r4[][] = {{k4_r1}, {k4_r2}, {k4_r3}};
                    double k4_r[][] = new double[3][1];

                    for (int n1 = 0; n1 < a.length; n1++) {
                        for (int n2 = 0; n2 < k4_r4.length - 2; n2++) {
                            k4_r[n1][n2] = 0;
                            for (int n3 = 0; n3 < a.length; n3++) {
                                k4_r[n1][n2] += a[n1][n3] * k4_r4[n3][n2];
                            }
                        }
                    }

                    for (int n1 = 0; n1 < 3; n1++) {
                        for (int n2 = 0; n2 < 1; n2++) {
                            k4[n1][n2] = k4_r[n1][n2] + k1_r2[n1][n2];
                        }

                    }

                    x1 = x1 + ((h / 6) * (k1[0][0] + (2 * k2[0][0]) + (2 * k3[0][0]) + k4[0][0]));    // x1 
                    x2 = x2 + ((h / 6) * (k1[1][0] + (2 * k2[1][0]) + (2 * k3[1][0]) + k4[1][0]));    // x2
                    x3 = x3 + ((h / 6) * (k1[2][0] + (2 * k2[2][0]) + (2 * k3[2][0]) + k4[2][0]));    // x3

                    //y
                    for (int n1 = 0; n1 < c.length; n1++) {
                        for (int n2 = 0; n2 < x.length - 2; n2++) {
                            y = 0;
                            for (int n3 = 0; n3 < x.length; n3++) {
                                y += c[n1][n3] * x[n3][n2];

                            }
                        }
                    }

                    //u_res.add(y);

                   // DecimalFormat df = new DecimalFormat("#.####");
                   // u_res.add(Double.parseDouble(df.format(y)));
                    // System.out.println(y);

                    //error
                    epre = ecur;
                    ecur = sp - y;
                    e.add(ecur);
                    if(i==0){
                        t1.add(0.0);
                    }else{
                        t1.add(i * t);
                    }
                        

                    //u
                    double r1 = kp * ecur;
                    double r3 = kd * (ecur - epre);
                    double r2_e = 0;
                    for (double k : e) {
                        r2_e += k;

                    }

                    if(((countError+1)%200) == 0)
                    {
                       System.out.println("Count of error "+countError);
                       double tempError = r2_e/1000;
                       errorSum.add(tempError);
                    }
                    countError++;
                    
                    double r2 = ki * r2_e;

                    u = r1 + r2 + r3;
                    
                    DecimalFormat df = new DecimalFormat("#.####");
                    if(i==0){
                       u_res.add(0.0); 
                    }else{
                       u_res.add(Double.parseDouble(df.format(u))); 
                    }
                    
                    
                }

            } else if (transfer.equals("Second Order")) {

                double y = 0;
                double u = 0;
                double ecur = 0;
                double epre = 0;
                double x1 = 0;
                double x2 = 0;



                double h = 0.001;

                double a[][] = {{-2, -1}, {1, 0}};
                double b[][] = {{1}, {0}};
                double c[][] = {{0, 1}};

                int countError = 0;

                for (int i = 0; i <= 15000; i++) {

                    s1.add(sp);
                    double x[][] = {{x1}, {x2}};

                    double k1[][] = new double[2][1];
                    double k2[][] = new double[2][1];
                    double k3[][] = new double[2][1];
                    double k4[][] = new double[2][1];
                    // k1
                    double k1_r1[][] = new double[2][1];
                    for (int n1 = 0; n1 < 2; n1++) {
                        for (int n2 = 0; n2 < 1; n2++) {
                            k1_r1[n1][n2] = 0;
                            for (int n3 = 0; n3 < 2; n3++) {
                                k1_r1[n1][n2] += a[n1][n3] * x[n3][n2];

                            }
                        }
                    }

                    double k1_r2[][] = new double[2][1];
                    for (int n1 = 0; n1 < 2; n1++) {
                        for (int n2 = 0; n2 < 1; n2++) {

                            k1_r2[n1][n2] = b[n1][n2] * u;


                        }
                    }

                    for (int n1 = 0; n1 < 2; n1++) {
                        for (int n2 = 0; n2 < 1; n2++) {
                            k1[n1][n2] = k1_r1[n1][n2] + k1_r2[n1][n2];

                        }

                    }

                    //k2
                    double k2_r1 = x1 + ((h / 2) * k1[0][0]);
                    double k2_r2 = x2 + ((h / 2) * k1[1][0]);

                    double k2_r4[][] = {{k2_r1}, {k2_r2}};
                    double k2_r[][] = new double[2][1];

                    for (int n1 = 0; n1 < a.length; n1++) {
                        for (int n2 = 0; n2 < k2_r4.length - 1; n2++) {
                            k2_r[n1][n2] = 0;
                            for (int n3 = 0; n3 < a.length; n3++) {
                                k2_r[n1][n2] += a[n1][n3] * k2_r4[n3][n2];

                            }
                        }
                    }


                    for (int n1 = 0; n1 < 2; n1++) {
                        for (int n2 = 0; n2 < 1; n2++) {
                            k2[n1][n2] = k2_r[n1][n2] + k1_r2[n1][n2];

                        }

                    }

                    // k3    
                    double k3_r1 = x1 + ((h / 2) * k2[0][0]);
                    double k3_r2 = x2 + ((h / 2) * k2[1][0]);

                    double k3_r4[][] = {{k3_r1}, {k3_r2}};
                    double k3_r[][] = new double[2][1];

                    for (int n1 = 0; n1 < a.length; n1++) {
                        for (int n2 = 0; n2 < k3_r4.length - 1; n2++) {
                            for (int n3 = 0; n3 < a.length; n3++) {
                                k3_r[n1][n2] = 0;
                                k3_r[n1][n2] += a[n1][n3] * k3_r4[n3][n2];
                            }
                        }
                    }

                    for (int n1 = 0; n1 < 2; n1++) {
                        for (int n2 = 0; n2 < 1; n2++) {
                            k3[n1][n2] = k3_r[n1][n2] + k1_r2[n1][n2];
                        }

                    }

                    //k4      
                    double k4_r1 = x1 + ((h) * k3[0][0]);
                    double k4_r2 = x2 + ((h) * k3[1][0]);

                    double k4_r4[][] = {{k4_r1}, {k4_r2}};
                    double k4_r[][] = new double[2][1];

                    for (int n1 = 0; n1 < a.length; n1++) {
                        for (int n2 = 0; n2 < k4_r4.length - 1; n2++) {
                            for (int n3 = 0; n3 < a.length; n3++) {
                                k4_r[n1][n2] = 0;
                                k4_r[n1][n2] += a[n1][n3] * k4_r4[n3][n2];
                            }
                        }
                    }

                    for (int n1 = 0; n1 < 2; n1++) {
                        for (int n2 = 0; n2 < 1; n2++) {
                            k4[n1][n2] = k4_r[n1][n2] + k1_r2[n1][n2];
                        }

                    }

                    x1 = x1 + ((h / 6) * (k1[0][0] + (2 * k2[0][0]) + (2 * k3[0][0]) + k4[0][0]));    // x1 
                    x2 = x2 + ((h / 6) * (k1[1][0] + (2 * k2[1][0]) + (2 * k3[1][0]) + k4[1][0]));    // x2

                    //y
                    for (int n1 = 0; n1 < c.length; n1++) {
                        for (int n2 = 0; n2 < x.length - 1; n2++) {
                            y = 0;
                            for (int n3 = 0; n3 < x.length; n3++) {
                                y += c[n1][n3] * x[n3][n2];


                            }
                        }
                    }

                    //u_res.add(y);

                   // DecimalFormat df = new DecimalFormat("#.####");
                   // u_res.add(Double.parseDouble(df.format(y)));
//                    System.out.println(y);

                    //error
                    epre = ecur;
                    ecur = sp - y;
                    e.add(ecur);
                    if(i==0){
                        t1.add(0.0);
                    }else{
                        t1.add(i * t);
                    }
                    //u
                    double r1 = kp * ecur;
                    double r3 = kd * (ecur - epre);
                    double r2_e = 0;
                    for (double k : e) {
                        r2_e += k;

                    }
                    
                    if(((countError+1)%200) == 0)
                    {
                       //System.out.println("Count of error "+countError);
                       double tempError = r2_e/1000;
                       errorSum.add(tempError);
                    }
                    countError++;

                    double r2 = ki * r2_e;

                    u = r1 + r2 + r3;
                    
                    DecimalFormat df = new DecimalFormat("#.####");
                    if(i==0){
                       u_res.add(0.0); 
                    }else{
                       u_res.add(Double.parseDouble(df.format(u))); 
                    }
                    
                    //System.out.println(u);
                    
                }
              
            }

            

        %>

        <div>
            <table class="table">
                <tr>
                    <td style="width: 30%">
                        Transfer Function
                    </td>
                    <td style="width: 10%">
                        :
                    </td>
                    <td style="width: 60%">
                        <%= transfer%>
                    </td>
                    
                    
                </tr>
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
                <!--               <tr>
                                   <td style="width: 30%">
                                       Type
                                   </td>
                                   <td style="width: 10%">
                                       :
                                   </td>
                                   <td style="width: 60%">
                <%= typeop%>
            </td>
        </tr>
                -->              <tr>
                    <td>
                        Sampling Time
                    </td>
                    <td>
                        :
                    </td>
                    <td>
                        <%= time%>
                    </td>
                </tr>
                <tr>
                    <td>
                        Set Point
                    </td>
                    <td>
                        :
                    </td>
                    <td>
                        <%= setpoint%>
                    </td>
                </tr>
                <tr>
                    <td>
                        kp
                    </td>
                    <td>
                        :
                    </td>
                    <td>
                        <%= kpval%> 
                    </td>
                </tr>
                <tr>
                    <td>
                        kd
                    </td>
                    <td>
                        :
                    </td>
                    <td>
                        <%= kdval%>
                    </td>
                </tr>
                <tr>
                    <td>
                        ki
                    </td>
                    <td>
                        :
                    </td>
                    <td>
                        <%= kival%>
                    </td>
                </tr>
                <tr>
                    <td>
                        <br/><br/>
                        <input type="button" id="plot-graph" value="Plot Graph"/>
                    </td>
                    <td colspan="2">
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
        <%

            session.setAttribute("timesecond", t1);
            JSONObject object = new JSONObject();
            object.put("tvalues", t1);
            object.put("uvalues", u_res);
            object.put("setpoint", s1);
            session.setAttribute("graph-data", object);
            session.setAttribute("error", e);
            session.setAttribute("sum-error", errorSum);
        %>    
        <!--        <input type="button" value="Plot Trend" id="plot-trend"/>-->
        <div id ="graph" style="width:100%; height: 30%">

        </div>
       

    </body>
    <script type="text/javascript" src="Exp7new.js"></script>

</html>
