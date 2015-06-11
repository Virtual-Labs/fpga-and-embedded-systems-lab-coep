<%-- 
    Document   : loginExp
    Created on : 7 Jul, 2012, 3:48:11 PM
    Author     : shree
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="./favicon.ico">
        <link href="css/front.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="css/style.css" type="text/css"
                      media="screen" />
       
        <script type="text/javascript" src="js/jquery.js"></script>
        <script type="text/javascript" src="js/script.js"></script>
        <script type="text/javascript" src="js/test.js"></script>
        <link rel="shortcut icon" href="favicon.ico">
        
        <%
            String exp = (String) request.getParameter("expNo");
            System.out.println("Exp No : " + exp);
            request.setAttribute("url", exp);
        
        %>
        
        <style>
                        /*body,html,div,blockquote,img,label,p,h1,h2,h3,h4,h5,h6,pre,ul,ol,li,dl,dt,dd,form,a,fieldset,input,th,td{border:0;outline:none;margin:0;padding:0;}*/
                        body {
                            height: 100%;
                            color: #1f1f1f;
                            font-family: Arial, Verdana, sans-serif;
                            font-size: 13px;
                            padding: 7px 0;
                        }

                        ul,ol {
                            list-style: none;
                        }

                        .text-center {
                            text-align: center;
                            padding: 10px 0;
                        }

                        .wrap {
                            width: 960px;
                            margin: 0 auto;
                        }

                        /* Tutorial CSS */
                        /*Form styles*/
                        .styled {
                            font: 15px Arial, sans-serif;
                            width: 700px; /* 900*/
                            margin: 40px auto;
                            background: url(images/bg_form.png) no-repeat 0 0;
                            padding-top: 20px;
                        }

                        .styled fieldset {
                            left: 20px;
                            /*background: url(images/bg_form.png) no-repeat 0 0; */
                            background-size: 0 10%;
                            padding: 0 25px 10px 30px;
                            position: absolute;
                            padding-top: 60px;
                            padding-left: 10px;
                            padding-right: 10px;
                        }

                        .styled fieldset h3 {
                            font: 24px bold Arial, sans-serif;
                            color: #555;
                            margin-bottom: 1em;
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
                            width: 100px;
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
                            padding: 3px 0 0;
                            text-align: left;
                        }

                        #regfield {
                            left: 470px;
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
                            color: #fff;
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
                            position: absolute;
                            width: 115px;
                            height: 115px;
                            z-index: 2;
                            left: 27px;
                            top: -22px;
                        }

                        #apDiv8 {
                            position: absolute;
                            width: 200px;
                            height: 89px;
                            z-index: 4;
                            left: 257px;
                            top: -10px;
                        }
                        
                        .logodiv{
                            border: solid 2px black;  
                        }
                        .laxclass{
                            text-align: left; vertical-align: bottom; font-family:verdena; font-style: normal; color:#FF6633;font-size: x-large ;
                        }
                    </style>
        
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
        
        
        <div class="wrap" id="wrap">
            <br><br><br><br><br><br>
            <form id="form-sign-up" class="styled" action="./LoginMe" method="post">
                <fieldset>
                    <h3>
                        Login to perform Experiment
                    </h3>
                    <ol>
                        <li class="form-row">
                            <label>User Id:</label>
                            <input type="text" name="name"  id="register-email" 
                                   class="text-input required register-email" required="required"/><span
                            id="mandatory" style="font-weight: bold; color: red;">*</span>
                            
                        </li>
                        <li class="form-row">
                            <label>Password:</label>
                            <input name="password" type="password" id="password-1"
                            class="text-input required password-1" required="required"/>
                        </li>
                        <li class="form-row">
                            <input type="hidden" name="url" id="url" value="<%=exp%>"/>
                        </li>
                        <li class="button-row">
                            <input id="signin_submit" value="Sign in" tabindex="6" type="submit"
                            class="btn-submit img-swap" />
                        </li>
                        
                    </ol>
                </fieldset>
              </form>
                <form class="styled" action="registerNew.jsp?url=${url}" method="post">
                <fieldset id="regfield" style="border: 0; outline: none; margin: 0; padding: 0;">
                    <ol>
                        <li class="form-row">
                            <h3>Need an account!</h3>
                            <input id="register" value="Create an account" tabindex="6" type="submit"
                            class="img-swap"/>
                        </li>
                    </ol>
                </fieldset>
            </form>
        </div>
    </body>
</html>
