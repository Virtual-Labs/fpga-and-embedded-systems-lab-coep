<%-- 
    Document   : animateexp2
    Created on : 8 Dec, 2011, 2:20:14 PM
    Author     : root
--%>

<%@page import="java.io.PrintStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
            .cirdiv{
                height: 20px; width: 20px; background:#00ff00; vertical-align: top;
                text-align: center;
                border-radius: 20px;
                -moz-border-radius: 20px;
                -webkit-border-radius: 20px;


                cursor: pointer;
            }
        </style>

        <style>
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


        </style>

        <%


        %>
        <script type="text/javascript" src="scripts/jquery.js"></script>
        <script type="text/javascript" src="scripts/jquery-ui.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                $("#labelarith").text("");
                var lpk="";
                var operation=$("#selops").val();
                
                $("#logopsub").bind({
                    change:function()
                    {
                        var losb=$("#logopsub").val();
                        if(losb=="&&" || losb=="||")
                        {
                            $("#logdop2").attr("style","display:none");
                            $("#logdop4").attr("style","display:none");
                            $("#logdop3").attr("selected","true");
                            $("#logdop5").attr("selected","true");
                            $("#textlog").attr("maxlength","1");
                            $("#textlog2").attr("maxlength","1");
                        }
                        else{
                            $("#logdop2").attr("style","display:block");
                            $("#logdop4").attr("style","display:block");
                            $("#textlog").attr("maxlength","16");
                            $("#textlog2").attr("maxlength","16");
                        }
                    }
                });
                
                
                $("#textarith").bind({
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
                
                $("#textrel").bind({
                    keypress:function(e){
                        var relopt=$("#reldtype1").val();
                        if(relopt=="Decimal")
                        {
                            var lax1=e.which>=58;
                            var lax2=e.which<=47;
                            if(lax1 || lax2 && e.which!=8 && e.which!=9)
                            {
                                e.preventDefault();
                            }
                        }
                        if(relopt=="Binary")
                        {
                            if(e.which!=49 && e.which!=48 && e.which!=8 && e.which!=9)
                            {
                                e.preventDefault();
                            }
                        }
                        
                    }
                });
                
                $("#textlog").bind({
                    keypress:function(e){
                        var relopt=$("#logdtype1").val();
                        if(relopt=="Decimal")
                        {
                            var lax1=e.which>=58;
                            var lax2=e.which<=47;
                            if(lax1 || lax2 && e.which!=8 && e.which!=9)
                            {
                                e.preventDefault();
                            }
                        }
                        if(relopt=="Binary")
                        {
                            if(e.which!=49 && e.which!=48 && e.which!=8 && e.which!=9)
                            {
                                e.preventDefault();
                            }
                        }
                        
                    }
                });
                
                
                
                $("#textrel2").bind({
                    keypress:function(e){
                        var relopt=$("#reldtype2").val();
                        if(relopt=="Decimal")
                        {
                            var lax1=e.which>=58;
                            var lax2=e.which<=47;
                            if(lax1 || lax2 && e.which!=8 && e.which!=9)
                            {
                                e.preventDefault();
                            }
                        }
                        if(relopt=="Binary")
                        {
                            if(e.which!=49 && e.which!=48 && e.which!=8 && e.which!=9)
                            {
                                e.preventDefault();
                            }
                        }
                        
                    }
                });
                
                $("#textlog2").bind({
                    keypress:function(e){
                        var relopt=$("#logdtype2").val();
                        if(relopt=="Decimal")
                        {
                            var lax1=e.which>=58;
                            var lax2=e.which<=47;
                            if(lax1 || lax2 && e.which!=8 && e.which!=9)
                            {
                                e.preventDefault();
                            }
                        }
                        if(relopt=="Binary")
                        {
                            if(e.which!=49 && e.which!=48 && e.which!=8 && e.which!=9)
                            {
                                e.preventDefault();
                            }
                        }
                        
                    }
                });
                
                $("#textred").bind({
                    keypress:function(e){
                        if(e.which!=49 && e.which!=48 && e.which!=8 && e.which!=9)
                        {
                            e.preventDefault();
                        }
                    }
                });
                $("#sdtype").bind({
                    change:function(){
                        $("#soptxt").val("");
                    }
                });
                $("#reldtype1").bind({
                    change:function(){
                        $("#textrel").val("");
                    }
                });
                $("#logdtype1").bind({
                    change:function(){
                        $("#textlog").val("");
                    }
                });
                $("#reldtype2").bind({
                    change:function(){
                        $("#textrel2").val("");
                    }
                });
                
                $("#logdtype2").bind({
                    change:function(){
                        $("#textlog2").val("");
                    }
                });
                
                $("#soptxt").bind({
                    keypress: function(e){
                        var relopt=$("#sdtype").val();
                        if(relopt=="Decimal")
                        {
                            var lax1=e.which>=58;
                            var lax2=e.which<=47;
                            if(lax1 || lax2 && e.which!=8 && e.which!=9)
                            {
                                e.preventDefault();
                            }
                        }
                        if(relopt=="Binary")
                        {
                            if(e.which!=49 && e.which!=48 && e.which!=8 && e.which!=9)
                            {
                                e.preventDefault();
                            }
                        }
                        
                    }
                    
                });
                
                $("#nshifts").bind({
                    keypress: function(e){
                        var lax1=e.which>=58;
                        var lax2=e.which<=47;
                        if(lax1 || lax2 && e.which!=8 && e.which!=9)
                        {
                            e.preventDefault();
                        }
                    }
                });
                
                
                $("#textbit").bind({
                    keypress: function(e){
                        if(e.which!=49 && e.which!=48 && e.which!=8 && e.which!=9)
                        {
                            e.preventDefault();
                        }
                    }
                });
                $("#textbit2").bind({
                    keypress: function(e){
                        if(e.which!=49 && e.which!=48 && e.which!=8 && e.which!=9)
                        {
                            e.preventDefault();
                        }
                        if($("#bitopsub").val()=="NEGATION")
                        {
                            $("#textbit2").attr("style","display : none");
                        }
                    }
                });
                
                
                $("#selops").bind({
                    change:function(){
                        operation=$("#selops").val();
                        
                        showSpecific(operation);
                        
                        
                    }
                });
                
                $("#submitrel").bind({
                    click:function(){
                        valid=true;
                        if($("#textrel").val()==null || $("#textrel").val()==""){
                            valid=false;
                            alert("Data is blank");
                        }
                        if(($("#textrel2").val()==null || $("#textrel2").val()=="") ){
                            valid=false;
                            alert("Data is blank");
                        }
                        return valid;
                    }
                });
                
                $("#submitlog").bind({
                    click:function(){
                        valid=true;
                        if($("#textlog").val()==null || $("#textlog").val()==""){
                            valid=false;
                            alert("Data is blank");
                        }
                        if(($("#textlog2").val()==null || $("#textlog2").val()=="") ){
                            valid=false;
                            alert("Data is blank");
                        }
                        return valid;
                    }
                });
                
                $("#submitarith").bind({
                
                    click: function(){
                        valid=true;
                        var laxpk=$("#labelarith").text();
                        if(laxpk=="")
                        {
                            alert("No expressions to calculate!");
                            valid= false;
                            
                        }
                        else{
                            if($("#textarith").attr("readonly")=="readonly")
                                valid=true;
                            else
                            {
                                alert("Expression is invalid!");
                                valid=false;
                            }
                        }
                        $("#textarith").focus();
                        return valid;
                        
                    
                    }
                    
                });
                
                $("#submitbit").bind({
                    click:function(){
                        valid=true;
                        if($("#textbit").val()==null || $("#textbit").val()==""){
                            valid=false;
                            alert("Data is blank");
                        }
                        if(($("#textbit2").val()==null || $("#textbit2").val()=="") && $("#bitopsub").val()!="NEGATION"){
                            valid=false;
                            alert("Data is blank");
                        }
                        return valid;
                    }
                });
                
                $("#submitred").bind({
                    click:function(){
                        valid=true;
                        if($("#textred").val()==null || $("#textred").val()==""){
                            valid=false;
                            alert("Data is blank");
                        }
                        
                        return valid;
                    }
                });
                
                $("#submitshift").bind({
                    click:function(){
                        valid=true;
                        if($("#soptxt").val()==null || $("#soptxt").val()==""){
                            valid=false;
                            alert("Data is blank");
                        }
                        if($("#nshifts").val()==null || $("#nshifts").val()==""){
                            valid=false;
                            alert("Number of shifts is blank");
                        }
                        if($("#sop1").attr("selected")=="selected")
                        {
                            valid=false;
                            alert("Shift type is not selected");
                        }
                        if($("#sdop1").attr("selected")=="selected"){
                            valid=false;
                            alert("Data type is not selected");
                        }
                        
                        //alert(valid);
                        return valid;
                    
                    }
                    
                });
                
                $("#clearshift").bind({
                    click:function(){
                        $("#soptxt").val("");
                        $("#sop1").attr("selected","true");
                        $("#sdop1").attr("selected","true");
                        $("#nshifts").val("");
                    }
                });
                
                $("#arithopsub").bind({
                    change:function(){
                        appendToExpression();
                    }
                });
                
                
                $("#bitopsub").bind({
                    change:function(){
                        if($("#bitopsub").val()=="NEGATION")
                        {
                            $("#laxp1").attr("style","display : none");
                            $("#laxp2").attr("style","display : none");
                        }
                        else
                        {
                            $("#laxp1").attr("style","display : block");
                            $("#laxp2").attr("style","display : block");
                        }
                    }
                });
                
                $("#cleararith").bind({
                    click:function(){
                        $("#textarith").val("");
                        $("#textarith").removeAttr("readonly");
                        $("#ar8").attr("selected","true");
                        $("#labelarith").text("");
                        $("#textarith").focus();
                        
                    }
                });
              
                
                $("#butarith").bind({
                    click:function(){
                        var txtval=$("#textarith").val();
                        var txtop=$("#arithopsub").val();
                        if(txtval=="")
                        {
                            alert("Textfield value is blank");
                        }
                        else{
                            if(txtop=="Blank")
                                txtop="";
                            if(txtop=="Next Expression")
                                txtop="<br/>"
                            $("#labelarith").html($("#labelarith").html()+txtval+" "+txtop+" ");
                        }
                    }
                });
                
                
                
                //  alert(operation);
            });
            
            function appendToExpression()
            {
                // alert("hi");
                var txtval=$("#textarith").val();
                var txtop=$("#arithopsub").val();
                
                if(txtval=="")
                {
                    $("#textarith").focus();
                    alert("Textfield value is blank");
                    
                    $("#ar8").attr("selected","true");
                }
                else{
                    if(txtop=="Blank")
                    {
                            
                        //laxpk="Blank";
                        $("#textarith").attr("readonly","true");
                        txtop="";
                    }
                    if(txtop=="Next Expression")
                    {
                        txtop="\n\b"
                        $("#labelarith").text($("#labelarith").text()+txtop+txtval+" ");
                    }
                    else{
                        $("#labelarith").text($("#labelarith").text()+txtval+" "+txtop+" ");}
                    $("#textarith").val("");
                    $("#ar8").attr("selected","true");
                    $("#textarith").focus();
                }
            }
            
            
            function showSpecific(dispdiv)
            {
                hideAll();
                switch(dispdiv)
                {
                    case 'Arithmetical Operation':
                        $("#textarith").focus();
                        $("#arithop").attr("style","display :block");
                        break;
                    case 'Relational Operation':
                        $("#relop").attr("style","display :block");
                        break;
                    case 'Logical Operation':
                        $("#logop").attr("style","display :block");
                        break;
                    case 'Bitwise Operation':
                        $("#bitop").attr("style","display :block");
                        break;    
                    case 'Reduction Operation':
                        $("#redop").attr("style","display :block");
                        break;    
                    case 'Shift Operation':
                        $("#shiftop").attr("style","display :block");
                        break;    
                }
                
                
            }
            
            function hideAll()
            {
                $("#arithop").attr("style","display :none");
                $("#relop").attr("style","display :none");
                $("#logop").attr("style","display :none");
                $("#bitop").attr("style","display :none");
                $("#redop").attr("style","display :none");
                $("#shiftop").attr("style","display :none");
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
        <form name="arithcalc" action="GenerateArithCode.jsp" method="POST">
            <div id="ani1">
                <div id="opdisp">
                    <table>
                        <tr>

                            <td class="col">
                                Select Operation : 
                            </td>


                            <td class="col">
                                <select id="selops" name="selops">
                                    <option>None</option>
                                    <option>Arithmetical Operation</option>
                                    <option>Relational Operation</option>
                                    <option>Logical Operation</option>
                                    <option>Bitwise Operation</option>
                                    <option>Reduction Operation</option>
                                    <option>Shift Operation</option>

                                </select>

                            </td>

                        </tr>

                    </table>
                </div>
                <HR>
                <div id="arithop" style="display: none">
                    <table>
                        <tr>
                            <td colspan="3"  class="col">
                                Arithmetical Operations:
                                <hr>
                            </td>
                        </tr>
                        <tr>
                            <td  class="col">
                                Data
                            </td>
                            <td>
                                
                            </td>
                            <td class="col">
                                Expression


                            </td>
                            <td class="col">

                            </td>
                        </tr>
                        <tr>
                            <td class="col">
                                <input type="text" size="3" name="textarith" id="textarith"/>
                            </td>
                            <td>
                               (decimal) 
                            </td>

                            <td class="col">
                                <select id="arithopsub" name="arithopsub">
                                    <option id="ar1">Blank</option>
                                    <!--option id="ar2">=</option-->
                                    <option id="ar3">+</option>
                                    <option id="ar4">-</option>
                                    <option id="ar5" >*</option>
<!--                                    <option id="ar6">/</option>
                                    <option id="ar7">%</option>-->
                                    <option id="ar8" style="display : none" selected></option>

                                </select>

                            </td>
                            <td class="col">
                                <!--input  type="button" value="SET" name="butarith" id="butarith"/-->
                            </td>
                        </tr>
                        <tr>
                            <td class="col" colspan="3">
                                <textarea name="labelarith" id="labelarith" readonly></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td class="col" colspan="3">
                                <input class="buttons" type="submit" name="submitarith" id="submitarith" value="Calculate" />
                                <input class="buttons" type="reset" name="cleararith" id="cleararith" value="clear Data" />
                            </td>
                        </tr>
                    </table>




                </div>
                <div id="relop" style="display: none">

                    <table>
                        <tr>
                            <td class="col" colspan="5">
                                Relational Operations:
                                <br><i class="fontss"><u>(first select data types)</u></i>
                                <hr>
                            </td>
                        </tr>
                        <tr>
                            <td class="col">
                                Data1
                            </td>
                            <td class="col">
                                Type
                            </td>


                            <td class="col">
                                Operator


                            </td>
                            <td class="col" id="laxp1rel">
                                Data2
                            </td>
                            <td class="col">
                                Type
                            </td>
                        </tr>
                        <tr>
                            <td class="col">
                                <input type="text" size="3" name="textrel" id="textrel"/>
                            </td>
                            <td class="col">
                                <select id="reldtype1" name="reldtype1">

                                    <option id="reldop2" value="Decimal" selected>Decimal</option>
                                    <option id="reldop3" value="Binary">Binary</option>
                                </select>
                            </td>

                            <td class="col">
                                <select id="relopsub" name="relopsub">

                                    <option id="rear3"><=</option>
                                    <option id="rear4" selected>>=</option>

                                </select>

                            </td>

                            <td class="col" id="laxp2rel">
                                <input type="text" size="3" name="textrel2" id="textrel2"/>
                            </td>
                            <td class="col">
                                <select id="reldtype2" name="reldtype2">

                                    <option id="reldop4" value="Decimal" selected>Decimal</option>
                                    <option id="reldop5" value="Binary">Binary</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="col" colspan="5">

                            </td>
                        </tr>
                        <tr>
                            <td class="col" colspan="5">
                                <input class="buttons" type="submit" name="submitrel" id="submitrel" value="Calculate" />
                                <input class="buttons" type="reset" name="clearrel" id="clearrel" value="clear Data" />
                            </td>
                        </tr>
                    </table>
                </div>


                <div id="logop" style="display: none">
                    <table>
                        <tr>
                            <td class="col" colspan="5">
                                Logical Operations:
                                <br><i class="fontss"><u>(first select data types)</u></i>
                                <hr>
                            </td>
                        </tr>
                        <tr>
                            <td class="col">
                                Data1
                            </td>
                            <td class="col">
                                Type
                            </td>


                            <td class="col">
                                Operator


                            </td>
                            <td class="col" id="laxp1log">
                                Data2
                            </td>
                            <td class="col">
                                Type
                            </td>
                        </tr>
                        <tr>
                            <td class="col">
                                <input type="text" size="3" name="textlog" id="textlog"/>
                            </td>
                            <td class="col">
                                <select id="logdtype1" name="logdtype1">

                                    <option id="logdop2" value="Decimal" selected>Decimal</option>
                                    <option id="logdop3" value="Binary">Binary</option>
                                </select>
                            </td>

                            <td class="col">
                                <select id="logopsub" name="logopsub">

                                    <option id="lar3" title="Case equlity">===</option>
                                    <option id="lar4" title="Case inequlity" selected>!==</option>
                                    <option id="lar5" title="Logical equlity">==</option>
                                    <option id="lar6" title="Logical inequlity">!=</option>
                                    <option id="lar7" title="Logical AND">&&</option>
                                    <option id="lar8" title="Logical OR">||</option>

                                </select>

                            </td>

                            <td class="col" id="laxp2log">
                                <input type="text" size="3" name="textlog2" id="textlog2"/>
                            </td>
                            <td class="col">
                                <select id="logdtype2" name="logdtype2">

                                    <option id="logdop4" value="Decimal" selected>Decimal</option>
                                    <option id="logdop5" value="Binary">Binary</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="col" colspan="5">

                            </td>
                        </tr>
                        <tr>
                            <td class="col" colspan="5">
                                <input class="buttons" type="submit" name="submitrel" id="submitlog" value="Calculate" />
                                <input class="buttons" type="reset" name="clearrel" id="clearlog" value="clear Data" />
                            </td>
                        </tr>
                    </table>
                </div>


                <div id="bitop" style="display: none">


                    <table>
                        <tr>
                            <td class="col" colspan="3">
                                Bit Wise Operations:
                                <hr>
                            </td>
                        </tr>
                        <tr>
                            <td class="col">
                                Data
                            </td>

                            <td class="col">
                                Operator


                            </td>
                            <td class="col" id="laxp1">
                                Data
                            </td>
                        </tr>
                        <tr>
                            <td class="col">
                                <input type="text" size="3" name="textbit" id="textbit"/>
                            </td>

                            <td class="col">
                                <select id="bitopsub" name="bitopsub">

                                    <option id="bar3">NEGATION</option>
                                    <option id="bar4" selected>AND</option>
                                    <option id="bar5" >OR</option>
                                    <option id="bar6">XOR</option>
                                    <option id="bar7">XNOR</option>


                                </select>

                            </td>
                            <td class="col" id="laxp2">
                                <input type="text" size="3" name="textbit2" id="textbit2"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="col" colspan="3">

                            </td>
                        </tr>
                        <tr>
                            <td class="col" colspan="3">
                                <input class="buttons" type="submit" name="submitbit" id="submitbit" value="Calculate" />
                                <input class="buttons" type="reset" name="clearbit" id="clearbit" value="clear Data" />
                            </td>
                        </tr>
                    </table>


                </div>

                <div id="redop" style="display: none">
                    <table>
                        <tr>
                            <td class="col" colspan="3">
                                Reduction Operations:
                                <hr>
                            </td>
                        </tr>
                        <tr>
                            <td class="col">
                                Operator
                            </td>

                            <td class="col">
                                &nbsp;
                            </td>
                            <td class="col">
                                Data
                            </td>
                        </tr>
                        <tr>
                            <td class="col">
                                <select id="redopsub" name="redopsub">

                                    <option id="rar3" value="&">AND</option>
                                    <option id="rar4" value="~&" selected>NAND</option>
                                    <option id="rar5" value="|">OR</option>
                                    <option id="rar6" value="~|">NOR</option>
                                    <option id="rar7" value="^">XOR</option>
                                    <option id="rar8" value="~^" >XNOR</option>


                                </select>
                            </td>
                            <td class="col">
                                &nbsp;
                            </td>
                            <td class="col">
                                <input type="text" size="3" name="textred" id="textred"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="col" colspan="3">

                            </td>
                        </tr>
                        <tr>
                            <td class="col" colspan="3">
                                <input class="buttons" type="submit" name="submitred" id="submitred" value="Calculate" />
                                <input class="buttons" type="reset" name="clearred" id="clearred" value="clear Data" />
                            </td>
                        </tr>

                    </table>


                </div>

                <div id="shiftop" style="display: none">
                    <table>

                        <tr>
                            <td class="col" colspan="4">
                                Shift Operations
                                <hr>
                            </td>
                        </tr>

                        <tr>
                            <td class="col">
                                Data
                            </td>
                            <td class="col">
                                Type
                            </td>
                            <td class="col">
                                Select Shift
                            </td>
                            <td class="col">
                                Number of Shifts
                            </td>
                        </tr>
                        <tr>
                            <td class="col">
                                <input type="text" size="3" id="soptxt" name="soptxt"/>
                            </td>
                            <td class="col">
                                <select id="sdtype" name="sdtype">
                                    <option  id="sdop1" style="display: none" value="Laxk"></option>
                                    <option selected id="sdop2" value="Decimal">Decimal</option>
                                    <option id="sdop3" value="Binary">Binary</option>
                                </select>
                            </td>
                            <td class="col">
                                <select id="shift" name="shift">
                                    <option id="sop1" style="display: none" value="Lax"></option>
                                    <option selected id="sop2" value="Left">Left Shift</option>
                                    <option id="sop3" value="Right">Right Shift</option>
                                </select>
                            </td>
                            <td class="col">
                                <input type="text" name="nshifts" id="nshifts" size="3"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="col" colspan="4">
                                <input class="buttons" type="submit" name="submitshift" id="submitshift" value="Calculate" />
                                <input class="buttons" type="button" name="clearshift" id="clearshift" value="clear Data" />
                            </td>
                        </tr>





                    </table>
                </div>

            </div>

        </form>


        <%
            String lax = (String) session.getAttribute("arithvalue");
            if (lax != null) {
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
                String optype = (String) session.getAttribute("arithtype");

                if (optype.equals("Arithmetical Operation")) {
                    String[] allexprs = (String[]) session.getAttribute("arithansar");
                    String result = String.valueOf(session.getAttribute("arithres"));
                    int num = 0;
            %>
            <div>

                <h3>Previous Result : </h3>

                <table>
                    <tr>
                        <td class="col">Your Expression  </td>
                        <td class="col">:</td>
                        <td class="col"><%=allexprs[0]%></td>
                    </tr>

                    <%
                        for (int i = 1; i < allexprs.length; i++) {
                            if (allexprs[i] == null) {
                                break;
                            }

                    %>
                    <tr>
                        <td class="col">Priority <%=i%>

                        </td>
                        <td class="col">:</td>
                        <td class="col"><%=allexprs[i]%></td>

                    </tr>

                    <%
                            num = i;//last
                        }
                    %>
                    <tr>
                        <td class="col">Answer

                        </td>
                        <td class="col">:</td>
                        <td class="col"><%=allexprs[num].split("=")[0].charAt(0)%>&nbsp;=&nbsp;<%=String.valueOf(result)%></td>

                    </tr>

                </table>
            </div>
            <%
                }//for Arithmetical
                if (optype.equals("Shift Operation")) {

                    String expr = (String) session.getAttribute("exprs");
                    String result = String.valueOf(session.getAttribute("shiftanswer"));
            %>
            <div>

                <h3>Previous Result : </h3>

                <table>
                    <tr>
                        <td class="col">Your Expression  </td>
                        <td class="col">:</td>
                        <td class="col">a=<%=" " + expr%>
                    </tr>

                    <tr>
                        <td class="col">Answer

                        </td>
                        <td class="col">:</td>
                        <td class="col">a=<%=" " + String.valueOf(result)%></td>

                    </tr>

                </table>
            </div>
            <%            }//for shift


                if (optype.equals("Bitwise Operation")) {
                    String data2 = "";
                    String data1 = (String) session.getAttribute("bitdata1");
                    String operator = (String) session.getAttribute("bitop");
                    if (!operator.equals("NEGATION")) {
                        data2 = (String) session.getAttribute("bitdata2");
                    }

                    Object answer = (String) session.getAttribute("bitans");
            %>
            <div>

                <h3>Previous Result : </h3>

                <table>
                    <tr>
                        <td class="col">Data1  </td>
                        <td class="col">:</td>
                        <td class="col"><%=" " + data1%></td>
                    </tr>

                    <tr>
                        <td class="col">Operator  </td>
                        <td class="col">:</td>
                        <td class="col"><%=" " + operator%>
                    </tr>
                    <%if (!operator.equals("NEGATION")) {%>
                    <tr>
                        <td class="col">Data2  </td>
                        <td class="col">:</td>
                        <td class="col"><%=" " + data2%></td>
                    </tr>
                    <%}%>
                    <tr>
                        <td class="col">Answer

                        </td>
                        <td class="col">:</td>
                        <td class="col"><%=" " + String.valueOf(answer)%></td>

                    </tr>

                </table>
            </div>

            <%}
                if (optype.equals("Relational Operation")) {
                    String data2 = (String) session.getAttribute("reldata2");
                    String data1 = (String) session.getAttribute("reldata1");
                    String reldtype1 = (String) session.getAttribute("reldtype1");
                    String reldtype2 = (String) session.getAttribute("reldtype2");
                    String relop = (String) session.getAttribute("relop");
                    String answer = String.valueOf(session.getAttribute("answerrel"));
            %>
            <div>

                <h3>Previous Result : </h3>

                <table>
                    <tr>
                        <td class="col">
                            data1
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td class="col">
                            <%=data1 + " (" + reldtype1 + ")"%>
                        </td>

                    </tr>

                    <tr>
                        <td class="col">
                            Operator
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td class="col">
                            <%=relop%>
                        </td>

                    </tr>

                    <tr>
                        <td class="col">
                            data2
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td class="col">
                            <%=data2 + " (" + reldtype2 + ")"%>
                        </td>

                    </tr>
                    <tr>
                        <td class="col">
                            &nbsp;
                        </td>
                        <td class="col">
                            &nbsp;
                        </td>
                        <td class="col">
                            &nbsp;
                        </td>

                    </tr>
                    <tr>
                        <td class="col">
                            Answer
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td class="col">
                            <%=data1 + " " + relop + " " + data2 + " = " + answer%>

                        </td>

                    </tr>
                </table>

            </div>
            <%      }
                if (optype.equals("Logical Operation")) {
                    String data2 = (String) session.getAttribute("logdata2");
                    String data1 = (String) session.getAttribute("logdata1");
                    String reldtype1 = (String) session.getAttribute("logdtype1");
                    String reldtype2 = (String) session.getAttribute("logdtype2");
                    String relop = (String) session.getAttribute("logop");
                    String answer = String.valueOf(session.getAttribute("answerlog"));
            %>

            <div>

                <h3>Previous Result : </h3>

                <table>
                    <tr>
                        <td class="col">
                            data1
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td class="col">
                            <%=data1 + " (" + reldtype1 + ")"%>
                        </td>

                    </tr>

                    <tr>
                        <td class="col">
                            Operator
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td class="col">
                            <%=relop%>
                        </td>

                    </tr>

                    <tr>
                        <td class="col">
                            data2
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td class="col">
                            <%=data2 + " (" + reldtype2 + ")"%>
                        </td>

                    </tr>
                    <tr>
                        <td class="col">
                            &nbsp;
                        </td>
                        <td class="col">
                            &nbsp;
                        </td>
                        <td class="col">
                            &nbsp;
                        </td>

                    </tr>
                    <tr>
                        <td class="col">
                            Answer
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td class="col">
                            <%=data1 + " " + relop + " " + data2 + " = " + answer%>

                        </td>

                    </tr>
                </table>

            </div>
            <%      }

                if (optype.equals("Reduction Operation")) {
                    String data1 = (String) session.getAttribute("reddata");
                    String operator = (String) session.getAttribute("redoperator");
                    String answer = String.valueOf(session.getAttribute("redanswer"));
            %>
            <div>
                <h3>Previous Result : </h3>
                <table>
                    <tr>
                        <td>
                            Operator
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td>
                            <%=operator%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Data
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td>
                            <%=data1%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Answer
                        </td>
                        <td class="col">
                            :
                        </td>
                        <td>
                            <%=operator + " " + data1.length() + "'b" + data1 + " = " + answer%>
                        </td>
                    </tr>
                </table>
            </div>

            <%}
            %>
        </div>
        <%
            }%>


    </body>





</html>
