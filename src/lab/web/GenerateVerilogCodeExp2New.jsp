<%-- 
    Document   : GenerateVerilogCodeExp2New
    Created on : 3 Oct, 2012, 12:56:33 PM
    Author     : shree
--%>

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
                var url;
                $("#generate").bind({
                    click: function(){
                        $.ajax({
                            url: 'VerilogAbstractionLevelExp2New',
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
            String exp = request.getParameter("opExp");
            String level = request.getParameter("opAbs");

            session = request.getSession();
            session.setAttribute("expt", exp);
            session.setAttribute("absLevel", level);
            session.setAttribute("setvalexp2New", "true");
            if (exp.equals("4-1 Multiplexer")) {
                String muxInput1 = request.getParameter("mux-input-1");
                String muxInput2 = request.getParameter("mux-input-2");
                String muxInput3 = request.getParameter("mux-input-3");
                String muxInput4 = request.getParameter("mux-input-4");
                String muxS1 = request.getParameter("mux-s1");
                String muxS0 = request.getParameter("mux-s0");

        %>

        <div>
            <table class="table">
                <tr>
                    <td style="vertical-align: top;width: 30%;">
                        Experiment
                    </td>
                    <td style="vertical-align: top;width: 10%;">
                        :
                    </td>
                    <td style="vertical-align: top;width: 60%;">
                        <%=exp%>
                    </td>
                </tr>

                <tr>
                    <td style="vertical-align: top;width: 30%;">
                        Verilog abstraction level
                    </td>
                    <td style="vertical-align: top;width: 10%;">
                        :
                    </td>
                    <td style="vertical-align: top;width:60%;">
                        <%=level%>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align: top;width: 30%;">
                        1st Input
                    </td>
                    <td style="vertical-align: top;width: 10%;">
                        :
                    </td>
                    <td style="vertical-align: top;width:60%;">
                        <%=muxInput1%>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align: top;width: 30%;">
                        2nd Input
                    </td>
                    <td style="vertical-align: top;width: 10%;">
                        :
                    </td>
                    <td style="vertical-align: top;width:60%;">
                        <%=muxInput2%>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align: top;width: 30%;">
                        3rd Input
                    </td>
                    <td style="vertical-align: top;width: 10%;">
                        :
                    </td>
                    <td style="vertical-align: top;width:60%;">
                        <%=muxInput3%>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align: top;width: 30%;">
                        4th Input
                    </td>
                    <td style="vertical-align: top;width: 10%;">
                        :
                    </td>
                    <td style="vertical-align: top;width:60%;">
                        <%=muxInput4%>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align: top;width: 30%;">
                        S<sub>1</sub>
                    </td>
                    <td style="vertical-align: top;width: 10%;">
                        :
                    </td>
                    <td style="vertical-align: top;width:60%;">
                        <%=muxS1%>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align: top;width: 30%;">
                        S<sub>0</sub>
                    </td>
                    <td style="vertical-align: top;width: 10%;">
                        :
                    </td>
                    <td style="vertical-align: top;width:60%;">
                        <%=muxS0%>
                    </td>
                </tr>
            </table>
        </div>
        <%
            session.setAttribute("muxInput-1", muxInput1);
            session.setAttribute("muxInput-2", muxInput2);
            session.setAttribute("muxInput-3", muxInput3);
            session.setAttribute("muxInput-4", muxInput4);
            session.setAttribute("mux-s1", muxS1);
            session.setAttribute("mux-s0", muxS0);

        } else {
            String adderInput1 = request.getParameter("adder-input-1");
            String adderInput2 = request.getParameter("adder-input-2");
            String adderCarry = request.getParameter("adder-carry");

        %>
        <div>
            <table class="table">
                <tr>
                    <td style="vertical-align: top;width: 30%;">
                        Experiment
                    </td>
                    <td style="vertical-align: top;width: 10%;">
                        :
                    </td>
                    <td style="vertical-align: top;width: 60%;">
                        <%=exp%>
                    </td>
                </tr>

                <tr>
                    <td style="vertical-align: top;width: 30%;">
                        Verilog abstraction level
                    </td>
                    <td style="vertical-align: top;width: 10%;">
                        :
                    </td>
                    <td style="vertical-align: top;width:60%;">
                        <%=level%>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align: top;width: 30%;">
                        1st Input
                    </td>
                    <td style="vertical-align: top;width: 10%;">
                        :
                    </td>
                    <td style="vertical-align: top;width:60%;">
                        <%=adderInput1%>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align: top;width: 30%;">
                        2nd Input
                    </td>
                    <td style="vertical-align: top;width: 10%;">
                        :
                    </td>
                    <td style="vertical-align: top;width:60%;">
                        <%=adderInput2%>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align: top;width: 30%;">
                        Initial Carry in
                    </td>
                    <td style="vertical-align: top;width: 10%;">
                        :
                    </td>
                    <td style="vertical-align: top;width:60%;">
                        <%=adderCarry%>
                    </td>
                </tr>

            </table>
        </div>

        <%
                session.setAttribute("adderInput-1", adderInput1);
                session.setAttribute("adderInput-2", adderInput2);
                session.setAttribute("adder-carry", adderCarry);
            }
            out.println(
                    "<br><div class='rnd' id='laxdivk' style='display: none' ><strong>"
                    + "<div id='laxdiv'> Verilog code generated successfully!! "
                    + "click on Load Program tab</div>"
                    + "</strong></div>");
            out.print(
                    "<br><input class=\"buttons\" type=\"button\" name=\"gen\" id=\"generate\" value=\"Generate Verilog code\" ");

        %>

    </body>
</html>
