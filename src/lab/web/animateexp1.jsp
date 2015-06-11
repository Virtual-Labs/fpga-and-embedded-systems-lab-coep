<%-- 
    Document   : animateexp1
    Created on : 14 Dec, 2011, 3:51:46 PM
    Author     : root
--%>

<%@page import="JavaFiles.Calculations"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
            button1 {
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
            }/*
            a.button span {
            // Background left image 
            background: transparent url('button_left.png') no-repeat; 
            display: block;
            line-height: 22px; // CHANGE THIS VALUE ACCORDING TO BUTTONG HEIGHT 
            padding: 7px 0 5px 18px;
            } 
            a.button:hover span{
            text-decoration:underline;
            }*/
            .cirdiv{
                height: 20px; width: 20px; background:#00ff00; vertical-align: top;
                text-align: center;
                border-radius: 20px;
                -moz-border-radius: 20px;
                -webkit-border-radius: 20px;


                cursor: pointer;
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

        </style>
        <script type="text/javascript" src="scripts/jquery.js"></script>
        <script type="text/javascript" src="scripts/jquery-ui.js"></script>
        <script type="text/javascript">
            var intersel;
            $(document).ready(function(){
                intersel=$("#intsel").val();
                showSpecific();
                $("#intsel").bind({
                    
                    change:function(){
                        intersel=$("#intsel").val();
                        showSpecific();
                    }
                });
                
                $("#sdutext").bind({
                    keypress: function(e){
                        //alert(e.which);

                        var lax1=e.which>=58;
                        var lax2=e.which<=47;
                        //alert(lax1);
                        //alert(lax2);
                        //alert(lax1 && lax2);
                        if(lax1 || lax2 && e.which!=8 && e.which!=9)
                        {
                            e.preventDefault();
                        }
                    }
                    
                });
                $("#sultext").bind({
                    keypress: function(e){
                        //alert(e.which);

                        var lax1=e.which>=58;
                        var lax2=e.which<=47;
                        //alert(lax1);
                        //alert(lax2);
                        //alert(lax1 && lax2);
                        if(lax1 || lax2 && e.which!=8 && e.which!=9)
                        {
                            e.preventDefault();
                        }
                    }
                    
                });
                
                
                
                $("#adtext").bind({
                    keypress:function(e)
                    {
                        if(e.which!=49 && e.which!=48 && e.which!=8 && e.which!=9)
                        {
                            e.preventDefault();
                        }
                    }
                });
                $("#sdtext").bind({
                    keypress:function(e)
                    {
                        if(e.which!=49 && e.which!=48 && e.which!=8 && e.which!=9)
                        {
                            e.preventDefault();
                        }
                    }
                });
                $("#sttext").bind({
                    keypress:function(e)
                    {
                        if(e.which!=49 && e.which!=48 && e.which!=8 && e.which!=9)
                        {
                            e.preventDefault();
                        }
                    }
                });
                $("#attext").bind({
                    keypress:function(e)
                    {
                        if(e.which!=49 && e.which!=48 && e.which!=8 && e.which!=9)
                        {
                            e.preventDefault();
                        }
                    }
                });
                
                
                $("#intsubsel1").bind({
                    change:function(){
                        var subtp1=$("#intsubsel1").val();
                        if(subtp1=="None")
                        {
                            $("#async").attr("style","display: none");
                        }
                        else{
                            $("#async").attr("style","display: block");
                            if(subtp1=="D Flip Flop")
                            {
                                $("#asyncd").attr("style","display: block");
                                $("#asynct").attr("style","display: none");
                                //                                $("#adtext").attr("required","required");
                                //                                $("#attext").removeAttr("required");
                            }
                            else
                            {
                                $("#asyncd").attr("style","display: none");
                                $("#asynct").attr("style","display: block");
                                //                                $("#attext").attr("required","required");
                                //                                $("#adtext").removeAttr("required");
                            }
                        }
                    }
                });
                
                $("#intsubsel2").bind({
                    change:function(){
                        var subtp=$("#intsubsel2").val();
                        //alert(subtp);
                        if(subtp=="Counter"){
                            $("#sync").attr("style","display: none");
                            $("#intsubsel3").attr("style","display: block");
                            $("#syncd").attr("style","display: none");
                            $("#synct").attr("style","display: none");
                            $("#asyncd").attr("style","display: none");
                            $("#asynct").attr("style","display: none");
                            //                            $("#sdtext").removeAttr("required");
                            //                            $("#sttext").removeAttr("required");
                        }
                        else if(subtp=="None")
                        {
                            $("#sync").attr("style","display: none");
                            $("#intsubsel3").attr("style","display: none");
                            //                            $("#sdtext").removeAttr("required");
                            //                            $("#sttext").removeAttr("required");
                        }
                        else
                        {
                            $("#intsubsel3").attr("style","display: none");
                            $("#sync").attr("style","display: block");
                            $("#syncc").attr("style","display: none");
                            //$("#synct").attr("style","display: none");
                            if(subtp=="D Flip Flop")
                            {
                                $("#syncd").attr("style","display: block");
                                $("#synct").attr("style","display: none");
                                
                                //$("#sdtext").attr("required","required");
                                //$("#sttext").removeAttr("required");
                            }
                            else
                            {
                                $("#syncd").attr("style","display: none");
                                $("#synct").attr("style","display: block");
                                //$("#sttext").attr("required","required");
                                // $("#sdtext").removeAttr("required");
                            }
                        }
                    }
                });
                
                $("#intsubsel3").bind({
                    change:function(){
                        $("#sync").attr("style","display: block");
                        $("#syncc").attr("style","display: block");
                        var tp=$("#intsubsel3").val();
                        if(tp=="None")
                        {
                            $("#synccup").attr("style","display : none");
                            $("#synccdown").attr("style","display : none");
                                
                        }
                        else  if(tp=="Up Counter")
                        {
                            $("#synccup").attr("style","display : block");
                            $("#synccdown").attr("style","display : none");          
                        }
                        else
                                    
                        {
                            $("#synccup").attr("style","display : none");
                            $("#synccdown").attr("style","display : block");            
                        }
                    }
                });
            
                $("#submithello").bind({
                    click:function()
                    {
                        if($("#htext").val()=="")
                        {
                            alert("Message field is blank!");
                            return false;
                        }
                        else    
                            return true;
                    }
                });
                $("#submitsd").bind({
                    click:function()
                    {
                        
                        valid=true;
                        if($("#sdutext").val()=="")
                        {
                            alert("Upper Bound field is blank!");
                            valid= false;
                        }
                        if(parseInt($("#sdutext").val())>255)
                        {
                            alert("Wrong upper bound");
                            valid=false;
                        }
                        if(parseInt($("#sdutext").val())<1)
                        {
                            alert("Wrong upper bound");
                            valid=false;
                        }
                        return valid;
                    }
                });
                $("#submitsu").bind({
                    click:function()
                    {
                        valid=true;
                        if($("#sultext").val()=="")
                        {
                            alert("Lower Bound field is blank!");
                            valid= false;
                        }
                        if(parseInt($("#sultext").val())>254)
                        {
                            alert("Wrong lower bound");
                            valid=false;
                        }
                        if(parseInt($("#sultext").val())<0)
                        {
                            alert("Wrong lower bound");
                            valid=false;
                        }
                        return valid;
                    }
                });
                
                
                $("#submitsyncd").bind({
                    click:function()
                    {
                        if($("#sdtext").val()=="")
                        {
                            alert("Data field is blank!");
                            return false;
                        }
                        else    
                            return true;
                    }
                });
                
                $("#submitsynct").bind({
                    click:function()
                    {
                        if($("#sttext").val()=="")
                        {
                            alert("Data field is blank!");
                            return false;
                        }
                        else    
                            return true;
                    }
                });
                $("#submitasyncd").bind({
                    click:function()
                    {
                        if($("#adtext").val()=="")
                        {
                            alert("Data field is blank!");
                            return false;
                        }
                        else    
                            return true;
                    }
                });
                
                $("#submitasynct").bind({
                    click:function()
                    {
                        if($("#attext").val()=="")
                        {
                            alert("Data field is blank!");
                            return false;
                        }
                        else    
                            return true;
                    }
                });
                
                
                
                
            });
            
            
            function showSpecific(){
                var laxpk=intersel;
                switch(laxpk)
                {
                    case 'None':
                        hideAll();
                        
                        break;
                    case 'Hello World':
                        //alert();
                        hideAll();
                        $("#htext").attr("required","required");
                        $("#helloworld").attr("style","display: block");
                        break;
                    case 'Asynchronous Design':
                        hideAll();
                        $("#intsubsel1").attr("style","display: block");
                        break;        
                    case 'Synchronous Design':
                        hideAll();
                        $("#intsubsel2").attr("style","display: block");
                        break;
                }
                
            }
            
            function hideAll(){
                $("#intsubsel1").attr("style","display: none");
                $("#intsubsel2").attr("style","display: none");
                $("#intsubsel3").attr("style","display: none");
                $("#helloworld").attr("style","display: none");
                $("#async").attr("style","display: none");
                $("#sync").attr("style","display: none");
                $("#syncc").attr("style","display: none");
                $("#adtext").removeAttr("required");
                $("#attext").removeAttr("required");
                $("#htext").removeAttr("required");
                $("#sdtext").removeAttr("required");
                $("#sttext").removeAttr("required");
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


        <%
        %>




    </head>
    <body>
        <form name="experiment1" action="GenerateVerilogCodeExp1.jsp" method="POST">
            <div id="maindiv">
                <table>
                    <tr>
                        <td >
                            Select Experiment
                        </td>


                        <td class="col">
                            :
                        </td>

                        <td>
                            <select id="intsel" name="intsel">
                                <option>None</option>
                                <option>Hello World</option>
                                <option>Asynchronous Design</option>
                                <option>Synchronous Design</option>

                            </select>
                        </td>
                        <td>
                            <select id="intsubsel1" name="intsubsel1" style="display: none">
                                <option>None</option>
                                <option>D Flip Flop</option>
                                <option>T Flip Flop</option>

                            </select>
                        </td>
                        <td>
                            <select id="intsubsel2" name="intsubsel2" style="display: none">
                                <option>None</option>
                                <option>D Flip Flop</option>
                                <option>T Flip Flop</option>
                                <option>Counter</option>

                            </select>
                        </td>
                        <td>
                            <select id="intsubsel3" name="intsubsel3" style="display: none">
                                <option>None</option>
                                <option>Up Counter</option>
                                <option>Down Counter</option>

                            </select>
                        </td>
                    </tr>



                </table>
                <hr>


                <div id="helloworld" style="display: none">
                    <table>
                        <tr>
                            <td  class="col">
                                Hello World Demo
                                <hr>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Put your string to display
                            </td>

                        </tr>
                        <tr>
                            <td>
                                <input class="tb7" type="text" name="htext" id="htext" value="" required="required" />
                            </td>

                        </tr>
                        <tr>
                            <td  class="col">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="col">
                                <input type="submit" class="buttons" name="submithello" id="submithello" value="SUBMIT" />
                                <input type="reset" class="buttons" name="resethello" id="resethello" value="CLEAR" />
                            </td>
                        </tr>

                    </table>
                </div>

                <div id="async" style="display: none">
                    <div id="asyncd" style="display: none">
                        <table>
                            <tr>
                                <td colspan="5" class="col">
                                    Asynchronous Reset D-Flip Flop
                                    <hr>
                                </td>
                            </tr>
                            <tr>
                                <td class="col">
                                    Data 
                                </td>
                                <td class="col">
                                    &nbsp;
                                </td>
                                <td class="col">
                                    Reset
                                </td>
                                <td class="col">
                                    &nbsp;
                                </td>
                                <td class="col">
                                    Clk
                                </td>
                            </tr>
                            <tr>
                                <td class="col">
                                    <input class="tb7" type="text" name="adtext" id="adtext" maxlength="16" size="16" required="required"/>
                                </td>
                                <td class="col">
                                    &nbsp;
                                </td>
                                <td class="col">
                                    <input type="checkbox" name="adcheck" id="adcheck" value="Reset" checked/>
                                </td>
                                <td class="col">
                                    &nbsp;
                                </td>
                                <td class="col">
                                    <input type="checkbox" name="adclk" id="adclk" checked disabled />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5" class="col">
                                    <input type="submit" class="buttons" name="submitasyncd" id="submitasyncd" value="SUBMIT" />
                                    <input type="reset" class="buttons" name="resetasyncd" id="resetasyncd" value="CLEAR" />
                                </td>
                            </tr>
                        </table>


                    </div>
                    <div id="asynct" style="display: none">

                        <table>
                            <tr>
                                <td colspan="5" class="col">
                                    Asynchronous Reset T-Flip Flop
                                    <hr>
                                </td>
                            </tr>
                            <tr>
                                <td class="col">
                                    Data 
                                </td>
                                <td class="col">
                                    &nbsp;
                                </td>
                                <td class="col">
                                    Reset
                                </td>
                                <td class="col">
                                    &nbsp;
                                </td>
                                <td class="col">
                                    Clk
                                </td>
                            </tr>
                            <tr>
                                <td class="col">
                                    <input class="tb7" type="text" name="attext" id="attext" maxlength="16" size="16" required="required"/>
                                </td>
                                <td class="col">
                                    &nbsp;
                                </td>
                                <td class="col">
                                    <input type="checkbox" name="atcheck" id="atcheck" value="Reset" checked/>
                                </td>
                                <td class="col">
                                    &nbsp;
                                </td>
                                <td class="col">
                                    <input type="checkbox" name="atclk" id="atclk" checked disabled />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5" class="col">
                                    <input type="submit" class="buttons" name="submitasynct" id="submitasynct" value="SUBMIT" />
                                    <input type="reset" class="buttons" name="resetasynct" id="resetasynct" value="CLEAR" />
                                </td>
                            </tr>
                        </table>
                        <hr>
                        <div>
                            <div style="text-align: center">
                                <img style="border: 1px solid black" src="images/adflipflop.png" width="458" height="147" alt="dflipflop5"  />

                                <p style="font-size: small" ><u><i>fig</i> : Working of Asynchronous T- Flip flop</u></p>
                            </div>
                        </div>
                    </div>



                </div>


                <div id="sync" style="display: none">

                    <div id="syncd" style="display: none">
                        <table>
                            <tr>
                                <td colspan="5" class="col">
                                    Synchronous Reset D-Flip Flop
                                    <hr>
                                </td>
                            </tr>
                            <tr>
                                <td class="col">
                                    Data 
                                </td>
                                <td class="col">
                                    &nbsp;
                                </td>
                                <td class="col">
                                    Reset
                                </td>
                                <td class="col">
                                    &nbsp;
                                </td>
                                <td class="col">
                                    Clk
                                </td>
                            </tr>
                            <tr>
                                <td class="col">
                                    <input class="tb7" type="text" name="sdtext" id="sdtext" maxlength="16" size="16" required="required"/>
                                </td>
                                <td class="col">
                                    &nbsp;
                                </td>
                                <td class="col">
                                    <input type="checkbox" name="sdcheck" id="sdcheck" value="Reset" checked/>
                                </td>
                                <td class="col">
                                    &nbsp;
                                </td>
                                <td class="col">
                                    <input type="checkbox" name="sdclk" id="sdclk" checked disabled />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5" class="col">
                                    <input type="submit" class="buttons" name="submitasyncd" id="submitsyncd" value="SUBMIT" />
                                    <input type="reset" class="buttons" name="resetasyncd" id="resetsyncd" value="CLEAR" />
                                </td>
                            </tr>
                        </table>
                        <hr>
                        <div>
                            <div style="text-align: center">
                                <img style="border: 1px solid black" src="images/dflipflop5.gif" width="458" height="147" alt="dflipflop5"  />

                                <p style="font-size: small" ><u><i>fig</i> : Working of Synchronous D- Flip flop</u></p>
                            </div>
                        </div>
                        <hr>
                    </div>
                    <div id="synct" style="display: none">

                        <table>
                            <tr>
                                <td colspan="5" class="col">
                                    Synchronous Reset T-Flip Flop
                                    <hr>
                                </td>
                            </tr>
                            <tr>
                                <td class="col">
                                    Data 
                                </td>
                                <td class="col">
                                    &nbsp;
                                </td>
                                <td class="col">
                                    Reset
                                </td>
                                <td class="col">
                                    &nbsp;
                                </td>
                                <td class="col">
                                    Clk
                                </td>
                            </tr>
                            <tr>
                                <td class="col">
                                    <input class="tb7" type="text" name="sttext" id="sttext" maxlength="16" size="16" required="required"/>
                                </td>
                                <td class="col">
                                    &nbsp;
                                </td>
                                <td class="col">
                                    <input type="checkbox" name="stcheck" id="stcheck" value="Reset" checked/>
                                </td>
                                <td class="col">
                                    &nbsp;
                                </td>
                                <td class="col">
                                    <input type="checkbox" name="stclk" id="stclk" checked disabled />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5" class="col">
                                    <input type="submit" class="buttons" name="submitasynct" id="submitsynct" value="SUBMIT" />
                                    <input type="reset" class="buttons" name="resetasynct" id="resetsynct" value="CLEAR" />
                                </td>
                            </tr>
                        </table>
                        <div id="counter" style="display: none">
                        </div>

                    </div>

                    <div id="syncc" style="display: none"> 
                        <div id="synccup" style="display: none">
                            <table>
                                <tr>
                                    <td colspan="3" class="col">
                                        Synchronous Up Counter
                                    </td>

                                </tr>
                                <tr>
                                    <td>Lower Bound</td>
                                    <td class="col">:</td>
                                    <td><input type="text" name="sultext" id="sultext" size="3" maxlength="3" value="0"/> </td>
                                </tr>

                                <tr>
                                    <td>reset</td>
                                    <td class="col">:</td>
                                    <td><input type="checkbox" name="surchk" id="surchk" checked disabled/> </td>
                                </tr>
                                <tr>
                                    <td>clk</td>
                                    <td class="col">:</td>
                                    <td><input type="checkbox" name="succhk" id="succhk" checked disabled/> </td>
                                </tr>
                                <tr>
                                    <td>enable</td>
                                    <td class="col">:</td>
                                    <td><input type="checkbox" name="suenchk" id="suenchk" value="enable" checked /> </td>
                                </tr>
                                <tr>
                                    <td colspan="3" class="col">
                                        <input type="submit" class="buttons" name="submitasynct" id="submitsu" value="SUBMIT" />
                                        <input type="reset" class="buttons" name="resetasynct" id="resetsu" value="CLEAR" />
                                    </td>

                                </tr>
                            </table>
                        </div>
                        <div id="synccdown" style="display: none">
                            <table>
                                <tr>
                                    <td colspan="3" class="col">
                                        Synchronous Down Counter
                                    </td>

                                </tr>
                                <tr>
                                    <td>Upper Bound</td>
                                    <td class="col">:</td>
                                    <td><input type="text" name="sdutext" id="sdutext" size="3" maxlength="3" value="255"/> </td>
                                </tr>

                                <tr>
                                    <td>reset</td>
                                    <td class="col">:</td>
                                    <td><input type="checkbox" name="sdrchk" id="sdrchk" checked disabled/> </td>
                                </tr>
                                <tr>
                                    <td>clk</td>
                                    <td class="col">:</td>
                                    <td><input type="checkbox" name="sdcchk" id="sdcchk" checked disabled/> </td>
                                </tr>
                                <tr>
                                    <td>enable</td>
                                    <td class="col">:</td>
                                    <td><input type="checkbox" name="sdenchk" id="sdenchk" value="enable" checked /> </td>
                                </tr>
                                <tr>
                                    <td colspan="3" class="col">
                                        <input type="submit" class="buttons" name="submitasynct" id="submitsd" value="SUBMIT" />
                                        <input type="reset" class="buttons" name="resetasynct" id="resetsd" value="CLEAR" />
                                    </td>

                                </tr>

                            </table>
                        </div>
                    </div>



                </div> <!--sync end-->

            </div><!--main div-->
        </form>

        <%
            String laxpk = (String) session.getAttribute("exp1value");
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


                String progType = (String) session.getAttribute("exp1type");

                if (progType.equals("Hello World")) {
                    String msg = (String) session.getAttribute("yourmsg");
            %>
            <div>

                <h3>Previous Result : </h3>

                <table>
                    <tr>
                        <td class="col">Your String to display  </td>
                        <td class="col">:</td>
                        <td class="col"><%=msg%></td>
                    </tr>
                </table>

            </div>
            <%
                }

                if (progType.equals("Asynchronous Design")) {

                    String flipflop = (String) session.getAttribute("flipfloptasync");
                    String data = (String) session.getAttribute("dataasync");
                    String answer = (String) session.getAttribute("answerasync");
                    boolean checked = (Boolean) session.getAttribute("checkedasync");
                    Calculations cal = new Calculations();
                    String data1 = "";
                    int arr[] = cal.toIntArray(data);
                    data1 = cal.toString(cal.bitwiseNOT(arr));

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
                                        <%if (checked) {%><%=answer%><%} else {%>0<%}%>
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
                }
                if (progType.equals("Synchronous Design")) {


                    String flipflop = (String) session.getAttribute("flipfloptasync");
                    if (!flipflop.equals("Counter")) {
                        String data = (String) session.getAttribute("dataasync");
                        Calculations cal = new Calculations();
                        String data1 = "";
                        int arr[] = cal.toIntArray(data);
                        data1 = cal.toString(cal.bitwiseNOT(arr));

                        String answer = (String) session.getAttribute("answerasync");
                        boolean checked = (Boolean) session.getAttribute("checkedasync");

            %>
            <div>

                <h3>Previous Result : </h3>
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
                                        <%if (checked) {%><%=answer%><%} else {%>0<%}%>
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
                }//if not counter

                if (flipflop.equals("Counter")) {
                    String counterType = (String) session.getAttribute("countertype");
                    boolean enable = (Boolean) session.getAttribute("enabled");
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
            <%}

                }
            %>
        </div>
        <%
            }
        %>


    </body>
</html>
