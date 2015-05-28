<%-- 
    Document   : animateexp6
    Created on : 5 Jan, 2012, 11:28:08 AM
    Author     : root
--%>

<%@page import="java.math.BigInteger"%>
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
            .button1 {
                /* Sliding right image */
                background: transparent url('button_right.png') no-repeat scroll top right; 
                display: block;
                float: left;
                height: 32px; /* CHANGE THIS VALUE ACCORDING TO IMAGE HEIGHT */
                margin-right: 6px;
                padding-right: 20px; /* CHENGE THIS VALUE ACCORDING TO RIGHT IMAGE WIDTH */
                /* FONT PROPERTIES */
                text-decoration: none;
                color: #000000;
                font-family: Arial, Helvetica, sans-serif;
                font-size:12px;
                font-weight:bold;
            }

            .rnd {
                border: solid 1px black;
                height: 30px;
                width: 75%;
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
            /* Gradient 2 */
            .tb7 {
                /* width: 140px;*/
                background: transparent url('images/bg.jpg') no-repeat;
                color : #747862;
                height:20px;
                border:0;
                padding:4px 8px;
                margin-bottom:0px;
            }

            /* Gradient 1 */
            .tb10 {
                background-image:url(images/bg_form.png);
                background-repeat:repeat-x;
                border:1px solid #d1c7ac;
                width: 230px;
                color:#333333;
                padding:3px;
                margin-right:4px;
                margin-bottom:8px;
                font-family:tahoma, arial, sans-serif;
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
                
                $("#submitexp6").bind({
                    click:function(){
                        valid=true;
                        var lax=$("#givendecimal").val().split(".");
                        // alert(lax.length);
                        if(lax.length>2)
                        {
                            alert("Invalid Number");
                            valid=false;
                        }
                        else  if(lax[0]=="")
                        {
                            alert("Invalid Number : You should put 0 before .");
                            valid=false;
                        }
                        else if(lax[1]==""){
                            alert("Invalid Number");
                            valid=false;
                        }
                        if($("#givendecimal").val()=="" || $("#givendecimal").val()==null)
                        {
                            alert("Decimal number field can not be blank.");
                            valid= false;
                        }
                        return valid;
                    } 
                });
                
                $("#submitexp61").bind({
                    click:function(){
                        valid=true;
                        var f1=$("#floating1").val();
                        var f2=$("#floating2").val();
                        var lax=$("#floating1").val().split(".");
                        // alert(lax.length);
                        if(lax.length>2)
                        {
                            alert("Invalid First Number");
                            valid=false;
                        }
                        else  if(lax[0]=="")
                        {
                            alert("Invalid First Number : You should put 0 before .");
                            valid=false;
                        }
                        else  if(lax[1]=="")
                        {
                            alert("First Number is Invalid.");
                            valid=false;
                        }
                        lax=$("#floating2").val().split(".");
                        // alert(lax.length);
                        if(lax.length>2)
                        {
                            alert("Invalid Second Number");
                            valid=false;
                        }
                        else  if(lax[0]=="")
                        {
                            alert("Invalid Second Number : You should put 0 before .");
                            valid=false;
                        }
                        else  if(lax[1]=="")
                        {
                            alert("Second Number is Invalid");
                            valid=false;
                        }
                       
                        if(f1=="" || f1==null)
                        {
                            alert("First number field can not be blank.");
                            valid=false;
                        }
                        if(f2=="" || f2==null)
                        {
                            alert("Second number field can not be blank.");
                            valid=false;
                        }
                        return valid;
                       
                    } 
                });
                
                $("#floating1").bind({
                    keypress: function(e){
                        var lax1=e.which>=58;
                        var lax2=e.which<=47;
                        if(lax1 || lax2 && e.which!=8 && e.which!=9 && e.which!=46 && e.which!=45)
                        {
                            e.preventDefault();
                        }
                    }
                    
                });
                $("#floating2").bind({
                    keypress: function(e){
                        var lax1=e.which>=58;
                        var lax2=e.which<=47;
                        if(lax1 || lax2 && e.which!=8 && e.which!=9 && e.which!=46 && e.which!=45)
                        {
                            e.preventDefault();
                        }
                    }
                });
                $("#givendecimal").bind({
                    keypress: function(e){
                        var lax1=e.which>=58;
                        var lax2=e.which<=47;
                        if(lax1 || lax2 && e.which!=8 && e.which!=9 && e.which!=46 && e.which!=45)
                        {
                            e.preventDefault();
                        }
                    }
                });
                
                $("#subop61").bind({
                    change:function(){
                        var selopsub=$("#subop61").val();
                        switch(selopsub){
                            case 'Square Root':
                                $("#notsqrt").attr("style","display: none");
                                $("#laxkum1").html("Your Number");
                                break;
                            default:
                                $("#notsqrt").attr("style","display: block");
                                $("#laxkum1").html("Enter 1<sup>st</sup> Floating Number");
                                break;
                        }
                    }
                });
                
                
                $("#op6").bind({
                    change:function(){
                        hideAll();
                        var selops=$("#op6").val();
                        switch(selops){
                            case 'Floating Point Conversion':
                                $("#td123").attr("style","display:block");
                                $("#td124").attr("style","display:none");
                                $("#divfpc").attr("style","display:block");
                                break;
                            case 'Floating Point Arithmetics':
                                $("#td124").attr("style","display:block");
                                $("#td123").attr("style","display:none");
                                $("#divfpa").attr("style","display:block");
                                break;
                        }
                        
                    }
                });
                
                function hideAll()
                {
                    $("#divfpc").attr("style","display:none");
                    $("#divfpa").attr("style","display:none");
                    $("#divfpc").attr("style","display:none");
                    $("#divfpc").attr("style","display:none");
                }
                
                
                
                
                
            });
            
            
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
        <form name="exp6" id="expss6" action="GenerateVerilogCodeExp6.jsp" method="POST">

            <div id="animat6">
                <table >
                    <tr>
                        <td style="vertical-align: top" >
                            Select Operation
                        </td>
                        <td style="vertical-align: top">
                            :
                        </td>
                        <td >
                            <table>
                                <tr>
                                    <td style="vertical-align: top">
                                        <select id="op6" name="op6" >
                                            <option selected>Floating Point Conversion</option>
                                            <option>Floating Point Arithmetics</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td123" style="display:block; vertical-align: top">
                                        <select id="subop6" name="subop6" >
                                            <option selected>IEEE 754 format Half Precision</option>
                                            <option >IEEE 754 format Single Precision</option>
                                            <option >IEEE 754 format Double Precision</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td124" style="display:none; vertical-align: top">
                                        <select id="subop61" name="subop61" >
                                            <option selected>Addition</option>
                                            <option >Multiplication</option>
                                            <option>Subtraction</option>
                                            <!--                                            <option >Division</option>
                                                                                        <option >Square Root</option>-->
                                        </select>
                                    </td>
                                </tr>
                            </table>



                        </td>
                    </tr>

                </table>
                <div id="divfpc" style="display: block">
                    <table>
                        <tr>
                            <td>
                                Enter Decimal Number 
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <input  type="text" name="givendecimal" id="givendecimal" value="0.0" />
                            </td>

                        </tr>
                    </table>
                    <div>
                        <br>
                        <input class="buttons" type="submit" id="submitexp6" value="Calculate" />
                        <input class="buttons" type="reset" id="resetexp6" value="Clear" />
                    </div>


                    <%
                    %>
                </div>

                <div id="divfpa" style="display: none">
                    <table>
                        <tr>
                            <td id="laxkum1">
                                Enter 1<sup>st</sup> Floating Number
                            </td>
                            <td>:
                            </td>
                            <td>
                                <input type="text" name="floating1" id="floating1" value="0.0" />
                            </td>
                        </tr>
                        <tr >
                            <td colspan="3">
                                <table style="display :block" id="notsqrt">
                                    <tr>
                                        <td>
                                            Enter 2<sup>nd</sup> Floating Number
                                        </td>
                                        <td>:
                                        </td>
                                        <td>
                                            <input type="text" name="floating2" id="floating2" value="0.0" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>

                    <div>
                        <br>
                        <input class="buttons" type="submit" id="submitexp61" value="Calculate" />
                        <input class="buttons" type="reset" id="resetexp61" value="Clear" />
                    </div>
                </div>

            </div>


        </form>  


        <%
            String laxpk = (String) session.getAttribute("setvalexp6");
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
                String operation = (String) session.getAttribute("operation6");
                if (operation.equals("Floating Point Conversion")) {
                    String subOperation = (String) session.getAttribute("suboperation6");
                    String givenDecimal = (String) session.getAttribute("givendec6");
                    String globalAnswer = (String) session.getAttribute("globalAns6");
                    String globalHex = (String) session.getAttribute("globalHex6");

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
            <%     }
                if (operation.equals("Floating Point Arithmetics")) {

                    String subOperation = (String) session.getAttribute("suboperation61");
                    String float1 = (String) session.getAttribute("givendec61");
                    String f2 = (String) session.getAttribute("givendec62");
                    String globalAnswer = (String) session.getAttribute("globalAns61");
                    String globalHex = (String) session.getAttribute("globalHex61");
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
                            <%if (!subOperation.equals("Square Root")) {%>
                            Your 1<sup>st</sup> Number
                            <%} else {
                            %>
                            Your Number
                            <%                            }%>

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
                }



            %>


        </div>
        <%



            }

        %>
    </body>
</html>
