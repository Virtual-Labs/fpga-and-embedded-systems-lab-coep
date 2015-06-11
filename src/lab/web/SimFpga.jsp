<%-- 
    Document   : SimFpga
    Created on : 25 Feb, 2011, 12:58:03 PM
    Author     : root
--%>

<%@page import="java.io.File"%>
<%@page import="extra.VerilogSyntaxPro"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="extra.DbConnect"%>
<%@page import="extra.CountUsers"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="SimFpgaError.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

    <head>
        <title>FPGA Simulator, College of Engineering, Pune (COEP)</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Theme code starts -->
        <link rel="shortcut icon" href="images/coep_logo.png" />
        <link type="text/css" href="jquery-ui-1.8.10.custom.css" rel="stylesheet"/>




        <script type="text/javascript" src="jquery-1.4.4.min.js">
        </script>
        <script type="text/javascript" src="jquery-ui-1.8.10.custom.min.js">
        </script>


        <%
            String changeCompileColor = (String) session.getAttribute("changeCompileColor");
            System.out.println("change compile color : " + changeCompileColor);
            String exp = (String) request.getParameter("expNo");
            System.out.println("Exp No : " + exp);
            String user = (String) request.getParameter("name");
            if (user == null || user.equals("")) {
                user = (String) session.getAttribute("name");
            } else {
                session.setAttribute("name", user);
            }
            if (exp == null || exp.equals("")) {
                exp = (String) session.getAttribute("expNo");
                if (exp == null) {
                    exp = "1";
                    session.setAttribute("expNo", "1");
                }
            } else if (Integer.parseInt(exp) > 11 || Integer.parseInt(exp) < 1) {
                //response.sendRedirect("SimFpga.jsp");
                //   exp = "1";
                //  session.setAttribute("expNo", "1");
                response.sendRedirect("redirectingToFirst.jsp");
            } else {
                session.setAttribute("expNo", exp);
            }
        %>
        <%String ws = null;
            ws = (String) session.getAttribute("workspace");
            String cookieName = "workspace";
            Cookie cookies[] = request.getCookies();
            Cookie myCookie = null;
            if (cookies != null) {
                for (int i = 0; i < cookies.length; i++) {
                    if (cookies[i].getName().equals(cookieName)) {
                        myCookie = cookies[i];
                        break;
                    }
                }
            }
            if (myCookie == null) {
                CountUsers c = new CountUsers();

                int ucount = c.count();
                Cookie cookie = new Cookie("workspace", Integer.toString(ucount));
                cookie.setMaxAge(365 * 24 * 60 * 60);
                response.addCookie(cookie);
                session.setAttribute("workspace", Integer.toString(ucount));
                ws = Integer.toString(ucount);
                boolean s = c.createdir(constants.Constants.PATH + ws);
                if (s == false) {
                    ws = "default";
                    session.setAttribute("workspace", ws);
                }
            } else {
                ws = myCookie.getValue();
                session.setAttribute("workspace", myCookie.getValue());
            }

            session.setAttribute("loaded", "Program not loaded");
        %>

        <script type="text/javascript"> 
            var kl=0; 
            $(document).ready(function() { 
    
                $('#tabs').tabs(); 

                //hover states on the static widgets
                $('#dialog_link, ul#icons li').hover(

                function() {
                    $(this).addClass('ui-state-hover');
                }, function() {
                    $(this).removeClass('ui-state-hover');
                });
            });
            
            
            function makelarge()
            {
                $("#laxtd").attr("class","laxclass1");
            }
            function makesmall()
            {
                $("#laxtd").attr("class","laxclass");
            }
            
            var scrl = " FPGA Simulator, College of Engineering, Pune (COEP).      ";
            function scrlsts() {
                scrl = scrl.substring(1, scrl.length) + scrl.substring(0, 1);
                document.title = scrl;
                setTimeout("scrlsts()", 200);
 
            }
			
        </script>
        <!-- Theme code ends -->
        <link type="text/css" rel="stylesheet" href="SimFPGAStyle.css" ><link rel="stylesheet" type="text/css" href="style.css" />
        <script type="text/javascript" src="SimFPGAAction.js">
        </script>
        <script type="text/javascript" src="ToolTipscript.js">
        </script>
        <style type="text/css">
            div.tabArea {
                font-size: 80%;
                font-weight: bold;
                height: 100%;
                width: 100%;
                vertical-align: text-top;

            }

            a.tab {
                background-color: #5970B2;
                border: 1px solid #000000;
                border-bottom-width: 0px;
                padding: 2px 1em 2px 1em;
                text-decoration: none;

            }

            a.tab, a.tab:visited {
                color: #FFFFFF;
            }

            a.tab:hover {
                background-color: #49A3FF;
                color: #FFFFFF;
            }
            a.tab.activeTab, a.tab.activeTab:hover, a.tab.activeTab:visited {
                background-color: #c0c0c0;
                color: #000000;
            }
            div.tabMain {
                background-color: #5970B2;
                border: 1px solid #000000;
                padding: 1em;

            }
            div.tabMain {
                background-color: #E2EBED;
                border: 1px solid #000000;
                padding: 1em;

            }

            div.tabIframeWrapper {

            }

            iframe.tabContent {
                background-color: #E2EBED;
                border: 1px solid #000000;
                width: 100%;
                height: 100%;
            }

            .logodiv{
                border: solid 2px black;
                /*   background-color: #6fe0f4;*/

            }
            .rndimg {
                border: solid 1px black;
                border-color: black;

                border-radius: 10px;
                -moz-border-radius: 10px;
                -webkit-border-radius: 10px;
                background-color: black;
            }
            .copyright{
                text-align: center;
                vertical-align: middle;
                font-size: xx-small;
                background: #49A3FF;
            }
            .headinglax{
                vertical-align: bottom;
                text-align: left;

            }
            .spdiv{
                border-left: 1px solid black;
                border-top : 1px solid black;
                border-right: 1px solid black;
                border-bottom: 1px transparent;
            }
            .laxclass{
                text-align: left; vertical-align: bottom; font-family:verdena; font-style: normal; color:#FF6633;font-size: x-large ;
            }
            .laxclass1{
                text-align: left; vertical-align: bottom; font-family:verdena; font-style: oblique; color:#FF6633;font-size: xx-large ;
            }
        </style>
        <script language="Javascript" type="text/javascript" src="edit_area/edit_area_full.js"></script>
        <script language="Javascript" type="text/javascript" >
            editAreaLoader.init({
                id: "prog"	// id of the textarea to transform
                ,start_highlight: true
                ,font_size: "8"
                ,font_family: "verdana, monospace"
                ,allow_resize: "y"
                ,allow_toggle: false
                ,language: "en"
                ,allow_toggle: true
                ,syntax: "css"
                ,toolbar: "search, go_to_line, |, undo, redo, |, select_font, |, change_smooth_selection, highlight, reset_highlight"
                ,load_callback: "my_load"
                ,save_callback: "my_save"
                ,plugins: "charmap"
                ,charmap_default: "arrows"
	
            });
            function doNothing()
            {
    
            }

            function loadingBody()
            {
                
                var expNo=document.getElementById('expnum').value;
                var compileColor = document.getElementById('com-color').value;
                if(compileColor == "change"){
                    $("#cmpl").attr("style","background-color: #6B8E23");
                    $("#animating").attr("style","background-color: #6B8E23");
                }
                
                //alert(expNo);
                if(document.getElementById('dvalue').value=="nodevice")
                {
            
                    // for cross compilation not done...........
                    if(expNo!="11" && (expNo!="12")){ //for 8,9 exp
                        
                        $("#devicelaxpl").attr("style","display : block");
                        //document.getElementById('ypgm').removeAttribute("onmouseover");
                        //        document.getElementById('ypgm').removeAttribute('onmouseout');
                        document.getElementById('cmpl').removeAttribute("onmouseover");
                        document.getElementById('exec').removeAttribute("onmouseover");
                        //document.getElementById('ccmpl').removeAttribute("onmouseover");
                        document.getElementById('lpgm').removeAttribute("onmouseover");
        
                        if(expNo=="9" || expNo=="2" || expNo=="1" || expNo=="5" || expNo=="3" || expNo=="6" || expNo == "8" || expNo == "4" || expNo == "10")//for specific experiments currently for 4,2,1,5,3,6,7
                        {
                            document.getElementById('animating').removeAttribute("href");
                            document.getElementById('tanalysis').removeAttribute("href");
                            document.getElementById('rutil').removeAttribute("href");
                            document.getElementById('animating').title="Select device first";
                            document.getElementById('tanalysis').title="Select device first";
                            document.getElementById('rutil').title="Select device first";
                         
                        }
                        if(expNo == "8"){
                            document.getElementById('animating').removeAttribute("href");
                            document.getElementById('floorPlan').removeAttribute("href");
                            document.getElementById('tanalysis').removeAttribute("href");
                            document.getElementById('rutil').removeAttribute("href");
                            document.getElementById('animating').title="Select device first";
                            document.getElementById('floorPlan').title="Select device first";
                            document.getElementById('tanalysis').title="Select device first";
                            document.getElementById('rutil').title="Select device first";
                        }
        
                        //document.getElementById('ypgm').title="Select device first";
                        document.getElementById('cmpl').title="Select device first";
                        document.getElementById('exec').title="Select device first";
                        // document.getElementById('ccmpl').title="Select device first";
                        document.getElementById('lpgm').title="Select device first";
                        alert("You must select device first...");
                        $("#select-device").attr("style","background-color: #6B8E23");
                    }//for 8 , 9 exp
                    else
                    {
                        $("#devicelaxpl").attr("style","display : none");
                    }
    
                }
                else
                {
                    if(expNo=="6" )//for specific experiments currently for 4
                    {
                        document.getElementById('liframe').src="animate.jsp";
                        document.getElementById('animating').setAttribute("href","animate.jsp");
                        document.getElementById('animating').title="Animated Matrix Input";
                    }
                   
                    if(expNo=="3" )//for specific experiments currently for 2
                    {
                        document.getElementById('liframe').src="animateexp2.jsp";
                        document.getElementById('animating').setAttribute("href","animateexp2.jsp");
                        document.getElementById('animating').title="Animated Verilog Operators Input";
                    }
                    if(expNo=="1" )//for specific experiments currently for 1
                    {
                        document.getElementById('liframe').src="animateexp1.jsp";
                        document.getElementById('animating').setAttribute("href","animateexp1.jsp");
                        document.getElementById('animating').title="Introduction to Verilog Programming Input";
                    }
                    
                    if(expNo=="7" )//for specific experiments currently for 5
                    {
                        document.getElementById('liframe').src="animateexp5.jsp";
                        document.getElementById('animating').setAttribute("href","animateexp5.jsp");
                        document.getElementById('animating').title="Animated Linear Equation Solver Input";
                    }
                    
                    if(expNo=="4" )//for specific experiments currently for 6
                    {
                        document.getElementById('liframe').src="animateexp6.jsp";
                        document.getElementById('animating').setAttribute("href","animateexp6.jsp");
                        document.getElementById('animating').title="Animated Floating Point Arithmetics Input";
                    }
                    
                    if(expNo=="9" )//for specific experiments currently for 3
                    {
                        document.getElementById('liframe').src="animateexp3.jsp";
                        document.getElementById('animating').setAttribute("href","animateexp3.jsp");
                        document.getElementById('animating').title="Animated Architectural Design Input";
                    }
                    
                    if(expNo == "10") // //for specific experiments currently for 10
                    {
                        document.getElementById('liframe').src="animateexp7new.jsp";
                        document.getElementById('animating').setAttribute("href","animateexp7new.jsp");
                        document.getElementById('animating').title="Animated Designing of reconfigurable architecture for PID controller Input";
                    }
                    
                    if(expNo == "8") // //for specific experiments currently for 10
                    {
                        document.getElementById('liframe').src="animateexp4.jsp";
                        document.getElementById('animating').setAttribute("href","animateexp4.jsp");
                        document.getElementById('animating').title="Animated Designing of Pulse-Width Modulation (PWM) Generation Using FPGA";
                    }
                    
                    if(expNo == "5") // //for specific experiments currently for 10
                    {
                        document.getElementById('liframe').src="animateexpLNS.jsp";
                        document.getElementById('animating').setAttribute("href","animateexpLNS.jsp");
                        document.getElementById('animating').title="Animated Designing of Logarithmic Number System (LNS) Based Arithmetic Operations";
                    }
                    if(expNo == "2") // //for specific experiments currently for 10
                    {
                        document.getElementById('liframe').src="animateExp2New.jsp";
                        document.getElementById('animating').setAttribute("href","animateExp2New.jsp");
                        document.getElementById('animating').title="Introduction to different verilog abstraction levels";
                    }
                }
                
                    
                scrlsts();
                init();
            }
            
            function submitMe()
            {
                // alert("hi");
                document.getElementById("formStyle").setAttribute("action","SaveAsOnClient");
                document.getElementById("formStyle").submit();
                document.getElementById("formStyle").setAttribute("action","SaveVerilog");
            }

        </script>

        <script type="text/javascript" src="js/ajax.js"></script>
        <script type="text/javascript" src="js/ajax-dynamic-list.js"></script>
        <LINK REL=StyleSheet HREF="suggestions.css" TYPE="text/css">
    </head>

    <body onload="loadingBody()"   >
        <!-- Theme code starts 
        <img class = "imag" src="images/coep_logo_sim.png">
            <div id="tabs">
                <ul>
                    <h1>
                   Embedded-FPGA Simulator
                    </h1>
                    <br><br>
                </ul>     
            </div>
     Theme code ends --> 
        <%
            String expHeading;
            if (exp.equals("11") || exp.equals("12")) {
                expHeading = "ARM-Linux Simulator";
            } else {
                expHeading = "FPGA-Verilog Simulator";
            }



        %>
        <!--<div id="SimHeading">Embedded-FPGA Simulator</div>-->
        <div>
            <table width="100%" class="logodiv"  >
                <tr>
                    <!--                    <td width="100%" align="left" >
                                            <img alt="COEP ICON" src="images/coep_logo_sim.png" height="70" />
                                        </td>-->
                    <!--                    <td width="20%">
                                            <img alt="COEP ICON" src="images/coep_logo.png" height="70"/>
                                        </td>-->
                    <td width="60%" >
                        <img alt="COEP ICON" src="images/coep_logo.png" height="70"/>
                        <img alt="COEP ICON" src="images/coep_name1.png" height="70"/>

                        <!--                        <div class="spdiv" >
                                                FPGA - Simulators
                                                </div>-->
                    </td>
                    <td width="20%" style="vertical-align: bottom" >
                        <table width="100%">
                            <tr>
                                <td height="50%">Login as: <%=user%></td>

                            </tr>
                            <tr>
                                <td id="laxtd" height="50%" class="laxclass" ><%= expHeading%> </td>
                            </tr>
                        </table>
                        <!--                        <img style="border: 1px solid black" alt="COEP ICON" src="images/fpgasimu.jpg" width="60" height="60"/>-->
                    </td>
                    <td width="10%">
                        <a href="Help.pdf" target="_blank" title="Help">
                            <img  style="border: 1px solid black;" alt="COEP ICON" src="images/help4.jpg" width="60" height=60"/>
                        </a>
                        <!--                        <table width="100%">
                                                    <tr>
                                                        <td height="50%">&nbsp;</td>
                        
                                                    </tr>
                                                    <tr>
                                                        <td id="laxtd" height="50%" class="laxclass" >FPGA-Simulator </td>
                                                    </tr>
                                                </table>-->
                    </td>
                    <td width="10%">
                        <!--a href="http://59.163.223.69:8080/vlabs/logout.htm" title="Logout"-->
                        <%
                            String dynhref = "";
                            switch (Integer.parseInt(exp)) {
                                case 1:
                                    dynhref = "http://coep.vlab.co.in/?sub=29&brch=88&sim=228&cnt=339";
                                    break;

                                case 3:
                                    dynhref = "http://coep.vlab.co.in/?sub=29&brch=88&sim=229&cnt=348";
                                    break;
                                case 4:
                                    dynhref = "http://coep.vlab.co.in/index.php?sub=29&brch=88&sim=500&cnt=4";
                                    break;
                                case 6:
                                    dynhref = "http://coep.vlab.co.in/index.php?sub=29&brch=88&sim=481&cnt=702";
                                    break;
                                case 7:
                                    dynhref = "http://coep.vlab.co.in/index.php?sub=29&brch=88&sim=482&cnt=711";
                                    break;
                                case 9:
                                    dynhref = "http://coep.vlab.co.in/index.php?sub=29&brch=88&sim=1036&cnt=4";
                                    break;
                                case 10:
                                    dynhref = "http://coep.vlab.co.in/index.php?sub=29&brch=88&sim=1312&cnt=4";
                                    break;
                                case 12:
                                    dynhref = "http://coep.vlab.co.in/index.php?sub=29&brch=88&sim=230&cnt=356";
                                    break;

                                case 13:
                                    dynhref = "http://coep.vlab.co.in/index.php?sub=29&brch=88&sim=478&cnt=796";
                                    break;

                                case 8:
                                    dynhref = "http://coep.vlab.co.in/?sub=29&brch=88&sim=1356&cnt=4";
                                    break;

                                case 5:
                                    dynhref = "http://coep.vlab.co.in/?sub=29&brch=88&sim=1353&cnt=4";
                                    break;
                                
                                case 2:
                                    dynhref = "http://coep.vlab.co.in/index.php?sub=29&brch=88&sim=1407&cnt=3003";
                                    break;
                            }

                        %>


                        <a href="LogoutUser.jsp?ref=<%=dynhref%>" title="Logout"> 
                            <img style="border: 1px solid black" alt="COEP ICON" src="images/logoutno.jpg" width="60" height="60"/> 
                        </a> 
                        <!--                        <table width="100%">
                                                    <tr>
                                                        <td height="50%">&nbsp;</td>
                        
                                                    </tr>
                                                    <tr>
                                                        <td id="laxtd" height="50%" class="laxclass" >FPGA-Simulator </td>
                                                    </tr>
                                                </table>-->
                    </td>

                </tr>
            </table>
        </div>
        <div id="SimSubHeading">
            <br/> Experiment No <%=exp%>:
            <input type="hidden" id="expnum" value="<%=exp%>"/>
            <input type="hidden" id="com-color" value="<%=changeCompileColor%>"/>
            <%
                if (exp != null) {
                    DbConnect db = new DbConnect();
                    ResultSet rs = db.getRs("SELECT Title FROM experiments WHERE expNo=" + exp);
                    while (rs.next()) {
                        out.print("" + rs.getString(1) + "");
                    }
                }
            %>
        </div>


        <ul id="sddm">
            <li><a href="#" onmouseover="mopen('m1')" onmouseout="mclosetime()">File</a>
                <div id="m1" onmouseover="mcancelclosetime()" onmouseout="mclosetime()">
                    <a href="#" onclick="callRefresh()">New</a>
                    <a href="#" onclick="submitMe()">SaveAs</a>
                    <!--<a href="#" onclick="callOpen()">Open</a>
                    <a href="#" onclick="callSaveAs()">Save As</a> -->
                    <a href="#" onclick="callExit()">Exit</a>
                </div>
            </li>
            <%
                if (exp != null && !exp.equals("3") && !exp.equals("1") && !exp.equals("2") && !exp.equals("8") && !exp.equals("5") && !exp.equals("6") && !exp.equals("9") && !exp.equals("7") && !exp.equals("4") && !exp.equals("10")) {
            %>
            <li><a href="#" onmouseover="mopen('m2')" onmouseout="mclosetime()">Sample Programs</a>
                <div id="m2" onmouseover="mcancelclosetime()" onmouseout="mclosetime()">
                    <%

                            DbConnect db = new DbConnect();
                            ResultSet rs = db.getRs("SELECT ID,Title,Description FROM Programs WHERE expNo=" + exp + " Order by id asc");
                            while (rs.next()) {
                                out.print("<a href='#' onclick=\"loadProg('" + rs.getString(1) + "','" + exp + "')\"><span class='hotspot' onmouseover=\"tooltip.show('<strong>" + rs.getString(3) + "</strong>');\" onmouseout=\"tooltip.hide();\">" + rs.getString(2) + "</span></a>");
                            }
                        }
                    %>


                    <!--
                    <a href="#" onclick="loadProg('Program2','<%=exp%>')">Program 2</a>
                    <a href="#" onclick="loadProg('Program3','<%=exp%>')">Program 3</a>
                    <a href="#" onclick="loadProg4()">Program 4</a>
                    <a href="#" onclick="loadProg5()">Program 5</a>
                    <a href="#" onclick="loadProg6()">Program 6</a>
                    <a href="#" onclick="loadProg7()">Program 7</a>
                    <a href="#" onclick="loadProg8()">Program 8</a>
                    <a href="#" onclick="loadProg9()">Program 9</a>
                    <a href="#" onclick="loadProg10()">Program 10</a>-->

                </div>
            </li> 

            <%if (exp.equals("1") || exp.equals("2") || exp.equals("3") || exp.equals("8") || exp.equals("5") || exp.equals("6") || exp.equals("9") || exp.equals("7") || exp.equals("4") || exp.equals("10")) {%>
            <!--  <li><a href="#" onmouseover="mopen('m3')" onmouseout="mclosetime()">Peripheral</a>
                  <div id="m3" onmouseover="mcancelclosetime()" onmouseout="mclosetime()">
                      <a href="#" onClick="open1()">LED Bank</a>
                      <a href="#" onClick="open2()">Switch Bank</a>
                      <a href="#" onClick="open3()">Expansion I/O</a>
                     
                  </div>
              </li>
            -->

            <li ><a href="#" id="select-device" onmouseover="mopen('m4')" onmouseout="mclosetime()">Device</a>
                <div id="m4" onmouseover="mcancelclosetime()" onmouseout="mclosetime()">
                    <a href="#" onClick="setDevice('Spartan 3E(XC3S500e-4fg320) @ 50 MHz','50')">Spartan 3E(XC3S500e-4fg320)</a>
                    <a href="#" onClick="setDevice('Spartan 3A(XC3SD1800A-4CS484) @ 100 MHz','100')">Spartan 3A(XC3SD1800A-4CS484)</a>
                    <a href="#" onClick="setDevice('Virtex 4(XC4VSx35-10ff668) @ 125 MHz','125')">Virtex 4(XC4VSx35-10ff668)</a>
                    <a href="#" onClick="setDevice('Virtex II(lvds) @ 100 MHz','100')">Virtex II(lvds)</a>
                    <a href="#" onClick="setDevice('Virtex 5(XC5VSX50t-1ff1136) @ 100 MHz','100')">Virtex 5(XC5VSX50t-1ff1136)</a>
                    <a href="#" onClick="setDevice('Spartan 6(XC6SLX45T-3FGG484)@ 200 MHz','200')">Spartan 6(XC6SLX45T-3FGG484)</a>
                </div>
            </li><%}%>
            <%if (!exp.equals("11") && !exp.equals("12")) {%>
            <li><a id="lpgm" href="#" onmouseover="mopen('mloadprog')" onmouseout="mclosetime()">Load Program</a>
                <div id="mloadprog" onmouseover="mcancelclosetime()" onmouseout="mclosetime()">
                    <!--                    <a href="#" >Load Program</a>-->
                    <a href="#" onclick="loadsavedprog()">Load Program</a>
                </div>
            </li> 
            <% }%>

            <!--            <li><a id="cmpl" href="#" onmouseover="mopen('m6')" onmouseout="mclosetime()">Compile</a>
                            <div id="m6" onmouseover="mcancelclosetime()" onmouseout="mclosetime()">
            <% if (exp.equals("11") || exp.equals("12")) {%>
            <a href="#" onclick="callCCompile()">Compile for x86</a>
            <a href="#" onclick="callCExecute()">Execute on x86</a>
            <% } else {%>
            <a href="#" onclick="callCompile()">Compile</a>
            <a href="#" onclick="callExecute()">Execute</a>
            <% }%>

        </div>
    </li>-->

            <% if (exp.equals("11") || exp.equals("12")) {%>
            <li><a id="cmpl" href="#" onmouseover="mopen('m6')" onmouseout="mclosetime()" >Compile for x86</a>
                <div id="m6" onmouseover="mcancelclosetime()" onmouseout="mclosetime()">
                    <a href="#" onclick="callCCompile()">Compile for x86</a>  
                </div>
            </li>
            <li><a id="exec" href="#" onmouseover="mopen('m22')" onmouseout="mclosetime()">Execute on x86</a>
                <div id="m22" onmouseover="mcancelclosetime()" onmouseout="mclosetime()">
                    <a href="#" onclick="callCExecute()">Execute on x86</a>  
                </div>
            </li>
            <% } else {%>
            <li><a id="cmpl" href="#" onmouseover="mopen('m6')" onmouseout="mclosetime()" >Compile</a>
                <div id="m6" onmouseover="mcancelclosetime()" onmouseout="mclosetime()">
                    <a href="#" onclick="callCompile()">Compile</a>  
                </div>
            </li>
            <li><a id="exec" href="#" onmouseover="mopen('m22')" onmouseout="mclosetime()">Execute</a>
                <div id="m22" onmouseover="mcancelclosetime()" onmouseout="mclosetime()">
                    <a href="#" onclick="callExecute()">Execute</a>  
                </div>
            </li>
            <% }%>

            <% if (exp.equals("12")) {%>
            <li><a id="ccmpl" href="#" onmouseover="mopen('m7')" onmouseout="mclosetime()">Cross Compile for ARM</a>
                <div id="m7" onmouseover="mcancelclosetime()" onmouseout="mclosetime()">
                    <a href="#" onclick="callCrossCompile()" > Compile for ARM </a>

                </div>
            </li>

            <li ><a id="ypgm" href="#" onmouseover="mopen('m5')" onmouseout="mclosetime()">Your Programs</a>
                <div id="m5" onmouseover="mcancelclosetime()" onmouseout="mclosetime()">
                    <%
                        if (ws != null) {
                            CountUsers c = new CountUsers();
                            String p[] = c.files(ws);
                            String temp = ".vl";
                            if (exp.equals("11") || exp.equals("12")) {
                                temp = ".c";
                            }
                            if (p != null) {
                                for (int j = 0; j < p.length; j++) {
                                    if (p[j].contains(temp)) {
                                        out.print("<a href='#' onClick=loadMyPrograms('" + p[j] + "')>" + p[j] + "</a>");
                                    }

                                }
                            }
                        }
                    %>
                </div>
            </li>
            <%}
            %>


            <!--            <li><a href="#" onmouseover="mopen('m8')" onmouseout="mclosetime()">Logout</a>
                            <div id="m8" onmouseover="mcancelclosetime()" onmouseout="mclosetime()">
                                <a href="http://coepvlab.ac.in:8080/vlabs/logout.htm" target="_blank">Logout</a>
            
                            </div>
                        </li>-->
            <!--            <li><a href="#" onmouseover="mopen('m9')" onmouseout="mclosetime()">Help</a>
                            <div id="m9" onmouseover="mcancelclosetime()" onmouseout="mclosetime()">
                                <a href="Help.pdf" target="_blank">Help Manual</a>
                                <a href="#">About</a>
                            </div>
                        </li>-->

        </ul>

        <div style="clear:both"></div>
        <table border="2" width="100%" height="20%">
            <tr >

                <td width="40%">
                    <div id="devicelaxpl">
                        <div id="device" style="font-size: 14; font-style: italic;color: #FF1DCE;">Device : <% String device = (String) session.getAttribute("device");
                            if (device != null) {
                                out.print(device);
                            }%></div></div>
                            <%
                                String lpk = "";
                                if (device == null) {
                                    lpk = "nodevice";
                                }
                            %>
                    <div id="bugs"><input type="hidden" id="dvalue" value="<%=lpk%>"/></div>
                    <% if (exp.equals("11") || exp.equals("12")) {%>C Language <% } else {%>Verilog <%}%>Syntax auto complete:<input type="text" size="10" id="syntax" onkeyup="ajax_showOptions(this,'getCountriesByLetters',event)">





                    <form name="F1" action="SaveVerilog" method="post" id="formStyle">

                        <fieldset>
                            <textarea name="program" cols="67" rows="18" id="prog">
                                <%
                                    session = request.getSession(true);

                                    if (session.getAttribute("SaveLog") != null && session.getAttribute("Program") != null) {
                                        out.print(session.getAttribute("Program"));
                                    }%>
                            </textarea></fieldset>
                        File name without extension:<input type="text" name="filename" size="8" id="Fname" value="<%
                            session = request.getSession(true);
                            /// if (session.getAttribute("SaveLog") != null && session.getAttribute("FileName") != null) {
                            //     out.print(session.getAttribute("FileName"));
                            // } else {
                            out.print("ExpNo" + exp);
                            // }
