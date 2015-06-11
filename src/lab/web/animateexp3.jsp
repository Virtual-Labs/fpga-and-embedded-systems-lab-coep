<%-- 
    Document   : animateexp3
    Created on : 28 Dec, 2011, 11:31:22 AM
    Author     : root
--%>

<%@page import="JavaFiles.GenerateVerilogCode"%>
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
            .mycol{
                width:15px;
                text-align: center;

            }
            .mydd{
                height: 0px;
            }

            .rnd {
                border: solid 1px black;
                height: 40px;
                width: 95%;
                border-radius: 10px;
                -moz-border-radius: 10px;
                -webkit-border-radius: 10px;
                background-color: #000;
                color: #00ff00;

                visibility: visible;
            }
            .tb7 {
                /* width: 140px;*/
                background: transparent url('images/bg.jpg') no-repeat;
                color : #747862;
                height:20px;
                border:0;
                padding:4px 8px;
                margin-bottom:0px;
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
            
                var laxk1=$("#selarch").val();
                var laxk2=$("#seloper").val();
                
//                $("#seloper").bind({
//                    change : function() {
//                        laxk2=$("#seloper").val();
//                        if(laxk2=="4")
//                        {
//                            $("#quadratic").attr("style","display : block");
//                            $("#matrixmul").attr("style","display : none");
//                        }
//                        if(laxk2=="5")
//                        {
//                            $("#quadratic").attr("style","display : none");
//                            $("#matrixmul").attr("style","display : block");
//                        }
//                    }
//                });

                $("#pos100").bind({
                    keypress:function(e){
                        var lax1=e.which>=58;
                        var lax2=e.which<=47;
                        if(lax1 || lax2 && e.which!=8 && e.which!=9 && e.which!=45 && e.which!=46)
                        {
                            e.preventDefault();
                        }
                    }
                });
                
                $("#pos10").bind({
                    keypress:function(e){
                        var lax1=e.which>=58;
                        var lax2=e.which<=47;
                        if(lax1 || lax2 && e.which!=8 && e.which!=9 && e.which!=45 && e.which!=46)
                        {
                            e.preventDefault();
                        }
                    }
                });
                
                $("#pos1").bind({
                    keypress:function(e){
                        var lax1=e.which>=58;
                        var lax2=e.which<=47;
                        if(lax1 || lax2 && e.which!=8 && e.which!=9 && e.which!=45 && e.which!=46)
                        {
                            e.preventDefault();
                        }
                    }
                });

                $("#submitquad").bind({
                    click:function(){
                        if($("#pos100").val()=="" || $("#pos100").val()==null)
                        {
                            $("#pos100").val("0");
                        }
                        if($("#pos10").val()=="" || $("#pos10").val()==null)
                        {
                            $("#pos10").val("0");
                        }
                        if($("#pos1").val()=="" || $("#pos1").val()==null)
                        {
                            $("#pos1").val("0");
                        }
                                
                    }
                });
                
                $("#resetquad").bind({
                    click:function(){
                        
                    }
                });
                
                
                var selopt;
                var mar=$("#matarow").val();
                var mbr=$("#matbrow").val();
                var mac=$("#matacol").val();
                var mbc=$("#matbcol").val();
                showSpecific();
                
                
                checkOperation();
                var i=0,j=0;
                
                
	
                for(i=0;i<6;i++){
                    for(j=0;j<6;j++){
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
        
                //                       $("#selarch").bind({
                //                    change : function() {
                //                        laxk2=$("#selarch").val();
                //                        alert("hi");
                //                        if(laxk2=="3")
                //                        {
                //                            $("#matacol").val("4");
                //                            $("#matbcol").val("4");
                //                            $("#matarow").val("4");
                //                            $("#matbrow").val("4");
                //                            
                //                            mac=$("#matacol").val();
                //                            mbc=$("#matbcol").val();
                //                            mar=$("#matarow").val();
                //                            mbr=$("#matbrow").val();
                //                            showSpecific();
                //                        }
                //                        else
                //                        {
                //                            $("#matacol").val("6");
                //                            $("#matbcol").val("6");
                //                            $("#matarow").val("6");
                //                            $("#matbrow").val("6");
                //                            
                //                            mac=$("#matacol").val();
                //                            mbc=$("#matbcol").val();
                //                            mar=$("#matarow").val();
                //                            mbr=$("#matbrow").val();
                //                            showSpecific();
                //                        }
                //                    }
                //                });
                               
                       
                
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
                
                       
                
                
                function showSpecific()
                {
                    var c,d;
                    hideaAll();
                    $("#laximpdiv").removeAttr("class");
                    for(c=0;c<mar;c++)
                    {
                        for(d=0;d<mac;d++)
                        {
                            $("#txta"+c+d).attr("style","visibility : visible");
                        }
                    }
                    for(c=0;c<mbr;c++)
                    {
                        for(d=0;d<mbc;d++)
                        {
                            $("#txtb"+c+d).attr("style","visibility : visible");
                        }
                    }
                                 
                            
                            
                
                            
                    checkMatrixValidation()
                }
                
                function hideaAll()
                {
                    var c,d;
                    $("#laximpdiv").attr("class","mydd");
                    $("#msgs").attr("style","display : none");
                    $("#lax125").attr("style","display : none");
                    for(c=0;c<mar;c++)
                    {
                        for(d=0;d<mbr;d++)
                        {
                            $("#txtb"+c+d).attr("style","visibility : hidden");
                            $("#txta"+c+d).attr("style","visibility : hidden");
                        }
                    }
           
                }
                
                function checkForBlankfields()
                {
                    var lax=true;
                    var cnlax=0;
                    for(c=0;c<mar;c++)
                    {
                        for(d=0;d<mac;d++)
                        {
                            
                            if( $("#txta"+c+d).val()=="")
                                $("#txta"+c+d).val(++cnlax);
                               
                        }
                    }
                    cnlax=0;
                    for(c=0;c<mbr;c++)
                    {
                        for(d=0;d<mbc;d++)
                        {
                            if( $("#txtb"+c+d).val()=="")
                                $("#txtb"+c+d).val(++cnlax);
                                
                        }
                    }    
                    return lax;
                }
                
                function checkMatrixValidation()
                {
                           
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
                                    
                            
                }
       
                function checkOperation()
                {
                    showSpecific();
                           
                    $("#tabs1").attr("style","visibility : visible");
                    $("#tabs2").attr("style","visibility : visible");
                    $("#table11").attr("style", "visibility : visible");
                    $("#table22").attr("style", "visibility : visible");
                    $("#calculate").attr("style", "visibility : visible");
                        
                      
                           
                    $("#label1").text("X");
                            
                            
           
                }
        
                
            
            
            } );
            
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

        <form id="exp3" name="exp3" action="GenerateVerilogCodeExp3.jsp" method="POST">

            <div>
                <table width="100%">
                    <tr>
                        <td width="40%">
                            Select Architecture
                        </td>
                        <td width="5%">
                            :
                        </td>
                        <td width="55%">
                            <select id="selarch" name="selarch">
                                <option value="1">Serial (Single PE) Architecture</option>
                                <option value="2">Parallel (N - PE) Architecture</option>
                                <option value="3">Iterative (4 - PE) Architecture</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td width="40%">
                            Select Operation
                        </td>
                        <td width="5%">
                            :
                        </td>
                        <td width="55%">
                            <select id="seloper" name="seloper">
<!--                                <option value="4">Roots of Quadratic Equations</option>-->
                                <option value="5">Matrix Multiplication</option>
                            </select>
                        </td>
                    </tr>


                </table>
                <hr>
<!--                <div id="quadratic" style="display: block">
                    <table>
                        <tr>

                            <td>
                                <input class="tb7" type="text" size="3" maxlength="3" name="pos100" id="pos100" value="" />
                            </td>

                            <td>
                                x<sup>2</sup>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>+</td>
                            <td>
                                <input class="tb7" type="text" size="3" maxlength="3" name="pos10" id="pos10" value="" />
                            </td>

                            <td>
                                x
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>+</td>
                            <td>
                                <input class="tb7" type="text" size="3" maxlength="3" name="pos1" id="pos1" value="" />
                            </td>

                            <td>

                            </td>
                            <td>
                                &nbsp;
                            </td>

                            <td>
                                = 0
                            </td>
                        </tr>
                    </table>
                    <br>
                    <input class="buttons" type="submit" name="submitquad" id="submitquad" value="Calculate" />
                    <input class="buttons" type="reset" name="resetquad" id="resetquad" value="Clear" />
                </div>-->



                <div id="matrixmul" style="display: block">

                    <div class="mydd" id="laximpdiv">
                        <table id="tabs1" style="visibility: visible">

                            <tr>
                                <td>
                                    Select columns for Matrix A :
                                </td>
                                <td>
                                    <select id="matacol" name="matacol" >
                                        <!--                                        <option id="mop1" >2</option>
                                                                                <option id="mop2" selected>3</option>-->
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
                                        <!--                                        <option id="mop4" >2</option>
                                                                                <option id="mop5" selected>3</option>-->
                                        <option id="mop6" >4</option>
                                    </select>
                                </td>
                            </tr>
                        </table>

                        <table id="tabs2" style="visibility: visible">
                            <tr>
                                <td>
                                    Select columns for Matrix B :
                                </td>
                                <td>
                                    <select id="matbcol" name="matbcol" >
                                        <!--                                        <option id="mop7" >2</option>
                                                                                <option id="mop8" selected>3</option>-->
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
                                        <!--                                        <option id="mop10" >2</option>
                                                                                <option id="mop11" selected>3</option>-->
                                        <option id="mop12" >4</option>
                                    </select>
                                </td>
                            </tr>
                            </span>
                        </table>


                        <table id="tabs3">
                            <tr>



                                <td>
                                    <div id="table11" style="visibility: visible">
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
                                                <!--                                                <td class="mycol">
                                                                                                    <input name="txta04" type="text" id="txta04" size="3"  />
                                                                                                </td>
                                                                                                <td class="mycol">
                                                                                                    <input name="txta05" type="text" id="txta05" size="3"  />
                                                                                                </td>-->

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
                                                <!--                                                <td class="mycol">
                                                                                                    <input name="txta14" type="text" id="txta14" size="3"  />
                                                                                                </td>
                                                                                                <td class="mycol">
                                                                                                    <input name="txta15" type="text" id="txta15" size="3"  />
                                                                                                </td>-->
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
                                                <!--                                                <td class="mycol">
                                                                                                    <input name="txta24" type="text" id="txta24" size="3"  />
                                                                                                </td>
                                                                                                <td class="mycol">
                                                                                                    <input name="txta25" type="text" id="txta25" size="3"  />
                                                                                                </td>-->


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
                                                <!--                                                <td class="mycol">
                                                                                                    <input name="txta34" type="text" id="txta34" size="3"  />
                                                                                                </td>
                                                                                                <td class="mycol">
                                                                                                    <input name="txta35" type="text" id="txta35" size="3"  />
                                                                                                </td>-->


                                            </tr>

                                            <!--                                            <tr>
                                            
                                                                                            <td class="mycol">
                                                                                                <input name="txta40" type="text" id="txta40" size="3"  />
                                                                                            </td>
                                                                                            <td class="mycol">
                                                                                                <input name="txta41" type="text" id="txta41" size="3" />
                                                                                            </td>
                                                                                            <td class="mycol">
                                                                                                <input name="txta42" type="text" id="txta42" size="3" />
                                                                                            </td>
                                                                                            <td class="mycol">
                                                                                                <input name="txta43" type="text" id="txta43" size="3"  />
                                                                                            </td>
                                                                                            <td class="mycol">
                                                                                                <input name="txta44" type="text" id="txta44" size="3"  />
                                                                                            </td>
                                                                                            <td class="mycol">
                                                                                                <input name="txta45" type="text" id="txta45" size="3"  />
                                                                                            </td>
                                            
                                            
                                                                                        </tr>-->

                                            <!--                                            <tr>
                                            
                                                                                            <td class="mycol">
                                                                                                <input name="txta50" type="text" id="txta50" size="3"  />
                                                                                            </td>
                                                                                            <td class="mycol">
                                                                                                <input name="txta51" type="text" id="txta51" size="3" />
                                                                                            </td>
                                                                                            <td class="mycol">
                                                                                                <input name="txta52" type="text" id="txta52" size="3" />
                                                                                            </td>
                                                                                            <td class="mycol">
                                                                                                <input name="txta53" type="text" id="txta53" size="3"  />
                                                                                            </td>
                                                                                            <td class="mycol">
                                                                                                <input name="txta54" type="text" id="txta54" size="3"  />
                                                                                            </td>
                                                                                            <td class="mycol">
                                                                                                <input name="txta55" type="text" id="txta55" size="3"  />
                                                                                            </td>
                                            
                                            
                                                                                        </tr>-->
                                        </table>
                                    </div>
                                </td>


                                <td>
                                    <div id="table22" style="visibility: visible">
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
                                                <!--                                                <td class="mycol">
                                                                                                    <input name="txtb04" type="text" id="txtb04" size="3"  />
                                                                                                </td>
                                                                                                <td class="mycol">
                                                                                                    <input name="txtb05" type="text" id="txtb05" size="3"  />
                                                                                                </td>-->

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
                                                <!--                                                <td class="mycol">
                                                                                                    <input name="txtb14" type="text" id="txtb14" size="3"  />
                                                                                                </td>
                                                                                                <td class="mycol">
                                                                                                    <input name="txtb15" type="text" id="txtb15" size="3"  />
                                                                                                </td>-->
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
                                                <!--                                                <td class="mycol">
                                                                                                    <input name="txtb24" type="text" id="txtb24" size="3"  />
                                                                                                </td>
                                                                                                <td class="mycol">
                                                                                                    <input name="txtb25" type="text" id="txtb25" size="3"  />
                                                                                                </td>-->

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
                                                <!--                                                <td class="mycol">
                                                                                                    <input name="txtb34" type="text" id="txtb34" size="3"  />
                                                                                                </td>
                                                                                                <td class="mycol">
                                                                                                    <input name="txtb35" type="text" id="txtb35" size="3"  />
                                                                                                </td>-->

                                            </tr>
                                            <!--                                            <tr>
                                            
                                                                                            <td class="mycol">
                                                                                                <input name="txtb40" type="text" id="txtb40" size="3"  />
                                                                                            </td>
                                                                                            <td class="mycol">
                                                                                                <input name="txtb41" type="text" id="txtb41" size="3" />
                                                                                            </td>
                                                                                            <td class="mycol">
                                                                                                <input name="txtb42" type="text" id="txtb42" size="3" />
                                                                                            </td>
                                                                                            <td class="mycol">
                                                                                                <input name="txtb43" type="text" id="txtb43" size="3"  />
                                                                                            </td>
                                                                                            <td class="mycol">
                                                                                                <input name="txtb44" type="text" id="txtb44" size="3"  />
                                                                                            </td>
                                                                                            <td class="mycol">
                                                                                                <input name="txtb45" type="text" id="txtb45" size="3"  />
                                                                                            </td>
                                            
                                            
                                                                                        </tr>
                                                                                        
                                                                                        <tr>
                                            
                                                                                            <td class="mycol">
                                                                                                <input name="txtb50" type="text" id="txtb50" size="3"  />
                                                                                            </td>
                                                                                            <td class="mycol">
                                                                                                <input name="txtb51" type="text" id="txtb51" size="3" />
                                                                                            </td>
                                                                                            <td class="mycol">
                                                                                                <input name="txtb52" type="text" id="txtb52" size="3" />
                                                                                            </td>
                                                                                            <td class="mycol">
                                                                                                <input name="txtb53" type="text" id="txtb53" size="3"  />
                                                                                            </td>
                                                                                            <td class="mycol">
                                                                                                <input name="txtb54" type="text" id="txtb54" size="3"  />
                                                                                            </td>
                                                                                            <td class="mycol">
                                                                                                <input name="txtb55" type="text" id="txtb55" size="3"  />
                                                                                            </td>
                                            
                                            
                                                                                        </tr>-->

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


            </div>

        </form>

        <%
            //   exp3laxvalue
            session = request.getSession();
            String lax = (String) session.getAttribute("exp3laxvalue");
            if (lax != null) {
                String operation = (String) session.getAttribute("operationsexp3");
                String architecture = (String) session.getAttribute("architectureexp3");

        %>


        <table width="100%">
            <tr>
                <td width="5%">
                    <div id="sigdiv" class="cirdiv" onclick="toggleDiv()" title="Collapse All">
                        -
                    </div>
                </td>
                <td width="75%">
                    <hr  onclick="toggleDiv()" style="cursor: pointer">
                </td>
            </tr>
        </table>

        <div id="presult" style="display: block;" >

            <h3>Previous Answer :</h3>
            <hr>
            <TABLE cellpadding="2" cellspacing="2">
                <tr>
                    <td>
                        Architecture
                    </td>
                    <td>
                        :
                    </td>
                    <td>
                        <%=architecture%>
                    </td>
                </tr>
                <tr>
                    <td>
                        Operation
                    </td>
                    <td>
                        :
                    </td>
                    <td>
                        <%=operation%>
                    </td>
                </tr>
            </table>
            <hr>

            <%
                System.out.println("\n\n\nexp\n\n\n" + operation);
                if (operation.equals("Matrix Multiplication")) {

                    int m, n, x, y;
                    int[][] mat1, mat2;
                    long[][] ans;
                    m = (Integer) session.getAttribute("laxm");
                    n = (Integer) session.getAttribute("laxn");
                    x = (Integer) session.getAttribute("laxx");
                    y = (Integer) session.getAttribute("laxy");
                    mat1 = (int[][]) session.getAttribute("laxmat1");
                    mat2 = (int[][]) session.getAttribute("laxmat2");
                    ans = (long[][]) session.getAttribute("answers");
                    new GenerateVerilogCode().displayOutput(out, m, n, x, y, mat1, mat2, ans, "X");

                }
                if (operation.equals("Roots of Quadratic Equations")) {


                    System.out.println("\n\n\nexp\n\n\n");
                    double roots[] = (double[]) session.getAttribute("rootsexp3");
                    int a = (Integer) session.getAttribute("aexp3");
                    int b = (Integer) session.getAttribute("bexp3");
                    int c = (Integer) session.getAttribute("cexp3");
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


            <%}
            %>


        </div>
        <%}%>
    </body>

</html>
