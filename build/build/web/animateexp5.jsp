<%-- 
    Document   : animateexp5
    Created on : 19 Dec, 2011, 1:06:47 PM
    Author     : root
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
               
                var lax1=$("#ranks").val();
                var seltype=$("#dtype").val();
                generateTextBoxes(lax1,seltype);
                $("#dtype").bind({
                    change : function(){
                        seltype=$("#dtype").val();
                        lax1=$("#ranks").val();
                        switch(seltype){
                            case 'Fix Point':
                                hideAll();
                                $("#fixpoint").attr("style","display: block");
                                generateTextBoxes(lax1,seltype);
                                break;
                            case 'Floating Point':
                                hideAll();
                                $("#subdtype").attr("style","display : block");
                                $("#floatingpoint").attr("style","display: block");
                                generateTextBoxes(lax1,seltype);
                                break;
                        }
                    }
                });
                
                $("#ranks").bind({
                    
                    change : function(){
                        // alert($("#ranks").val());
                        lax1=$("#ranks").val();
                        generateTextBoxes($("#ranks").val(),seltype);
                    }
                });
                $("#exp5").bind({
                    reset: function(){
                        //alert("hi"+$("#ranks").val());
                        // $("#exp5").reset();
                        generateTextBoxes(2, $("#dtype").val())
                    }
                });
                
                $("#submitlin").bind({
                    
                    click : function(){
                        //alert(lax1);
                        valid=true;
                        for(i=0;i<lax1;i++)
                        {
                            for(j=0;j<lax1;j++)
                            {
                                if($("#txt"+i+j).val()=="" || $("#txt"+i+j).val()==null ){
                                    $("#txt"+i+j).val("0");
                                }
                                var pk=$("#txt"+i+j).val();
                                //alert(pk.split('-').length-1);
                                if(pk.split('-').length-1>0)
                                {
                                    if(pk.charAt(0)!='-')
                                    {
                                        valid=false;
                                    }
                                    if(pk.split('-').length-1>1)
                                    {
                                        valid=false;
                                    }
                                }
                            }
                            if($("#answers0"+i).val()=="" || $("#answers0"+i).val()==null)
                            {
                                $("#answers0"+i).val("0");
                                
                            }
                            var pk=$("#answers0"+i).val();
                            //alert(pk.split('-').length-1);
                            if(pk.split('-').length-1>0)
                            {
                                if(pk.charAt(0)!='-')
                                {
                                    valid=false;
                                }
                                if(pk.split('-').length-1>1)
                                {
                                    valid=false;
                                }
                            }
                   
                        }
                        if(!valid)
                        {
                            alert("You have entered wrong number");
                        }
                        return valid;
                        
                    }
                });
            });
            
            function hideAll()
            {
                $("#subdtype").attr("style","display : none");
                $("#fixpoint").attr("style","display : none");
                $("#floatingpoint").attr("style","display : none");
                document.getElementById("fixpoint").innerHTML="";
                document.getElementById("floatingpoint").innerHTML="";
                
            }
            
            function generateTextBoxes(lax,lk)
            {
                
                if(lk=="Fix Point")
                    lk="fixpoint";
                if(lk=="Floating Point")
                    lk="floatingpoint";
                
                
                var laxm=document.getElementById(lk);
                laxm.innerHTML="<hr> <font color=\"#1CA9C9\"> Enter your equations : </font><br>";
                // alert("coming"+lax);
                var k=parseInt(lax);
                var i=0;
                var j=0;
                for(i=0;i<k;i++)
                {
                    for(j=0;j<k;j++){
                        // alert(i);
                        //document.write("<input name='txt"+i+"' id='txt"+i+"' type='text' size='3' maxlength='3' value='0' />");
                        var element=document.createElement("input");
                        element.setAttribute("name", "txt"+i+j);
                        element.setAttribute("type", "text");
                        element.setAttribute("id", "txt"+i+j);
                        element.setAttribute("maxlength", "4");
                        element.setAttribute("size", 3);
                        laxm.innerHTML=laxm.innerHTML+" ";
                        laxm.appendChild(element);
                        laxm.innerHTML=laxm.innerHTML+" ";
                        laxm.innerHTML=laxm.innerHTML+"x<sub>"+j+"</sub>";
                        laxm.innerHTML=laxm.innerHTML+" ";
                        if(j<k-1)
                        {
                            var lpk="<select id=\"selects\""+i+" name=\"selects\""+i+">"+
                                "<option>+</option>"+
                                "<option>-</option>:"+
                                " </select>";
                        
                        
                        
                            //laxm.innerHTML=laxm.innerHTML+lpk;
                            laxm.innerHTML=laxm.innerHTML+"+";
                            laxm.innerHTML=laxm.innerHTML+" ";
                        
                        }
                        if(j==k-1)
                        {
                            
                            
                            laxm.innerHTML=laxm.innerHTML+" = <input name=\"answers0"+i+"\" id=\"answers0"+i+"\" type=\"text\" maxlength=\"3\" size=\"3\"/> ";
                            
                        }
                
                    }
                    laxm.innerHTML=laxm.innerHTML+"<br>";
                        
                }
            
                //apply this lock for text boxes later
                for(i=0;i<lax;i++)
                {
                    for(j=0;j<lax;j++)
                    {
                    
                        $("#txt"+i+j).bind({
                            keypress: function(e){
                                var lax1=e.which>=58;
                                var lax2=e.which<=47;
                                if(lax1 || lax2 && e.which!=8 && e.which!=9 && e.which!=45)
                                {
                                    e.preventDefault();
                                }
                            
                            }//keypress
                        });
                    }
                    $("#answers0"+i).bind({
                        keypress: function(e){
                            var lax1=e.which>=58;
                            var lax2=e.which<=47;
                            if(lax1 || lax2 && e.which!=8 && e.which!=9 && e.which!=45)
                            {
                                e.preventDefault();
                            }
                        
                        }
                    });
                }
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
        <form name="exp5" id="exp5" action="GenerateVerilogCodeExp5.jsp" method="POST">
            <div id="animat5">
                <div>

                    <table width="150%">
                        <tr>
                            <td width="50%">
                                Select Data Type 
                            </td>
                            <td width="10%">:</td>
                            <td width="40%">
                                <select id="dtype" name="dtype">
                                    <option id="dop0" selected="" >Fix Point</option>
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
                                Select Rank 
                            </td>
                            <td width="10%">:</td>
                            <td width="40%">
                                <select name="ranks" id="ranks">
                                    <option selected value="2">2</option>
                                    <option value="3">3</option>
                                    <option  value="4">4</option>
                                </select>
                            </td>
                            <td width="50%"></td>

                        </tr>
                        <tr>
                            <td width="50%">
                                Select Method 
                            </td>
                            <td width="10%">:</td>

                            <td width="40%" id="lax125">
                                <select id="invmet" name="solvemethod" >
                                    <option id="inv0" >LU Factorization</option>
                                    <option  id="inv1" selected >Gauss-Jordan Elimination</option>
                                </select>
                            </td>
                            <td width="50%"></td>
                        </tr>
                    </table>
                </div>
                <div id="fixpoint" style="display: block">
                    <hr>

                </div>



                <div id="floatingpoint" style="display: none">
                    <hr>
                </div>

                <div>
                    <br>
                    <input class="buttons" type="submit" id="submitlin" value="Calculate" />
                    <input class="buttons" type="reset" id="resetlin" value="Clear" />
                </div>

            </div>
        </form>


        <br>

        <%
            String lax = (String) session.getAttribute("setvalexp5");
            if (lax != null) {
                double equ2[][] = (double[][]) session.getAttribute("equ2exp5");
                double answer2[] = (double[]) session.getAttribute("answerexp5");
                double ans[] = (double[]) session.getAttribute("ansexp5");
                int rank = (Integer) session.getAttribute("rankexp5");
                String dataType = (String) session.getAttribute("datatypeexp5");
                String equations[] = (String[]) session.getAttribute("equationsexp5");
                int equ1[][] = new int[rank][rank];
                if (dataType.equals("Fix Point")) {
                    for (int i = 0; i < rank; i++) {
                        for (int j = 0; j < rank; j++) {
                            equ1[i][j] = (int) equ2[i][j];
                        }
                    }
                }
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
            <%
                out.println("Your Equations  :");
                for (int i = 0; i < rank; i++) {

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
                                <%for (int i = 0; i < rank; i++) {

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
                                <%for (int i = 0; i < rank; i++) {

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

                                <%for (int i = 0; i < rank; i++) {

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
                        for (int i = 0; i < rank; i++) {
                            out.println("<br>x<sub>" + i + "</sub> = " + ans[i]);
                        }
                    }
                %>
            </div>
        </div>



    </body>
</html>
