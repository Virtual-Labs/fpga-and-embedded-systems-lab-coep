<%-- 
    Document   : registerNew
    Created on : 7 Jul, 2012, 3:50:21 PM
    Author     : shree
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/front.css"  rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="css/style.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="css/jquery-ui-1.8.14.custom.css" type="text/css"  />
        <link rel="shortcut icon" href="favicon.ico">
        <script type="text/javascript" src="scripts/jquery.js"></script>
        <script type="text/javascript" src="scripts/jquery-ui.js"></script>
        <style type="text/css">
            .logodiv{
                border: solid 2px black;  
            }
            .laxclass{
                text-align: left; vertical-align: bottom; font-family:verdena; font-style: normal; color:#FF6633;font-size: x-large ;
            }


            /*body,html,div,blockquote,img,label,p,h1,h2,h3,h4,h5,h6,pre,ul,ol,li,dl,dt,dd,form,a,fieldset,input,th,td{border:0;outline:none;margin:0;padding:0;}*/
            body{height:100%;color:#1f1f1f;font-family:Arial,Verdana,sans-serif;font-size:13px;padding:7px 0;}
            ul, ol{list-style:none;}
            .text-center {text-align: center; padding: 10px 0;}
            .wrap {width: 960px; margin: 0 auto;}

            /* Tutorial CSS */
            /*Form styles*/
            .styled {
                font: 15px Arial, sans-serif; 
                width: 700px;/* 900*/ 
                margin: 40px auto; 
                background: url(images/bg_form.png) no-repeat 0 0; 
                padding-top: 20px;
            }
            .styled fieldset {
                left:250px;
                /*background: url(images/bg_form.png) no-repeat 0 0; */
                background-size:0 10%;
                padding: 0 25px 10px 30px; 
                position: absolute;
                padding-top:10px;
                padding-left:10px;
                padding-right:10px;
            }
            .mandate{
                font-weight:bold;
                color:red;

            }
            .styled fieldset h3 { 
                font: 24px bold Arial, sans-serif; 
                color: #555;
                margin-bottom: 0.5em;
            }
            /* Form rows */
            .styled fieldset li.form-row {
                margin-bottom: 5px; 
                padding: 3px 0; 
                clear: both; 
                position: relative;
            }
            .styled label {
                display: block; 
                font-weight: bold; 
                float: left; 
                width: 180px; 
                line-height: 24px; 
                padding-top: 4px; 
                color: #555;
            }
            .styled label.double {
                padding-top: 0; 
                line-height: 20px; 
                margin-top: -3px;
            }
            .styled fieldset li.button-row {
                margin-bottom: 0; 
                padding: 5px 0 0; 
                text-align: right;
            }
            /* Text input styles */
            /* Default */
            .styled input.text-input {
                height: 22px;
                width: 254px;
                padding: 5px 8px; 
                background: url(images/bg_input.png) no-repeat 0 0;  
                border: none;   
                font: normal 15px Arial, sans-serif;
                color: #333;
                line-height: 1em;
            }
            .styled select {
                height: 32px;
                width: 270px;
                padding: 5px 8px; 
                background: url(images/bg_input.png) no-repeat 0 0;  
                border: none;   
                font: normal 15px Arial, sans-serif;
                color: #333;
                line-height: 1em;
            }

            /* Form Validation */
            .styled span.error {
                font: bold 11px Arial, sans-serif;
                color:#fff;
                text-shadow: 1px 1px 1px #000;
                display: none; 
                background: url(images/arrow_error.png) no-repeat 0 center; 
                height: 11px;
                padding: 7px 15px 10px 20px; 
                line-height: 1em; 
                position: absolute; 
                top: 3px; 
                right: 0; 
                border-right: 1px solid #6c0202;
            }
            .styled fieldset li.error input.text-input {
                background-position: 0 -64px;
            }
            #apDiv7 {
                position:absolute;
                width:115px;
                height:115px;
                z-index:2;
                left: 27px;
                top: -22px;
            }
            #apDiv8 {
                position:absolute;
                width:200px;
                height:89px;
                z-index:4;
                left: 257px;
                top: -10px;
            }


        </style>

        <script type="text/javascript">
            $(document).ready(function() {
                //var pass,email,count=0;
                $('.required').each(function(){
                    $(this).val("");
                });
                
                $('#username').blur(function(){
                    var username = $('#username').val();
                    $.ajax({
                        url: 'CheckUser?username='+username,
                        type: "Post",
                        success: function(e){
                            alert(e);
                            $('#available').val = e;
                        },
                        fail:function(e){
                            alert("HI");
                        }
                    });
                });
                
                $('#form-sign-up').bind('submit',function(e){
				
					var valid=true;
					
					if($('#password').val()!=$('#confirm-password').val())
					{
					alert("Password Mismatch");
						valid=false;
					}
					else if($('#register-email').val()!=$('#confirm-email').val()){
						alert("Email Mismatch");
						valid=false;
					}
				
					if(valid){
				
                    var flag = false;
                    e.preventDefault();
                    var username = $('#username').val();
                    $.ajax({
                        url: 'CheckUser?username='+username,
                        type: "Post",
                        success: function(e1){
                            
                            //alert(e1);
                            if(e1 == "Username available")
                            {
                                
                                $('#form-sign-up').unbind('submit').submit();
                                flag = true;
                                
                            }else{
                                alert("Username already exist !!!")
                            }
                            //alert(e);
                            //$('#available').val = e;
                        },
                        fail:function(e2){
                            alert("HI");
                        }
                    });

                    if(flag == true){
                        $('#form-sign-up').unbind('submit');
						$('#form-sign-up').submit();
                    }
				}
				else{
					e.preventDefault();
				}
                    
                });
                
                // Fade out error message when input field gains focus
                $('.required').focus(function(){
                    var $parent = $(this).parent();
                    $parent.removeClass('error');
                    $('span.error',$parent).fadeOut();
                    $(this,$parent).val('');
                });
                
            });
        </script>
        
        <%
            String exp = (String) request.getParameter("url");
            System.out.println("Exp No : " + exp);
        
        %>
        
    </head>

    <body style="background-color: #E2EBED">
        <div >
            <table width="100%" class="logodiv"  >
                <tr>

                    <td width="60%" >
                        <img alt="COEP ICON" src="images/coep_logo.png" height="70"/>
                        <img alt="COEP ICON" src="images/coep_name1.png" height="70"/>
                    </td>
                    <td width="20%" style="vertical-align: bottom" >
                        <table width="100%">
                            <tr>
                                <td height="50%">&nbsp;</td>

                            </tr>
                            <tr>
                                <td id="laxtd" height="50%" class="laxclass" > </td>
                            </tr>
                        </table>

                    </td>


                </tr>
            </table>
        </div>
        <div class="wrap">
            <br><br><br><br>
            <form id="form-sign-up" class="styled" action="./RegisterUser" method="post">
                <fieldset>
                    <h3>Register Now!</h3>
                    <ol>
                        <li class="form-row"><label>Name:</label>
                            <input name="name" type="text" id="name" required class="text-input required name" /><span class="mandate"><sup>*</sup></span>
                        </li>
                        <li class="form-row"><label>College:</label>
                            <input name="college" type="text" id="college" required class="text-input required college" /><span class="mandate"><sup>*</sup></span>
                        </li>
                        <li class="form-row"><label>UserName:</label>
                            <input name="username" type="text" id="username" required class="text-input required username" /><span class="mandate"><sup>*</sup></span>

                        </li>
                        <li class="form-row"><label>Password:</label>
                            <input name="password" type="password" id="password" required class="text-input required password" /><span class="mandate"><sup>*</sup></span>
                        </li>
                        <li class="form-row"><label>Confirm Password:</label>
                            <input name="confirm-password" type="password" required id="confirm-password" class="text-input required confirm-password" /><span class="mandate"><sup>*</sup></span>
                        </li>
                        <li class="form-row"><label>Email:</label>
                            <input name="email" type="email" id="register-email" required class="text-input required register-email" /><span class="mandate"><sup>*</sup></span>
                        </li>
                        <li class="form-row"><label>Confirm Email:</label>
                            <input name="confirm-email" type="email" id="confirm-email" required class="text-input required confirm-email " /><span class="mandate"><sup>*</sup></span>
                        </li>
                        <!--	<li class="form-row"><label>Professor Incharge:</label>
                                  <input name="di" type="text" id="di" class="text-input required di" /><span class="mandate"><sup>*</sup></span>
                                </li>
                                <li class="form-row"><label>Contact No:</label>
                                  <input name="contact" type="text" id="cn" class="text-input required cn" /><span class="mandate"><sup>*</sup></span>
                                </li>
                        -->

                        <li class="button-row">
                            <input id="signin_submit" value="Register" tabindex="6" type="submit" class="btn-submit img-swap"/>
                        </li>
                        <label id="available"></label>
                        <li class="form-row">
                            <span class="mandate"><sup>*</sup></span><span>Required Field</span>
                        </li>
                        <li class="form-row">
                            <input type="hidden" name="url" value="<%=exp%>"/>
                        </li>
                    </ol>
                </fieldset>
            </form> 
        </div>



    </body>
</html>