%>" readonly />
                        <input id="save-on-server" type="submit" value="Save on Server"/>




                    </form>
                </td>

                <td width="45%" align="left" valign="top" >


                    <div style="width: 100%">
                        <div class="tabArea" >
                            <% if (exp.equals("11")) {%>
                            <a id="linuxcmds" class="tab" href="linuxCommands.jsp" target="myIframe">List of Basic Linux Commands</a>

                            <a id="terminalbash" class="tab" href="terminal.jsp" target="myIframe">Bash Prompt for Executing Commands</a>
                            <% } else if (exp.equals("12")) {%>
                            <a id="armboardproc" class="tab" href="armBoardProcedure.jsp" target="myIframe">Instructions for Executing the Program on ARM-Board</a>

                            <a id="terminalid" class="tab" href="terminal.jsp" target="myIframe">Virtual ARM-Board Shell</a>
                            <% } else if (exp.equals("8")) {%>
                            <a id="animating" class="tab" onclick="changeColor(this)" href="animate.jsp" target="myIframe">Input</a>
                            <a id="floorPlan" class="tab" onclick="changeColor(this)" href="FloorPlan.jsp" target="myIframe">Floor Plan</a>
                            <a id="tanalysis" class="tab" onclick="changeColor(this)" href="WaveDrom2.jsp" target="myIframe">Timing Analysis</a>
                            <a id="rutil" class="tab" onclick="changeColor(this)" href="resourceutil.jsp" target="myIframe">Resource Utilization Report</a>
                            <% } else {%>
                            <%if (exp.equals("9") || exp.equals("3") || exp.equals("1") || exp.equals("6") || exp.equals("4") || exp.equals("7") || exp.equals("10") || exp.equals("5") || exp.equals("2")) {%>
                            <a id="animating" class="tab" onclick="changeColor(this)" href="animate.jsp" target="myIframe">Input</a><%}%>
                            <%if (exp.equals("7") || exp.equals("2") || exp.equals("1") || exp.equals("5") || exp.equals("3") || exp.equals("6") || exp.equals("4") || exp.equals("9")) {%>
                            <a id="tanalysis" class="tab" onclick="changeColor(this)" href="WaveDrom.jsp" target="myIframe">Timing Analysis</a><%}%>
                            <%if (exp.equals("10")) {%>
                            <a id="tanalysis" class="tab" onclick="changeColor(this)" href="WaveDrom1.jsp" target="myIframe">Timing Analysis</a><%}%>
                            <a id="rutil" class="tab" onclick="changeColor(this)" href="resourceutil.jsp" target="myIframe">Resource Utilization Report</a>
                            <% }%>
                        </div>
                        <div class="tabMain" style="width: 90%; height: 365px" >
                            <div class="tabIframeWrapper">
                                <iframe class="tabContent" id="liframe" name="myIframe" frameborder="0" width="90%" height="100%"   scrolling="yes"></iframe>
                            </div>
                        </div>
                    </div>


                </td>
            </tr>

        </table>


        <table border="0" width="100%"  height="30">
            <tr valign="top">
                <td  width="100%" height="100%" border="2"><h3>Output</h3></td>
            </tr>

            <tr >
                <td width="100%" >
                    <div id="output"><h3>
                            <pre>  <%
                                session = request.getSession(true);
                                if (session.getAttribute("SaveLog") != null) {
                                    out.print(session.getAttribute("SaveLog"));
                                }
                                %> </pre><br/>
                        </h3>   </div>
                </td> </tr>
            <tr>
                <td width="100%" align="center" >
                    <div id="copyrightsa" class="copyright">
                        Copyright &copy; 2011 Department of Instrumentation & Control, COEP. All Rights Reserved.

                    </div>
                </td>
            </tr>
        </table>
        <div id="sworks1" align="right">

            <%  if (ws != null) {
            %>
            <h4> Your workspace :<a id="sworks" href="#" onclick="showWorkspace()" >FPGA<%=ws%></a> </h4>
            <% }%>
        </div>

        <!-- Theme code starts                  
                <div class="art-footer">
        <div class="art-footer-t"></div>
        <div class="art-footer-l"></div>
        <div class="art-footer-b"></div>
        <div class="art-footer-r"></div>
        <div class="art-footer-body">
                <a href="#" class="art-rss-tag-icon" title="RSS"></a>
                <a href="#" class="art-rss-feedback-icon" title="RSS"></a>
                <div class="art-footer-text">
                <p><a href="#">Link1</a> | <a href="#">Link2</a> | <a href="#">Link3</a></p><p>Copyright @ 2011. All Rights Reserved.</p>
                </div>
                </div>
                </div>
         Theme code ends -->
    </body>
    <script type="text/javascript">
        function changeColor(laxm){
            $("#animating").attr("style","color: white");
            $("#tanalysis").attr("style","color: white");
            $("#rutil").attr("style","color: white");
            $("#floorPlan").attr("style","color: white");
            $(laxm).attr("style","background-color: #8A795D");
            $("#animating").attr("style","background-color: #6B8E23");
        }
        
        function getColor()
        {
            $("#animating").attr("style","color: red");
        }
    </script>


</html>