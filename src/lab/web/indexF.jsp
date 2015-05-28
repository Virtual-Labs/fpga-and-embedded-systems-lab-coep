<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"[]>
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US"
      xml:lang="en">
    <head>
        <!--
            Created by Artisteer v3.0.0.39952
            Base template (without user's data) checked by http://validator.w3.org : "This page is valid XHTML 1.0 Transitional"
        -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>COEP Virtual Lab</title>
        <meta name="description" content="Description" />
        <meta name="keywords" content="Keywords" />
        <link rel="shortcut icon" href="./favicon.ico">
            <link href="css/front.css" rel="stylesheet" type="text/css">
                <link rel="stylesheet" href="css/style.css" type="text/css"
                      media="screen" />

                <!--[if IE 6]><link rel="stylesheet" href="style.ie6.css" type="text/css" media="screen" /><![endif]-->
                <!--[if IE 7]><link rel="stylesheet" href="style.ie7.css" type="text/css" media="screen" /><![endif]-->

                <script type="text/javascript" src="js/jquery.js"></script>
                <script type="text/javascript" src="js/script.js"></script>
                <script type="text/javascript" src="js/test.js"></script>
                <link rel="shortcut icon" href="favicon.ico">
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
                    </style>
                    <script type="text/javascript">
			
                        function setUrl() {
                            var url = window.location.href;
                            var hashes = url.slice(url.indexOf('url=/vlabs') + 11); 
                            $("#url").val(hashes);
                        }
                        $(function() {
                            $('.required').each(function() {
                                $(this).val("");
                            });
                            $("#wrap").show();
                            $("#div-1").click(function() {
                                $("#wrap").hide();
                                $("#div-22").hide();
                                $("#div-33").hide();
                                $("#div-44").hide();
                                $("#div-55").hide();
                                $("#div-66").hide();
                                $("#div-77").hide();
                                $("#div-11").fadeIn();

                            });
                            $("#div-2").click(function() {
                                $("#wrap").hide();
                                $("#div-11").hide();
                                $("#div-33").hide();
                                $("#div-44").hide();
                                $("#div-55").hide();
                                $("#div-66").hide();
                                $("#div-77").hide();
                                $("#div-22").fadeIn("slow");
                            });
                            $("#div-3").click(function() {
                                $("#wrap").hide();
                                $("#div-11").hide();
                                $("#div-22").hide();
                                $("#div-44").hide();
                                $("#div-55").hide();
                                $("#div-66").hide();
                                $("#div-77").hide();
                                $("#div-33").fadeIn("slow");
                            });
                            $("#div-4").click(function() {
                                $("#wrap").hide();
                                $("#div-22").hide();
                                $("#div-33").hide();
                                $("#div-11").hide();
                                $("#div-55").hide();
                                $("#div-66").hide();
                                $("#div-77").hide();
                                $("#div-44").fadeIn("slow");
                            });
                            $("#div-5").click(function() {
                                $("#wrap").hide();
                                $("#div-22").hide();
                                $("#div-33").hide();
                                $("#div-44").hide();
                                $("#div-11").hide();
                                $("#div-66").hide();
                                $("#div-77").hide();
                                $("#div-55").fadeIn("slow");
                            });
                            $("#div-6").click(function() {
                                $("#wrap").hide();
                                $("#div-22").hide();
                                $("#div-33").hide();
                                $("#div-44").hide();
                                $("#div-55").hide();
                                $("#div-11").hide();
                                $("#div-77").hide();
                                $("#div-66").fadeIn("slow");
                            });
                            $("#div-7").click(function() {
                                $("#wrap").hide();
                                $("#div-22").hide();
                                $("#div-33").hide();
                                $("#div-44").hide();
                                $("#div-55").hide();
                                $("#div-66").hide();
                                $("#div-11").hide();
                                $("#div-77").fadeIn("slow");
                            });

                            /*login code*/

                            $('.btn-submit')
                            .click(
                            function(e) {

                                // Declare the function variables:
                                // Parent form, form URL, email regex and the error HTML
                                var $formId = $(this).parents('form');
                                var formAction = $formId.attr('action');
                                //var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
                                var $error = $('<span class="error"></span>');
                                var ck_username = /^[A-Za-z][A-Za-z0-9_]{3,20}$/;
                                var ck_password = /^[A-Za-z0-9!@#$%^&*()_]{6,50}$/;
                                // Prepare the form for validation - remove previous errors
                                $('li', $formId).removeClass('error');
                                $('span.error').remove();

                                // Validate all inputs with the class "required"
                                $('.required', $formId)
                                .each(
                                function() {

                                    var inputVal = $(
                                    this).val();
                                    var $parentTag = $(
                                    this)
                                    .parent();
                                    if (inputVal == '') {

                                        $parentTag
                                        .addClass(
                                        'error')
                                        .append(
                                        $error
                                        .clone()
                                        .text(
                                        'Required Field'));
                                    }

                                    // Run the email validation using the regex for those input items also having class "email"
                                    if (inputVal != '') {
                                        if ($(this)
                                        .hasClass(
                                        'register-email') == true) {
                                            if (!ck_username
                                            .test(inputVal)) {
                                                $parentTag
                                                .addClass(
                                                'error')
                                                .prepend(
                                                $error
                                                .clone()
                                                .text(
                                                'Enter valid Name'));
                                            }

                                        }
                                        if ($(this)
                                        .hasClass(
                                        'password-1') == true) {
                                            if (!ck_password
                                            .test(inputVal)) {
                                                $parentTag
                                                .addClass(
                                                'error')
                                                .append(
                                                $error
                                                .clone()
                                                .text(
                                                'Enter valid password'));
                                            }

                                        }
                                    }
                                });

                                // All validation complete - Check if any errors exist
                                // If has errors
                                if ($('span.error').length > 0) {

                                    $('span.error')
                                    .each(
                                    function() {

                                        // Set the distance for the error animation
                                        var distance = 5;

                                        // Get the error dimensions
                                        var width = $(
                                        this)
                                        .outerWidth();

                                        // Calculate starting position
                                        var start = width
                                            + distance;

                                        // Set the initial CSS
                                        $(this)
                                        .show()
                                        .css(
                                        {
                                            display : 'block',
                                            opacity : 0,
                                            right : -start
                                                + 'px'
                                        })
                                        // Animate the error message
                                        .animate(
                                        {
                                            right : -width
                                                + 'px',
                                            opacity : 1
                                        },
                                        'slow');

                                    });
                                } else {

                                    $formId.submit();

                                }
                                // Prevent form submission
                                e.preventDefault();
                            });

                            // Fade out error message when input field gains focus
                            $('.required').focus(function() {
                                var $parent = $(this).parent();
                                $parent.removeClass('error');
                                $('span.error', $parent).fadeOut();
                                $(this, $parent).val('');
                            });

                        });
                    </script>
                    </head>
                    <body>
                        <div id="art-page-background-glare">
                            <div id="art-page-background-glare-image"></div>
                        </div>
                        <div id="art-main">
                            <div class="art-sheet">
                                <div class="art-sheet-tl"></div>
                                <div class="art-sheet-tr"></div>
                                <div class="art-sheet-bl"></div>
                                <div class="art-sheet-br"></div>
                                <div class="art-sheet-tc"></div>
                                <div class="art-sheet-bc"></div>
                                <div class="art-sheet-cl"></div>
                                <div class="art-sheet-cr"></div>
                                <div class="art-sheet-cc"></div>
                                <div class="art-sheet-body">
                                    <div class="art-header">
                                        <div class="art-header-clip">
                                            <div class="art-header-center">

                                                <div class="art-header-jpeg"></div>


                                            </div>
                                        </div>
                                        <div class="art-logo">
                                            <div id="apDiv8">
                                                <img src="images/coep_name_old.png" width="485" height="90" />
                                            </div>
                                            <div id="apDiv7">
                                                <img src="images/coep_logo.png" width="115" height="120" />
                                            </div>
                                            <span id="virtualLab">Virtual Lab</span>

                                        </div>
                                    </div>
                                    <div class="art-nav">
                                        <div class="art-nav-l"></div>
                                        <div class="art-nav-r"></div>
                                        <div class="art-nav-m"></div>
                                        <div class="art-nav-n"></div>
                                        <div class="art-nav-outer">
                                            <ul class="art-hmenu">
                                                <li><a href="./index.html" class="active"><span
                                                            class="l"></span><span class="r"></span><span class="t">Login</span>
                                                    </a>
                                                </li>
                                                <li><a href="./Contact.html"><span class="l"></span><span
                                                            class="r"></span><span class="t">Contact us </span>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="art-content-layout">
                                        <div class="art-content-layout-row">
                                            <div class="art-layout-cell art-sidebar1">
                                                <div class="art-vmenublock">
                                                    <div class="art-vmenublock-tl"></div>
                                                    <div class="art-vmenublock-tr"></div>
                                                    <div class="art-vmenublock-bl"></div>
                                                    <div class="art-vmenublock-br"></div>
                                                    <div class="art-vmenublock-tc"></div>
                                                    <div class="art-vmenublock-bc"></div>
                                                    <div class="art-vmenublock-cl"></div>
                                                    <div class="art-vmenublock-cr"></div>
                                                    <div class="art-vmenublock-cc"></div>
                                                    <div class="art-vmenublock-body">
                                                        <div class="art-vmenublockheader">
                                                            <div class="l"></div>
                                                            <div class="r"></div>
                                                            <h3 class="t">About COEP</h3>
                                                        </div>
                                                        <div class="art-vmenublockcontent">
                                                            <div class="art-vmenublockcontent-body">
                                                                <ul class="art-vmenu">
                                                                    <li><a href="#"><span class="l"></span><span
                                                                                class="r"></span><span class="t"><div id="div-1">Chairman's
																Message</div>
                                                                            </span>
                                                                        </a></li>

                                                                    <li><a href="#"><span class="l"></span><span
                                                                                class="r"></span><span class="t"><div id="div-2">Director's
																Message</div>
                                                                            </span>
                                                                        </a></li>
                                                                    <li><a href="#"><span class="l"></span><span
                                                                                class="r"></span><span class="t"><div id="div-3">Mission,Vision
                                                                                    &amp;Goals</div>
                                                                            </span>
                                                                        </a></li>
                                                                    <li><a href="#"><span class="l"></span><span
                                                                                class="r"></span><span class="t"><div id="div-4">History</div>
                                                                            </span>
                                                                        </a></li>
                                                                    <li><a href="#"><span class="l"></span><span
                                                                                class="r"></span><span class="t"><div id="div-5">Alumni
																Network</div>
                                                                            </span>
                                                                        </a></li>
                                                                    <li><a href="#"><span class="l"></span><span
                                                                                class="r"></span><span class="t"><div id="div-6">Campus</div>
                                                                            </span>
                                                                        </a></li>
                                                                    <li><a href="#"><span class="l"></span><span
                                                                                class="r"></span><span class="t"><div id="div-7">Boat
																Club</div>
                                                                            </span>
                                                                        </a></li>
                                                                </ul>


                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                                <div class="art-vmenublock">
                                                    <div class="art-vmenublock-tl"></div>
                                                    <div class="art-vmenublock-tr"></div>
                                                    <div class="art-vmenublock-bl"></div>
                                                    <div class="art-vmenublock-br"></div>
                                                    <div class="art-vmenublock-tc"></div>
                                                    <div class="art-vmenublock-bc"></div>
                                                    <div class="art-vmenublock-cl"></div>
                                                    <div class="art-vmenublock-cr"></div>
                                                    <div class="art-vmenublock-cc"></div>
                                                    <div class="art-vmenublock-body">
                                                        <div class="art-vmenublockheader">
                                                            <div class="l"></div>
                                                            <div class="r"></div>
                                                            <h3 class="t">Virtual Lab Links</h3>
                                                        </div>
                                                        <div class="art-vmenublockcontent">
                                                            <div class="art-vmenublockcontent-body">
                                                                <ul class="art-vmenu">
                                                                    <li><a href="#"><span class="l"></span><span
                                                                                class="r"></span><span class="t"><div id="link-1">Pre
																Test</div>
                                                                            </span>
                                                                        </a></li>

                                                                    <li><a href="#"><span class="l"></span><span
                                                                                class="r"></span><span class="t"><div id="link-2">Post
																Test</div>
                                                                            </span>
                                                                        </a></li>
                                                                    <li><a href="#"><span class="l"></span><span
                                                                                class="r"></span><span class="t"><div id="link-3">Additional
																Resources</div>
                                                                            </span>
                                                                        </a></li>
                                                                    <li><a href="http://coep.vlab.co.in/" target="_blank"><span
                                                                                class="l"></span><span class="r"></span><span class="t"><div
                                                                                    id="link-4">Virtual Lab HOME</div>
                                                                            </span>
                                                                        </a></li>
                                                                    <li><a href="http://www.coep.org.in/" target="_blank"><span
                                                                                class="l"></span><span class="r"></span><span class="t"><div
                                                                                    id="link-5">COEP HOME</div>
                                                                            </span>
                                                                        </a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--							<div class="art-block">
								<div class="art-block-tl"></div>
								<div class="art-block-tr"></div>
								<div class="art-block-bl"></div>
								<div class="art-block-br"></div>
								<div class="art-block-tc"></div>
								<div class="art-block-bc"></div>
								<div class="art-block-cl"></div>
								<div class="art-block-cr"></div>
								<div class="art-block-cc"></div>
								<div class="art-block-body">
									<div class="art-blockheader">
										<div class="l"></div>
										<div class="r"></div>
										<h3 class="t">Simulation Videos</h3>
									</div>
									<div class="art-blockcontent">
										<div class="art-blockcontent-body">
											<img src="images/YouTube.png" />
											 <p>Enter Block content here...</p>
                                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam pharetra, tellus sit amet congue vulputate, nisi erat iaculis nibh, vitae feugiat sapien ante eget mauris. </p> 
											<div class="cleared"></div>
										</div>
									</div>
									<div class="cleared"></div>
								</div>
							</div>-->
                                            </div>
                                            <div class="art-layout-cell art-content">
                                                <div class="art-post"
                                                     style="position: relative; width: 730px; height: 700px;">
                                                    <div class="art-post-body">
                                                        <!--<div id="div-00"><img src="images/coep3.jpg" style="height:400px;width:700px;"/><br><br/>
				<div id="div-txt" style="color:red;height:50px;width:700px;font-family:fantasy">College of Engineering, Pune (COEP) is an engineering college in Pune, India. Established in 1854, it is the third oldest engineering college in Asia, after the College of Engineering, Guindy (1794) and IIT Roorkee (1847).</div>
				</div>-->
                                                        <div class="wrap" id="wrap">
                                                            <form id="form-sign-up" class="styled" action="./LoginMe"
                                                                  method="post">
                                                                <fieldset>
                                                                    <h3>Login to Virtual Lab!</h3>
                                                                    <div id="msgdisp" style="color: red">Invalid Username or Password!!</div>
                                                                    <ol>
                                                                        <li class="form-row"><label>User Id:</label> <input
                                                                                name="name" type="text" id="register-email"
                                                                                class="text-input required register-email" /><span
                                                                                id="mandatory" style="font-weight: bold; color: red;">*</span>
                                                                        </li>
                                                                        <li class="form-row"><label>Password:</label> <input
                                                                                name="password" type="password" id="password-1"
                                                                                class="text-input required password-1" /></li>
                                                                        <li class="form-row">
                                                                            <input name="url" type="hidden" id="url" />
                                                                        </li>
                                                                        <li class="form-row">
                                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
                                                                                id="msg" style="color: red;">*You must enter a
															minimum of 6 characters.</span></li>

                                                                        <li class="button-row"><input id="signin_submit"
                                                                                                      value="Sign in" tabindex="6" type="submit"
                                                                                                      class="btn-submit img-swap" />Or&nbsp;  <a id="register1" type=""  href="./forgotpasswd.html">Forgot Password</a>
                                                                            &nbsp;
                                                                            <!-- <input  name="remember_me" value="1" tabindex="7" type="checkbox">&nbsp;Keep me logged in-->
                                                                            <a href="./resetpassword.html" >Change Password</a>
                                                                        </li>
                                                                    </ol>
                                                                </fieldset>
                                                                <fieldset id="regfield"
                                                                          style="border: 0; outline: none; margin: 0; padding: 0;">
                                                                    <ol>
                                                                        <li class="form-row">
                                                                            <h3>Need an account!</h3> <input id="register"
                                                                                                             value="Create an account" tabindex="6" type="submit"
                                                                                                             class="img-swap" onClick="window.open('register.html')" />
                                                                        </li>
                                                                    </ol>
                                                                </fieldset>

                                                            </form>
                                                        </div>

                                                        <div id="div-11" style="display: none">
                                                            <table border="0">
                                                                <tbody>
                                                                    <tr>
                                                                        <td class="page_td"><a href="images/fc_kohli.jpg"
                                                                                               target="_blank"><img class="page"
                                                                                                 src="images/fc_kohli.jpg" alt="" width="100" />
                                                                            </a><br />
                                                                        </td>
                                                                        <td class="page_td" valign="bottom"><em><strong>Dr.
                                                                                    &nbsp;Faqir Chand&nbsp;<em>Kohli</em>
                                                                                </strong>&nbsp;<br />Chairman, Board of Governors, CoEP<br />
                                                                            </em>
                                                                        </td>
                                                                    </tr>

                                                                </tbody>
                                                            </table>

                                                            <p>&nbsp;</p>

                                                            <p align="justify">
											Engineering Education has undergone many conceptual changes
											since its establishment as a discipline of serious study,
											innovation and research after the industrial revolution. In
											the "Nineteenth" century, the emphasis was on innovation and
											personal ingenuity. The education and training in this period
											were "HOW" dominated, and the efficacy of education and
											training depended largely on the personal skill of the
											trainers in operating, manipulating and developing new
											machines and gadgets. The "Twentieth" century brought in an
											attitude of scientific analysis involving engineering systems
											and education became more "WHY" dominated, more science
											based. Knowledge of "Know-why" is better than merely
											knowledge of "Know-how" became the catchword. Innovations
											were still important, but problem solving became more and
											more science driven. The "Twenty-first" century is
											threatening to be dominated by informationprocessing and
											management practices. <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Education
											and training will not worry about "WHY" but "WHY NOT" and
											"HOW BEST". This century, I feel will visualize the infusion
											of technology into engineering. Today, technological society
											is synonymous with a tinkering culture, where every
											individual has basic technical skills and can take care of
											simple things like replacing a fuse, fixing a leaking tap,
											changing a tyre in the car, repairing a bicycle, changing the
											gasket in the pressure cooker etc. R&amp;D can emerge only
											out of competitive tinkering. So also innovations come in
											shapes and sizes. It's the application that gives innovation
											it's meaning. While mentioning the future, it would be unwise
											to neglect the present. I feel our engineering education
											system is facing a number of challenges and hardships, be it
											trained faculty, curriculum design, quality system assurance,
											lab facilities up gradation, resource crises or management
											transformation, which need identification and steps for
											alleviation. As self-governance demands wholehearted
											participation of all stakeholders; students can be assured of
											a fair representation in the teaching,..learning process. <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A
											150-year- old legacy under the autonomous status is now
											geared up to face ever changing social- setup and acting
											proactively would now mean addressing the following issues:
											Dynamism in curriculum to excite and challenge the intellect
											of the student- community; Develop alternative teaching
											techniques; Greater focus on imparting skills and knowledge
											rather than assessment methodology; Explore the immense
											goodwill of well-placed alumni for further growth of the
											institute; Strengthen institute-industry interaction; Upgrade
											institute into top-class research academia I feel the
											prospects of an Engineer's Educational Training is as
											profoundly practical as it is Profoundly Theoretical that
											will embrace Cultivation of Human Qualities as will enable
											Engineers to meet Men as well as Matter. The future is
											promising and let us make a joint endeavour to mould the
											institute enriched with a long tradition and scientific
											achievements into a temple of learning, widening the horizons
											of science and technology in service to the community and
											society.
                                                            </p>
                                                            <p>
                                                                <strong>Dr. F. C. KOHLI<br />(Chairman, BoG)</strong>
                                                            </p>
                                                        </div>
                                                        <div id="div-22" style="display: none">
                                                            <table border="0">

                                                                <tbody>

                                                                    <tr>

                                                                        <td class="page_td" align="left" valign="bottom"><a
                                                                                href="images/director.png" target="_blank"><img
                                                                                    class="page" src="images/director.png" alt="" width="100" />
                                                                            </a>
                                                                        </td>

                                                                        <td class="page_td" valign="bottom"><em><strong>Dr.
																Anil D. Sahasrabudhe</strong>&nbsp;joined COEP as the director in
															2006. He holds a vision to take COEP to the next level
															with a view to enriching the life of every student who
															enters COEP.</em>
                                                                        </td>

                                                                    </tr>

                                                                </tbody>

                                                            </table>

                                                            <p align="justify">
                                                                <br />The College of Engineering, Pune, was established in
											the year 1854 before any of the formal degree awarding
											universities took roots in India. In the formative years, it
											was a training school for the officers involved in public
											works like buildings, dams, canals, railways and bridges.
											Thanks to the vision in starting such an establishment, the
											credit for most of the civil infrastructure in India goes to
											the alumni of this college, starting from none other than the
											most towering and illustrious engineers, Bharat Ratna Sir M.
											Visvesvaraya, in whose honour " Engineers Day " is
											celebrated. The school became Poona Civil Engineering
											College, and subsequently in the year 1911, the nomenclature
											was changed to the College of Engineering, Poona. It was
											initially affiliated to the University of Bombay (now Mumbai)
											for a degree of Licentiate in Civil Engineering known as LCE
											and later to the University of Pune. The first batch of the
											B.E. (Civil) degree students came out in the year 1912. In
											the very same year the Mechanical Engineering Department was
											started. Subsequently, degree courses in Electrical
											Engineering, Electronics and Telecommunication, Metallurgy,
											Production, Instrumentation and Control, Computer Engineering
											and Information Technology were started as and when such
											demand and requirement arose in the country. The
											post-graduate degree courses were introduced in the various
											branches regularly since 1959. The college has also been a
											recognized research centre for the Ph.D. programme of
											University of Pune.&nbsp;
                                                            </p>
                                                        </div>
                                                        <div id="div-33" style="display: none">
                                                            <table style="table-layout: fixed" width="100%" border="0"
                                                                   cellspacing="0">

                                                                <tr>

                                                                    <td width="495" height="493" valign="top"
                                                                        class="page_content">

                                                                        <p class="page_title"
                                                                           style="font-size: large; font-weight: bold;">Mission,
														Vision &amp; Goals</p>

                                                                        <div class="page_body">
                                                                            <table border="0" cellspacing="4" width="98%"
                                                                                   align="center">

                                                                                <tbody>

                                                                                    <tr>

                                                                                        <td class="page_td" colspan="3" width="88%"
                                                                                            align="left" valign="top">

                                                                                            <div>

                                                                                                <div class="testimonial_text">
                                                                                                    <strong>Mission</strong>
                                                                                                </div>

                                                                                                <div class="testimonial_text"
                                                                                                     style="padding-left: 30px;">
                                                                                                    <br />To pursue excellence in all facets of
																				institute functioning.
                                                                                                </div>

                                                                                            </div></td>

                                                                                    </tr>

                                                                                    <tr>

                                                                                        <td class="page_td" colspan="3" align="left"
                                                                                            valign="top">

                                                                                            <div class="testimonial_text">
                                                                                                <strong>Vision</strong>
                                                                                            </div>

                                                                                            <div class="testimonial_text"
                                                                                                 style="padding-left: 30px;">
                                                                                                <br />To be a leader amongst engineering
																			institutions in India, constantly pursuing
																			excellence, and offering world class education with
																			values
                                                                                            </div></td>

                                                                                    </tr>

                                                                                    <tr>

                                                                                        <td class="page_td" colspan="3" align="left"
                                                                                            valign="top">

                                                                                            <div id="deptmenus" class="testimonial_text">

                                                                                                <p>
                                                                                                    <strong>Core Values</strong>
                                                                                                </p>

                                                                                                <p style="padding-left: 30px;">
                                                                                                    <strong>&nbsp;</strong>&ldquo;Quality and Excellence
																				in Education&rdquo; at COEP bears witness to
                                                                                                </p>

                                                                                                <p style="padding-left: 30px;">
                                                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Excellence&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Innovation<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ethics&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Commitment<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Values
                                                                                                </p>

                                                                                            </div></td>

                                                                                    </tr>

                                                                                    <tr>

                                                                                        <td colspan="3" align="left" valign="top">

                                                                                            <div class="testimonial_text">
                                                                                                <strong>Goals</strong>
                                                                                            </div>

                                                                                            <div class="testimonial_text">
                                                                                                <strong>&nbsp;</strong>
                                                                                            </div>

                                                                                            <div class="testimonial_text">

                                                                                                <ul>

                                                                                                    <li>To be among the&nbsp;top ten
																					institutes&nbsp;of the country in the next 5 years
																					and be a Deemed University.</li>

                                                                                                    <li>To be a&nbsp;student centric institute,
																					where academics is followed with utmost passion and
																					sincerity.</li>

                                                                                                    <li>To attain a faculty to student ratio
																					of&nbsp;1:12 and 1:9, within&nbsp;2 and
																					5&nbsp;years respectively.</li>

                                                                                                    <li>To be a campus where every faculty
																					possesses&nbsp;Ph.D degree, within 5 years.</li>

                                                                                                    <li>To ensure a continuous&nbsp;value
																					addition&nbsp;of all employees.</li>

                                                                                                    <li>To strengthen&nbsp;collaborations and
																					establish bonds&nbsp;with outside world and
																					institutes.</li>

                                                                                                    <li>To establish&nbsp;interdisciplinary
																					research&nbsp;centers.</li>

                                                                                                    <li>To attain&nbsp;25 % growth&nbsp;in terms of
																					programs offered and intake capacity within 5
																					years.</li>

                                                                                                    <li>To be&nbsp;50 &amp; 100 %&nbsp;self
																					sustainable campus within&nbsp;2 &amp; 5
																					years&nbsp;respectively.</li>

                                                                                                    <li>To be a residential campus
																					providing&nbsp;100 % student accommodation&nbsp;and
																					at least&nbsp;30 % faculty accommodation&nbsp;in
																					the next&nbsp;5 years.</li>

                                                                                                </ul>

                                                                                            </div></td>

                                                                                    </tr>

                                                                                </tbody>

                                                                            </table>
                                                                            </table>
                                                                        </div>
                                                                        <div id="div-44" style="display: none">
                                                                            <table border="0">

                                                                                <tbody>

                                                                                    <tr>

                                                                                        <td class="page_td"><a href="images/vish_history.jpg"
                                                                                                               target="_blank"><img src="images/vish_history.jpg"
                                                                                                                 alt="" width="100" />
                                                                                            </a><br />
                                                                                        </td>

                                                                                        <td class="page_td" valign="bottom">

                                                                                            <p>&nbsp;</p>

                                                                                            <p align="justify">
                                                                                                <em><strong>Sir M.Visvesvarayya, Bharat
																	Ratna and COEP Alumnus. One of India's greatest
																	engineers.</strong><br />
                                                                                                    <br />
                                                                                                </em>
                                                                                            </p></td>

                                                                                    </tr>

                                                                                </tbody>

                                                                            </table>

                                                                            <p align="justify">COEP's precursor, The Poona Engineering
											Class and Mechanical School was opened in July 1854, its aim
											being to provide suitable instruction for subordinate
											officers in the Public Works Department. The School was
											situated in Bhawani Peth, Poona , and the accommodation
											consisted of three small detached houses for teaching
											purposes and a separate house for the Principal.</p>

                                                                            <p align="justify">In June 1865 Mr. Theodore Cooke, M.A
											who held that appointment for 28 years was appointed
											Principal. The foundation stone of the new college was laid
											by His Excellency the Governor, Sir Bartle Frere, on the 5th
											August 1865.</p>

                                                                            <p class="maintext" align="justify">College was affiliated
											to University of Bombay in 1866. In 1868 the College moved to
											the New Buildings. The college was divided into three
											departments for matriculated and unmatriculated students.</p>

                                                                            <p class="maintext" align="justify">In 1879 two new
											classes, an Agricultural class and a Forest class , were
											added to the college , and the name of the college was
											changed from " The Poona Civil Engineering College " to " The
											College of Science".</p>

                                                                            <p class="maintext" align="justify">Thanks to the vision
											in setting up such an establishment at Pune, the credit for
											most of the civil infrastructure in India goes to the alumni
											of this college, starting from none other than the most
											towering and illustrious engineers, Bharat Ratna Sir M.
											Visvesvarayya, in whose honor "Engineers Day" is celebrated.
											The school became Poona Civil Engineering College, and
											subsequently in the year 1911, the nomenclature was changed
											to the College of Engineering, Poona. It was initially
											affiliated to the University of Bombay for a degree of
											Licentiate in Civil Engineering known as LCE and later to the
											University of Pune. The degree programs in civil engineering,
											mechanical engineering and electrical engineering were
											started in 1908, 1912 and 1932, respectively. From then on,
											the college has gone on expanding adding new departments and
											new wings by the year.</p>

                                                                            <p class="maintext" align="justify">In 2003, the college
											got autonomous status, thus giving it the freedom to set its
											own curricula and manage its own finances. This has been the
											biggest change as far as pedagogy at COEP is concerned.</p>

                                                                            <p class="maintext" align="justify">Today, COEP offers
											nine UG and eighteen PG programmes, and has more than 3200
											students enrolled in its various courses.</p>
                                                                        </div>
                                                                        <div id="div-55" style="display: none">
                                                                            <table style="table-layout: fixed" width="100%" border="0"
                                                                                   cellspacing="0">

                                                                                <tr>

                                                                                    <td width="495" height="493" valign="top"
                                                                                        class="page_content">

                                                                                        <p class="page_title"
                                                                                           style="font-size: large; font-weight: bold;">Alumni
														Network</p>
                                                                                        <br />
                                                                                        <br />

                                                                                        <div class="page_body">
                                                                                            <p>One of the biggest assets of COEP is its large,
															wide and powerful Alumni base. Being a college with more
															than 150 years of great education behind it COEP has
															hundred of thousands of successful alumni dotting in
															globe in countries from the US to Australia and UK,
															France to Japan and China.</p>

                                                                                            <p align="justify">
                                                                                                <span>The Alumni foundation in COEP functions
																through the US-based&nbsp;</span><a title="Foundation"
                                                                                                                                    href="http://www.coepfoundation.org/" target="_blank">COEP
																Foundation</a>,&nbsp;<a title="Alumni"
                                                                                                                        href="http://www.coepalumni.net/" target="_blank">COEP
																Alumni Association India</a>&nbsp;<span>and the</span>&nbsp;Student
															Alumni Co-ordination Cell,&nbsp;<span>in COEP.</span>
                                                                                            </p>

                                                                                            <p align="justify">The COEP alumni contribute to make
															the education of COEP students as rich and profitable as
															possible. They help in interships, sponsoring college
															projects, research initiatives and post-graduate
															guidance.</p>

                                                                                            <p align="justify">
                                                                                                <strong>Explore this section to find out how the
																COEP Experience is taken to another level via the Alumni
																initiative.</strong>
                                                                                            </p>
                                                                                            </table>
                                                                                        </div>
                                                                                        <div id="div-66" style="display: none">
                                                                                            <table style="table-layout: fixed" width="100%" border="0"
                                                                                                   cellspacing="0">

                                                                                                <tr>

                                                                                                    <td width="495" height="493" valign="top"
                                                                                                        class="page_content">

                                                                                                        <p class="page_title"
                                                                                                           style="font-size: large; font-weight: bold;">Campus</p>
                                                                                                        <br />
                                                                                                        <br />

                                                                                                        <div class="page_body">
                                                                                                            <p>
                                                                                                                <strong>Location</strong>
                                                                                                            </p>

                                                                                                            <p>COEP is conveniently located at the heart of Pune.</p>

                                                                                                            <p>
															The approx. distances from major landmarks are:<br />
                                                                                                                <strong><br />Shivajinagar Train Station</strong>: 0.5
															km&nbsp;<br />
                                                                                                                <strong>Pune Train Station&nbsp;</strong>: 2.5 km&nbsp;<br />
                                                                                                                <strong>Pune International Airport</strong>&nbsp;: 12 km
                                                                                                            </p>

                                                                                                            <p>Pune is accessible through road, rail and air.</p>

                                                                                                            <p>
                                                                                                                <a
                                                                                                                    href="http://maps.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=Coep-+Main+Building,+RB+Motilal+Kennedy+Rd,+Shivaji+Nagar,+Pune,+Maharashtra,+India&amp;aq=0&amp;sll=18.529651,73.857586&amp;sspn=0.002787,0.004823&amp;ie=UTF8&amp;hq=Coep-+Main+Building,+RB+Motilal+Kennedy+Rd,+Shivaji+Nagar,+Pune,+Maharashtra,+India&amp;ll=18.52922,73.856547&amp;spn=0.021159,0.032015"
                                                                                                                    target="_blank"><img
                                                                                                                        src="http://maps.google.com/maps/api/staticmap?center=Coep-%20Main%20Building%20Pune&amp;zoom=15&amp;format=png32&amp;maptype=roadmap&amp;mobile=false&amp;markers=|color:red|label:COEP|18.5293%2C73.856449&amp;size=450x300&amp;key=&amp;sensor=false"
                                                                                                                        alt="" width="450" height="300" />
                                                                                                                </a><br />
                                                                                                                <small><a
                                                                                                                        style="color: #0000ff; text-align: left;"
                                                                                                                        href="http://maps.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=Coep-+Main+Building,+RB+Motilal+Kennedy+Rd,+Shivaji+Nagar,+Pune,+Maharashtra,+India&amp;aq=0&amp;sll=18.529651,73.857586&amp;sspn=0.002787,0.004823&aamp;ie=UTF8&amp;hq=Coep-+Main+Building,+RB+Motilal+Kennedy+Rd,+Shivaji+Nagar,+Pune,+Maharashtra,+India&amp;ll=18.52922,73.856547&amp;spn=0.021159,0.032015"
                                                                                                                        target="_blank">View Larger Map</a>
                                                                                                                </small>
                                                                                                            </p>
                                                                                                            </table>
                                                                                                        </div>
                                                                                                        <div id="div-77" style="display: none">
                                                                                                            <table style="table-layout: fixed" width="100%" border="0"
                                                                                                                   cellspacing="0">

                                                                                                                <tr>

                                                                                                                    <td width="495" height="493" valign="top"
                                                                                                                        class="page_content">

                                                                                                                        <p class="page_title"
                                                                                                                           style="font-size: large; font-weight: bold;">Boat Club</p>
                                                                                                                        <br />
                                                                                                                        <br />

                                                                                                                        <div class="page_body">

                                                                                                                            <p style="margin-bottom: 0cm;" align="justify">COEP is
															proud to have a Boat Club, which is one of its kind in
															the country. Situated on the banks of Mula River, this
															club was established in the year 1928. The club owns
															about 70 trainee and racing boats, which can be used for
															various competitions besides regular practice. The club
															is an active member of professional associations like
															Maharashtra Rowing Association (MRA) and the Amateur
															Rowers Association (ARAE).</p>

                                                                                                                            <p style="margin-bottom: 0cm;" align="justify">There
															are a wide variety of unique boats that include punts,
															single sculls, racing pair, racing four, racing eight,
															Jr. Whiff, Sr. Whiff, training scull, tuff four, canoes
															and kayaks. In addition, the boat club houses a well
															equipped gymnasium. This includes a sprawling indoor hall
															comprising of four badminton courts and one table-tennis
															court, thus providing the students of this college the
															best athletic endeavors. It hosts a canteen as well.
															Membership of the Boat club is mandatory to all the under
															graduate and postgraduate students seeking admission to
															this institute. Moreover, the facilities of the boat club
															are extended to every Alumni of this College.</p>

                                                                                                                            <p align="justify">
															The BC, as it is known, is the favourite spot for almost
															everyone in college. The riverside ambience offers a
															majestic view of the Mula River. The BC has become
															synonymous with COEP for every COEPian.<br />
                                                                                                                                <a href="http://coepboatclub.com/index.html"
                                                                                                                                   target="_blank"></a>
                                                                                                                            </p>

                                                                                                                            <p>
                                                                                                                                <a href="http://coepboatclub.com/index.html"
                                                                                                                                   target="_blank">http://coepboatclub.com/index.html</a>
                                                                                                                            </p>
                                                                                                                            </table>
                                                                                                                        </div>
                                                                                                                        </div>


                                                                                                                        </div>
                                                                                                                        </div>
                                                                                                                        </div>



                                                                                                                        </div>
                                                                                                                        <div class="art-footer">
                                                                                                                            <div class="art-footer-t"></div>
                                                                                                                            <div class="art-footer-l"></div>
                                                                                                                            <div class="art-footer-b"></div>
                                                                                                                            <div class="art-footer-r"></div>
                                                                                                                            <div class="art-footer-body">
                                                                                                                                <a href="#" class="art-rss-tag-icon" title="RSS"></a>
                                                                                                                                <div class="art-footer-text">
                                                                                                                                    <p>
                                                                                                                                        <a href="./index.html">About Us</a> | <a href="./contact.html">Contact
									Us</a> | <a href="./feedback.html">Feedback</a>
                                                                                                                                    </p>
                                                                                                                                    <p>Copyright © 2011.COEP Virtual Lab.</p>
                                                                                                                                </div>
                                                                                                                                <div class="cleared"></div>
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                        </div>

                                                                                                                        </div>
                                                                                                                        <script type="text/javascript">
                                                                                                                            $(document).ready(function() {
                            
                            
                            
                                                                                                                                // alert(topic);

                                                                                                                               
                                                                                                                                $(".signin").click(function(e) {
                                                                                                                                    e.preventDefault();
                                                                                                                                    $("fieldset#signin_menu").toggle();
                                                                                                                                    $(".signin").toggleClass("menu-open");
                                                                                                                                });

                                                                                                                                $("fieldset#signin_menu").mouseup(function() {
                                                                                                                                    return false
                                                                                                                                });
                                                                                                                                $(document).mouseup(function(e) {
                                                                                                                                    if ($(e.target).parent("a.signin").length == 0) {
                                                                                                                                        $(".signin").removeClass("menu-open");
                                                                                                                                        $("fieldset#signin_menu").hide();
                                                                                                                                    }
                                                                                                                                });

                                                                                                                            });
                                                                                                                        </script>
                                                                                                                        <script src="js/jquery.tipsy.js" type="text/javascript"></script>
                                                                                                                        <script type='text/javascript'>
                                                                                                                            $(function() {
                                                                                                                                $('#forgot_username_link').tipsy({
                                                                                                                                    gravity : 'w'
                                                                                                                                });
                                                                                                                            });
                                                                                                                        </script>
                                                                                                                        </body>
                                                                                                                        </html>
