<%-- 
    Document   : terminal
    Created on : 21 Jun, 2011, 12:18:37 PM
    Author     : root
--%>

<%@page import="java.io.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="extra.DbConnect"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">

            function execute(){
               
                document.getElementById('syntax').focus();
            }
        </script>
        <script type="text/javascript" src="jsTerminal/ajax.js"></script>
        <script type="text/javascript" src="jsTerminal/ajax-dynamic-list.js"></script>
        <LINK REL=StyleSheet HREF="suggestions.css" TYPE="text/css">
        <script type="text/javascript" src="ToolTipscript.js"></script>
        <link rel="stylesheet" type="text/css" href="style.css" />
        <link rel="stylesheet" type="text/css" href="phpterm.css" />
        <style type="text/css">
            #all
            {
                text-align:center;
                text-indent: inherit;
                background: #000;
                font-style: oblique;
                color: white;
            }


        </style>
    </head>
    <body onload="execute()" onclick="execute()" style="background-color: #000">
        <div id="all">
            <form name="f" action="terminal.jsp" method="post">
                <div align="left" id="outcommand">
                    <%
                        String str = (String) request.getParameter("command");
                        String ws = (String) session.getAttribute("workspace");
                        String ambiance = (String) session.getAttribute("ambiance");
                        if (ambiance == null) {
                            ambiance = "student";
                        }
                        if (str != null) {

                            System.out.println("Command typed:-" + str);
                            String[] compile = str.split(" ");
                            String output = null;
                            Connection connection = null;
                            try {
                                DbConnect db = new DbConnect();
                                connection = db.getConnect();
                                Statement st = connection.createStatement();
                                ResultSet rs = st.executeQuery("SELECT * FROM Commands where command='" + compile[0] + "';");

                                if (rs.next()) {


                                    Process p;
                                    //String[] cmd = new String[2];
                                    //			cmd[0]="cd";
                                    //			cmd[1]="Temp";
                                    //p = Runtime.getRuntime().exec(cmd);
                                    if (compile[0].equals("clear")) {
                                        session.setAttribute("terminalout", null);
                                    }

                                    if (compile[0].equals("./a.out")) {
                                        compile[0] = constants.Constants.PATH + ws + "/./a.out";
                                    }

                                    String tardone = (String) session.getAttribute("tardone");

                                    if (tardone != null) {
                                        if (tardone.equals("true")) {
                                            if (compile[0].equals("ls")) {
                                                compile = new String[2];
                                                compile[0] = "ls";
                                                compile[1] = "/root/Desktop/backup/apache-tomcat-7.0.16/bin/arm-linux-gcc";
                                            }
                                        }
                                    }

                                    if (compile[0].equals("./a.out")) {
                                        compile[0] = constants.Constants.PATH + ws + "/./a.out";
                                    }

                                    //if(compile[1]!=null)
                                    if (compile[0].equals("file")) {
                                        compile[1] = "/var/www/ARM_BOARD/" + compile[1];
                                    }

                                    p = Runtime.getRuntime().exec(compile);
                                    BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
                                    String line = "";
                                    //OutputStream os=new FileOutputStream("/home/pranav/Desktop/om/Report.txt");
                                    StringBuffer sb = new StringBuffer();
                                    while ((line = br.readLine()) != null) {
                                        System.out.println(line);
                                        sb.append(line + " <br>");
                                    }
                                    output = new String(sb);

                                    if (compile[0].equals("clear")) {
                                        session.setAttribute("terminalout", null);
                                        output = "";
                                    }

                                    if (compile[0].equals("tar") && output.contains("arm-linux-gcc/arm-linux-gdb")) {
                                        session.setAttribute("tardone", "true");
                                        System.out.print("................AS");
                                        session.setAttribute("ambiance", "arm-linux-ambiance");
                                        ambiance = (String) session.getAttribute("ambiance");
                                        output = "Uncompressing....................<br>................." + output + "<br>arm-linux-gcc Compiler Loaded Successfully.<br>Arm-Embedded Linux development environment has been set up.";
                                    } else {
                                        out.print(output);
                                    }
                                    if (compile[0].equals("clear")) {
                                        session.setAttribute("terminalout", null);
                                        output = "";
                                    }


                                    //br=new BufferedReader(new InputStreamReader(p.getErrorStream()));
                                    //while((line=br.readLine())!=null){
                                    //				System.out.println(line);
                                    //				sb.append(line+" <br>");
                                    //			}
                                    //		 output=new String(sb);
                                    if (compile[0].equals("clear")) {
                                        session.setAttribute("terminalout", null);
                                        output = "";
                                    }

                                    String appendedout = null;
                                    if (session.getAttribute("terminalout") != null) {
                                        appendedout = ((String) session.getAttribute("terminalout")) + " " + output;
                                        session.setAttribute("terminalout", appendedout);
                                        System.out.print(appendedout);
                                        out.print(appendedout);
                                    } else {
                                        out.print(output);
                                        session.setAttribute("terminalout", output);
                                    }
                                } ///////////////////
                                else if (str == "") {
                                    String appendedout = null;
                                    if (session.getAttribute("terminalout") != null) {
                                        appendedout = ((String) session.getAttribute("terminalout")) + " " + "<br>" + ambiance + "@coep-virtuallab:~#";

                                        session.setAttribute("terminalout", appendedout);
                                        System.out.print(appendedout);
                                        out.print(appendedout);
                                    } else {
                                        out.print("<br>" + ambiance + "@coep-virtuallab:~#");
                                        session.setAttribute("terminalout", "<br>" + ambiance + "@coep-virtuallab:~#");
                                    }

                                } else {
                                    String appendedout = null;
                                    if (session.getAttribute("terminalout") != null) {
                                        appendedout = ((String) session.getAttribute("terminalout")) + " " + "<br>You are not a authorized user to execute this privileged Command";
                                        session.setAttribute("terminalout", appendedout);
                                        System.out.print(appendedout);
                                        out.print(appendedout);
                                    } else {
                                        out.print("<br>You are not a authorized user to execute this privileged Command");
                                        session.setAttribute("terminalout", "<br>You are not a authorized user to execute this privileged Command");
                                    }

                                }
                                ///////////////////////
                            } catch (Exception e) {
                                e.printStackTrace();
                            }

                        }%>
                </div>
                <div align="left" id="prompt">
                    <%=ambiance%>@coep-virtuallab:~#<input type="text"  style="background-color: #000; color: white; border: #000" tabindex="1" size="20"  name="command" id="syntax" onkeyup="ajax_showOptions(this,'getCountriesByLetters',event)">

                </div>
            </form>
        </div>
    </body>
</html>
