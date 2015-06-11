<%-- 
   Document   : animate
   Created on : 29 Nov, 2011, 12:41:50 PM
   Author     : root
--%>

<%@page import="JavaFiles.GenerateVerilogCode"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <script type="text/javascript" src="scripts/jquery.js"></script>
        <script type="text/javascript" src="scripts/jquery-ui.js"></script>

        <style>
            .cirdiv{
                height: 20px; width: 20px; background:#00ff00; vertical-align: top;
                text-align: center;
                border-radius: 20px;
                -moz-border-radius: 20px;
                -webkit-border-radius: 20px;


                cursor: pointer;
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
        <style type="text/css">
            .mydiv1{

                background-color:black;
                width:200px;
                height:200px;

            }

            .mytab1{
                border:"1";
                border-color:black;
                width:60px;
                height:100px;
                font-size: medium;

            }

            .myrow{
                height:20%;

            }
            .mycol{
                width:15px;
                text-align: center;

            }
            /* Gradient 2 */




            .mydd{
                height: 0px;
            }


        </style>


    </head>



    <body>


        <form action="GenerateCode.jsp" method="post" name="inputmatrix">

            <div id="main">
                <div>
                    <table width="140%" >
                        <tr>
                            <td width="50%">
                                Select Data Type :
                            </td>
                            <td width="40%">
                                <select id="dtype" name="dtype">
                                    <option id="dop0" >Fix Point</option>
                                    <option  id="dop1" >Floating Point</option>
                                </select>
                            </td>
                            <td width="50%" id="lax123">
                                <select id="subdtype" name="subdtype" style="visibility: hidden">
                                    <option id="subdop0" >Half Precision</option>
                                    <option  id="subdop1" selected >Single Precision</option>
                                    <option  id="subdop2" >Double Precision</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td width="50%">
                                Select Matrix Operation :
                            </td>
                            <td width="40%">
                                <select id="opera" name="opera">
                                    <option>None</option>
                                    <option  id="op1" >Addition</option>
                                    <!--option id="op2" >Subtraction</option-->
                                    <option id="op3" >Multiplication</option>
                                    <option id="op4" >Inverse</option>
                                    <!--option id="op5" >Transpose</option-->
                                </select>
                            </td>
                            <td width="50%" id="lax125" style="display: none">
                                <select id="invmet" name="inversetype" >
                                    <option id="inv0" >LU Factorization</option>
                                    <option  id="inv1" selected >Gauss-Jordan Elimination</option>
                                    <option  id="inv2" >Cholesky Factorization</option>
                                </select>
                            </td>
                        </tr>

                    </table>
                </div>
                <div class="mydd" id="laximpdiv">
                    <table id="tabs1" style="visibility: hidden">

                        <tr>
                            <td>
                                Select columns for Matrix A :
                            </td>
                            <td>
                                <select id="matacol" name="matacol" >
                                    <option id="mop1" >2</option>
                                    <option id="mop2" selected>3</option>
                                    <option id="mop3" >4</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Select rows for Matrix A :
                            </td>
                            <td>
                                <select id="matarow" name="matarow" >
                                    <option id="mop4" >2</option>
                                    <option id="mop5" selected>3</option>
                                    <option id="mop6" >4</option>
                                </select>
                            </td>
                        </tr>
                    </table>

                    <table id="tabs2" style="visibility: hidden">
                        <tr>
                            <td>
                                Select columns for Matrix B :
                            </td>
                            <td>
                                <select id="matbcol" name="matbcol" >
                                    <option id="mop7" >2</option>
                                    <option id="mop8" selected>3</option>
                                    <option id="mop9" >4</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Select rows for Matrix B :
                            </td>
                            <td>
                                <select id="matbrow" name="matbrow"  >
                                    <option id="mop10" >2</option>
                                    <option id="mop11" selected>3</option>
                                    <option id="mop12" >4</option>
                                </select>
                            </td>
                        </tr>
                        </span>
                    </table>


                    <table id="tabs3">
                        <tr>



                            <td>
                                <div id="table11" style="visibility: hidden">
                                    <table>
                                        <tr align= "center" >
                                            <td colspan="4" class="mycol">Matrix A</td>
                                            <td rowspan="5" class="mycol"><label id="label1"></label></td>

                                        </tr>

                                        <tr>

                                            <td class="mycol">

                                                <input name="txta00" type="text" id="txta00" size="3" />
                                            </td>
                                            <td class="mycol">
                                                <input name="txta01" type="text" id="txta01" size="3" />
                                            </td>
                                            <td class="mycol">
                                                <input name="txta02" type="text" id="txta02" size="3"  />
                                            </td>
                                            <td class="mycol">
                                                <input name="txta03" type="text" id="txta03" size="3"  />
                                            </td>

                                        </tr>

                                        <tr>
                                            <td class="mycol">
                                                <input name="txta10" type="text" id="txta10" size="3" />
                                            </td>
                                            <td class="mycol">
                                                <input name="txta11" type="text" id="txta11" size="3"  />
                                            </td>
                                            <td class="mycol">
                                                <input name="txta12" type="text" id="txta12" size="3"  />
                                            </td>
                                            <td class="mycol">
                                                <input name="txta13" type="text" id="txta13" size="3"  />
                                            </td>
                                        </tr>

                                        <tr>

                                            <td class="mycol">
                                                <input name="txta20" type="text" id="txta20" size="3"  />
                                            </td>
                                            <td class="mycol">
                                                <input name="txta21" type="text" id="txta21" size="3" />
                                            </td>
                                            <td class="mycol">
                                                <input name="txta22" type="text" id="txta22" size="3" />
                                            </td>
                                            <td class="mycol">
                                                <input name="txta23" type="text" id="txta23" size="3"  />
                                            </td>



                                        </tr>

                                        <tr>

                                            <td class="mycol">
                                                <input name="txta30" type="text" id="txta30" size="3"  />
                                            </td>
                                            <td class="mycol">
                                                <input name="txta31" type="text" id="txta31" size="3" />
                                            </td>
                                            <td class="mycol">
                                                <input name="txta32" type="text" id="txta32" size="3" />
                                            </td>
                                            <td class="mycol">
                                                <input name="txta33" type="text" id="txta33" size="3"  />
                                            </td>



                                        </tr>
                                    </table>
                                </div>
                            </td>


                            <td>
                                <div id="table22" style="visibility: hidden">
                                    <table>

                                        <tr>

                                            <td colspan="4"  class="mycol" width="30">Matrix B</td>
                                        </tr>

                                        <tr>

                                            <td class="mycol">

                                                <input name="txtb00" type="text" id="txtb00" size="3" />
                                            </td>
                                            <td class="mycol">
                                                <input name="txtb01" type="text" id="txtb01" size="3" />
                                            </td>
                                            <td class="mycol">
                                                <input name="txtb02" type="text" id="txtb02" size="3"  />
                                            </td>
                                            <td class="mycol">
                                                <input name="txtb03" type="text" id="txtb03" size="3"  />
                                            </td>

                                        </tr>

                                        <tr>
                                            <td class="mycol">
                                                <input name="txtb10" type="text" id="txtb10" size="3" />
                                            </td>
                                            <td class="mycol">
                                                <input name="txtb11" type="text" id="txtb11" size="3"  />
                                            </td>
                                            <td class="mycol">
                                                <input name="txtb12" type="text" id="txtb12" size="3"  />
                                            </td>
                                            <td class="mycol">
                                                <input name="txtb13" type="text" id="txtb13" size="3"  />
                                            </td>
                                        </tr>

                                        <tr>
                                            <td class="mycol">
                                                <input name="txtb20" type="text" id="txtb20" size="3"  />
                                            </td>
                                            <td class="mycol">
                                                <input name="txtb21" type="text" id="txtb21" size="3" />
                                            </td>
                                            <td class="mycol">
                                                <input name="txtb22" type="text" id="txtb22" size="3" />
                                            </td>
                                            <td class="mycol">
                                                <input name="txtb23" type="text" id="txtb23" size="3"  />
                                            </td>

                                        </tr>
                                        <tr>
                                            <td class="mycol">
                                                <input name="txtb30" type="text" id="txtb30" size="3"  />
                                            </td>
                                            <td class="mycol">
                                                <input name="txtb31" type="text" id="txtb31" size="3" />
                                            </td>
                                            <td class="mycol">
                                                <input name="txtb32" type="text" id="txtb32" size="3" />
                                            </td>
                                            <td class="mycol">
                                                <input name="txtb33" type="text" id="txtb33" size="3"  />
                                            </td>

                                        </tr>


                                    </table>
                                </div>
                            </td>


                            <td>

                                <table>




                                </table>

                            </td>



                        </tr>
                        <tr>

                            <td rowspan="3" align="left" valign="middle" class="mycol"><input class="buttons" type="submit" style="visibility: hidden" id="calculate" value="Calculate"></input></td>
                            <td>
                                <div id="msgs" style="display: none">
                                    <div class='rnd' id='laxdiv1' style='display: block'>Matrix row x columns mismatch</div>
                                    <div class='rnd' id='laxdiv2' style='display: block'>One of the field is blank</div>
                                </div>
                            </td>		
                        </tr>

                    </table>

                </div>

            </div>


        </form>

        <%
            String lax = (String) session.getAttribute("setvalue");
            System.out.println("value : " + lax);

            if (lax != null) {

                String operType = session.getAttribute("operator").toString();


                int m, n;
                int[][] mat1, mat2;
                long[][] ans;
                double[][] ansd;

                m = (Integer) session.getAttribute("laxm");
                n = (Integer) session.getAttribute("laxn");
                int x = m, y = n;
                if (operType.equalsIgnoreCase("X")) {
                    x = (Integer) session.getAttribute("laxx");
                    y = (Integer) session.getAttribute("laxy");
                }
                mat2 = new int[m][y];
                mat1 = (int[][]) session.getAttribute("laxmat1");
                if (operType.equalsIgnoreCase("X") || operType.equals("+")) {
                    mat2 = (int[][]) session.getAttribute("laxmat2");
                }


                //GenerateVerilogCode gvc=new GenerateVerilogCode();             
        %>
        <div>

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
                <h3>Previous Result:</h3>

                <%
                    //session.getAttribute("operator")
                    System.out.println(operType);
                    if (operType.equalsIgnoreCase("X") || operType.equals("+")) {
                        System.out.println("\n\n\n\ncoming\n\n\n\n");
                        ans = (long[][]) session.getAttribute("answers");
                        new GenerateVerilogCode().displayOutput(out, m, n, x, y, mat1, mat2, ans, operType);
                    } else if (operType.equals("^")) {
                        System.out.println("\n\n\n\nIcoming\n\n\n\n");
                        ansd = (double[][]) session.getAttribute("answers");
                        new GenerateVerilogCode().displaySingleOutput(out, m, n, mat1, ansd, operType);

                    }
                %>

            </div>

            <%
                }


            %>


            <script type="text/javascript">
                var arr=new Array();
                var arr1=new Array();
                var ans=new Array();
        
            
                $(document).ready(function(){
                    var selopt;
                    var mar=$("#matarow").val();
                    var mbr=$("#matbrow").val();
                    var mac=$("#matacol").val();
                    var mbc=$("#matbcol").val();
                    var i=0,j=0;
	
                    for(i=0;i<4;i++){
                        for(j=0;j<4;j++){
                            $("#txta"+i+""+j).bind({
                                click: function(){/*alert("Clicked");*/},
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
                                }//keypress
                            });

                            $("#txtb"+i+""+j).bind({
                                click: function(){/*alert("Clicked");*/},
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
                                }//keypress
                            });

                        }
                    }//for
        
                    $("#calculate").bind({
                        click: function(){
                    
                            //alert(selopt);
                            checkForBlankfields();
                    
                        }
                    });
        
                    $("#opera").bind({
                        change:function(){
                            selopt=$("#opera").val();
                            //alert(selopt);
                            showSpecific();
                            checkOperation();
                       
                        } 
                    });
                
                    $("#matacol").bind({
                        change: function(){
                            mac=$("#matacol").val();
                            showSpecific();
                   
                        }
                   
                   
                    });
                
                    $("#matbcol").bind({
                        change: function(){
                            mbc=$("#matbcol").val();
                            showSpecific();
                   
                        }
                   
                   
                    });
                
                    $("#matarow").bind({
                        change: function(){
                            mar=$("#matarow").val();
                            showSpecific();
                   
                        }
                   
                   
                    });
                
                    $("#matbrow").bind({
                        change: function(){
                            mbr=$("#matbrow").val();
                            showSpecific();
                   
                   
                        }
                   
                   
                    });
                
                    $("#dtype").bind({
                        change: function(){
                            var dtype=$("#dtype").val();
                            if(dtype=="Floating Point"){
                                //alert("hi");
                                $("#subdtype").attr("style","visibilty: visible");
                                $("#lax123").attr("style","display :block");
                            }
                            if(dtype=="Fix Point")
                            {
                                
                                //alert("HI");
                                $("#lax123").attr("style","display :none");
                                
                            }
                            
                        
                        }
                    
                    });
                
                
                    function showSpecific()
                    {
                        var c,d;
                        hideaAll();
                        $("#laximpdiv").removeAttr("class");
                        //                    $("#tabs3").attr("Style","visibility : visible");
                        //                    $("#tabs1").attr("Style","visibility : visible");
                        //                    $("#tabs2").attr("Style","visibility : visible");
                        //$("#main").attr("style","visibility : visible");
                        for(c=0;c<mar;c++)
                        {
                            for(d=0;d<mac;d++)
                            {
                                $("#txta"+c+d).attr("style","visibility : visible");
                            }
                        }
                        if(selopt=="Addition" || selopt=="Multiplication" ){
                            for(c=0;c<mbr;c++)
                            {
                                for(d=0;d<mbc;d++)
                                {
                                    $("#txtb"+c+d).attr("style","visibility : visible");
                                }
                            }     
                        }
                        if(selopt=="Inverse")
                        {
                            $("#lax125").attr("style","display : block");
                        }
                
                        if(selopt=="None")
                            hideaAll();
                        checkMatrixValidation()
                    }
                
                    function hideaAll()
                    {
                        var c,d;
                        $("#laximpdiv").attr("class","mydd");
                        $("#msgs").attr("style","display : none");
                        $("#lax125").attr("style","display : none");
                        //$("#main").attr("style","visibility :hidden");
                        //                    $("#tabs3").attr("Style","visibility : hidden");
                        //                    $("#tabs1").attr("Style","visibility : hidden");
                        //                    $("#tabs2").attr("Style","visibility : hidden");
                        for(c=0;c<4;c++)
                        {
                            for(d=0;d<4;d++)
                            {
                                $("#txtb"+c+d).attr("style","visibility : hidden");
                                $("#txta"+c+d).attr("style","visibility : hidden");
                            }
                        }
           
                    }
                
                    function checkForBlankfields()
                    {
                        var lax=true;
                        for(c=0;c<mar;c++)
                        {
                            for(d=0;d<mac;d++)
                            {
                                if( $("#txta"+c+d).val()=="")
                                    $("#txta"+c+d).val("0")
                               
                            }
                        }
               
                        for(c=0;c<mbr;c++)
                        {
                            for(d=0;d<mbc;d++)
                            {
                                if( $("#txtb"+c+d).val()=="")
                                    $("#txtb"+c+d).val("0")
                                
                            }
                        }    
                        return lax;
                    }
                
                    function checkMatrixValidation()
                    {
                        switch(selopt)
                        {
                            case 'Addition':
                                if(mar==mbr && mac==mbc)
                                {
                                    $("#calculate").removeAttr("disabled");
                                    
                                    $("#msgs").attr("style","display: none");
                                    $("#laxdiv1").attr("style","display: none");
                                    $("#laxdiv2").attr("style","display: none");
                                }
                                else
                                
                                {
                                    $("#calculate").attr("disabled", "disabled");
                                    $("#msgs").attr("style","display: block");
                                    $("#laxdiv1").attr("style","display: block");
                                    $("#laxdiv2").attr("style","display: none");
                                }
                                break;
                            case 'Multiplication':
                           
                                if(mar==mbc && mac==mbr)
                                {
                                    $("#calculate").removeAttr("disabled");
                                    
                                    $("#msgs").attr("style","display: none");
                                    $("#laxdiv1").attr("style","display: none");
                                    $("#laxdiv2").attr("style","display: none");
                                }
                                else
                                
                                {
                                    $("#calculate").attr("disabled", "disabled");
                                    
                                    $("#msgs").attr("style","display: block");
                                    $("#laxdiv1").attr("style","display: block");
                                    $("#laxdiv2").attr("style","display: none");
                                }
                                break;
                            
                            case 'Inverse':
                                if(mar==mac)
                                {
                                    $("#calculate").removeAttr("disabled");
                                    
                                    $("#msgs").attr("style","display: none");
                                    $("#laxdiv1").attr("style","display: none");
                                    $("#laxdiv2").attr("style","display: none");
                                }
                                else
                                
                                {
                                    $("#calculate").attr("disabled", "disabled");
                                    
                                    $("#msgs").attr("style","display: block");
                                    $("#laxdiv1").attr("style","display: block");
                                    $("#laxdiv2").attr("style","display: none");
                                }
                            
                        }
                    }
       
                    function checkOperation()
                    {
                        showSpecific();
                        if(selopt=="Addition" || selopt=="Subtraction" || selopt=="Multiplication")
                        {
                            $("#tabs1").attr("style","visibility : visible");
                            $("#tabs2").attr("style","visibility : visible");
                            $("#table11").attr("style", "visibility : visible");
                            $("#table22").attr("style", "visibility : visible");
                            $("#calculate").attr("style", "visibility : visible");
                        
                      
                        }
                        else if(selopt=="Transpose" || selopt=="Inverse")
                        {
                            $("#tabs1").attr("style","visibility : visible");
                            $("#tabs2").attr("style","visibility : hidden");
                            
                            $("#table11").attr("style", "visibility : visible");
                            $("#table22").attr("style", "visibility : hidden");
                            $("#calculate").attr("style", "visibility : visible");
                          
                        }
                    
                        else
                        {
                            $("#tabs1").attr("style","visibility : hidden");
                            $("#tabs2").attr("style","visibility : hidden");
                            $("#table11").attr("style", "visibility : hidden");
                            $("#table22").attr("style", "visibility : hidden");
                            $("#calculate").attr("style", "visibility : hidden");
                        }
                          
                          
                        switch(selopt){
                            case 'Addition':
                                $("#label1").text("+");
                                break;
                            case 'Subtraction':
                                $("#label1").text("-");
                                break;
                            case 'Multiplication':
                                $("#label1").text("X");
                                break;
                            case 'Inverse':
                                $("#label1").text("^");
                                break;
                            case 'Transpose':
                                $("#label1").text("T");
                                break;
                            case 'Matrix Input':
                                $("#label1").text("Populate");
                                break;
                            
                        }
           
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



    </body>
</html>
