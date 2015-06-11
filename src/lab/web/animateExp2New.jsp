<%-- 
    Document   : animateExp2New
    Created on : 3 Oct, 2012, 12:43:52 PM
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
                
                $("#mux-s1").bind({
                    keypress:function(e){
                        if(e.which!=49 && e.which!=48 && e.which!=8 && e.which!=9)
                        {
                            e.preventDefault();
                        }
                    }
                });
                
                $("#mux-s0").bind({
                    keypress:function(e){
                        if(e.which!=49 && e.which!=48 && e.which!=8 && e.which!=9)
                        {
                            e.preventDefault();
                        }
                    }
                });
                
                $("#adder-input-1").bind({
                    keypress:function(e){
                        if(e.which!=49 && e.which!=48 && e.which!=8 && e.which!=9)
                        {
                            e.preventDefault();
                        }
                    }
                });
                
                $("#adder-input-2").bind({
                    keypress:function(e){
                        if(e.which!=49 && e.which!=48 && e.which!=8 && e.which!=9)
                        {
                            e.preventDefault();
                        }
                    }
                });
                
                $("#adder-carry").bind({
                    keypress:function(e){
                        if(e.which!=49 && e.which!=48 && e.which!=8 && e.which!=9)
                        {
                            e.preventDefault();
                        }
                    }
                });
                
                
                $("#opExp").bind({
                    change:function(){
                        hideAll();
                        var selops=$("#opExp").val();
                         
                        switch(selops){
                            case '4-1 Multiplexer':
                                $("#mux-div").attr("style","display:inline");
                                $("#adder-div").attr("style","display:none");
                                break;
                               
                            case '4 bit full adder':
                                $("#mux-div").attr("style","display:none");
                                $("#adder-div").attr("style","display:inline");
                                break;
                          
                        }
                    }
                });
                
                $("#opExp").bind({
                    change:function(){
                        $("#adder-input-1").val("");
                        $("#adder-input-2").val("");
                        $("#adder-carry").val("");
                        $("#mux-input-1").val("");
                        $("#mux-input-2").val("");
                        $("#mux-input-3").val("");
                        $("#mux-input-4").val("");
                        $("#mux-s1").val("");
                        $("#mux-s0").val("");
                    }
                });
                
                $("#submitExp2New").bind({
                    click:function(){
                        valid=true;
                        var lax1 = parseFloat($("#mux-input-1").val());
                        var lax2 = parseFloat($("#mux-input-2").val());
                        var lax3 = parseFloat($("#mux-input-3").val());
                        var lax4 = parseFloat($("#mux-input-4").val());
                        var lax5 = parseFloat($("#mux-s1").val());
                        var lax6 = parseFloat($("#mux-s0").val());
                        var lax7 = parseFloat($("#adder-input-1").val());
                        var lax8 = parseFloat($("#adder-input-2").val());
                        var lax9 = parseFloat($("#adder-carry").val());
                        
                        var selops=$("#opExp").val();
                        
                        if(selops == "4-1 Multiplexer"){
                            
                            if( $("#mux-input-1").val()=="" || $("#mux-input-1").val()==null || 
                                $("#mux-input-2").val()=="" || $("#mux-input-2").val()==null ||
                                $("#mux-input-3").val()=="" || $("#mux-input-3").val()==null ||
                                $("#mux-input-4").val()=="" || $("#mux-input-4").val()==null ||
                                $("#mux-s1").val()=="" || $("#mux-s1").val()==null ||
                                $("#mux-s0").val()=="" || $("#mux-s0").val()==null
                        )
                            {
                                alert("All fields are necessary");
                                valid= false;
                            }
                        }else{
                            if( $("#adder-input-1").val()=="" || $("#mux-input-1").val()==null || 
                                $("#adder-input-2").val()=="" || $("#mux-input-2").val()==null ||
                                $("#adder-input-3").val()=="" || $("#mux-input-3").val()==null ||
                                $("#adder-carry").val()=="" || $("#mux-input-4").val()==null
                        )
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
                $("#mux-div").attr("style","display:none");
                $("#adder-div").attr("style","display:none");
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
        <form name="exp2New" id="exp2New" action="GenerateVerilogCodeExp2New.jsp" method="POST">
            <div>
                <table class="table">
                    <tr>
                        <td style="vertical-align: top;width: 30%;">
                            Select experiment
                        </td>
                        <td style="vertical-align: top;width: 10%;">
                            :
                        </td>
                        <td style="vertical-align: top;width: 60%;">
                            <select id="opExp" name="opExp">
                                <option selected>4-1 Multiplexer</option>
                                <option>4 bit full adder</option>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td style="vertical-align: top;width: 30%;">
                            Select verilog abstraction level
                        </td>
                        <td style="vertical-align: top;width: 10%;">
                            :
                        </td>
                        <td style="vertical-align: top;width:60%;">
                            <select id="opAbs" name="opAbs">
<!--                                <option selected>Switch level (Transistor)</option>-->
                                <option selected>Gate level (Structural)</option>
                                <option>Data flow level</option>
                                <option>Behavioural level</option>
                                <option>RTL Level (Resister-Transister level)</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>

            <div id="mux-div">
                <table class="table">
                    <tr>
                        <td style="vertical-align: top;width: 30%;">
                            Enter 1st input
                        </td>
                        <td style="vertical-align: top;width: 10%;">
                            :
                        </td>
                        <td style="vertical-align: top;width: 60%;" >
                            <input type="text" id="mux-input-1" name="mux-input-1" class="givendecimal"/> 
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top;width: 30%;">
                            Enter 2nd input
                        </td>
                        <td style="vertical-align: top;width: 10%;">
                            :
                        </td>
                        <td style="vertical-align: top;width: 60%;">
                            <input type="text" id="mux-input-2" name="mux-input-2" class="givendecimal"/> 
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top;width: 30%;">
                            Enter 3rd input
                        </td>
                        <td style="vertical-align: top;width: 10%;">
                            :
                        </td>
                        <td style="vertical-align: top;width: 60%;">
                            <input type="text" id="mux-input-3" name="mux-input-3" class="givendecimal"/> 
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top;width: 30%;">
                            Enter 4th input
                        </td>
                        <td style="vertical-align: top;width: 10%;">
                            :
                        </td>
                        <td style="vertical-align: top;width: 60%;">
                            <input type="text" id="mux-input-4" name="mux-input-4" class="givendecimal"/> 
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top;width: 30%;">
                            Enter S<sub>1</sub>
                        </td>
                        <td style="vertical-align: top;width: 10%;">
                            :
                        </td>
                        <td style="vertical-align: top;width: 60%;">
                            <input type="text" id="mux-s1" name="mux-s1" size="1" maxlength="1"/> 
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top;width: 30%;">
                            Enter S<sub>0</sub>
                        </td>
                        <td style="vertical-align: top;width: 10%;">
                            :
                        </td>
                        <td style="vertical-align: top;width: 60%;">
                            <input type="text" id="mux-s0" name="mux-s0" size="1" maxlength="1"/> 
                        </td>
                    </tr>
                </table>
            </div>
            <div id ="adder-div" style="display: none">
                <table class="table">
                    <tr>
                        <td style="vertical-align: top;width: 30%;">
                            Enter 1st input (Binary)
                        </td>
                        <td style="vertical-align: top;width: 10%;">
                            :
                        </td>
                        <td style="vertical-align: top;width: 60%;">
                            <input type="text" size="4" id="adder-input-1" maxlength="4" name="adder-input-1" /> 
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top;width: 30%;">
                            Enter 2nd input (Binary)
                        </td>
                        <td style="vertical-align: top;width: 10%;">
                            :
                        </td>
                        <td style="vertical-align: top;width: 60%;">
                            <input type="text" id="adder-input-2" name="adder-input-2" size="4" maxlength="4"/> 
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top;width: 30%;">
                            Enter initial carry in
                        </td>
                        <td style="vertical-align: top;width: 10%;">
                            :
                        </td>
                        <td style="vertical-align: top;width: 60%;">
                            <input type="text" id="adder-carry" name="adder-carry" size="1" maxlength="1"/> 
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <br>
                <input class="buttons" type="submit" id="submitExp2New" value="Submit" />
                <input class="buttons" type="reset" id="resetExp2New" value="Clear" />
            </div>
        </form>

        <%
            String laxpk = (String) session.getAttribute("setvalexp2New");
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
                String exp = (String) session.getAttribute("expt");
                String level = (String) session.getAttribute("absLevel");
                if (exp.equals("4-1 Multiplexer")) {
                    String muxInput1 = (String) session.getAttribute("muxInput-1");
                    String muxInput2 = (String) session.getAttribute("muxInput-2");
                    String muxInput3 = (String) session.getAttribute("muxInput-3");
                    String muxInput4 = (String) session.getAttribute("muxInput-4");
                    String muxS1 = (String) session.getAttribute("mux-s1");
                    String muxS0 = (String) session.getAttribute("mux-s0");
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
            <%            } else {
                String adderInput1 = (String) session.getAttribute("adderInput-1");
                String adderInput2 = (String) session.getAttribute("adderInput-2");
                String adderCarry = (String) session.getAttribute("adder-carry");
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

            <%                            }
                }
            %>
        </div>
    </body>
</html>
