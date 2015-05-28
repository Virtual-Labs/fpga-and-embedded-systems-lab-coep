<%-- 
    Document   : loadrules
    Created on : 1 Mar, 2011, 2:54:39 PM
    Author     : root
--%>

<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
                    String fname = (String) request.getParameter("FileName");
                    if (fname != null) {
                        try {
                            Integer i = 0;
                            FileInputStream fis = null;
                            BufferedInputStream bis = null;
                            DataInputStream dis = null;
                            fis = new FileInputStream("/root/Temp/" + fname + ".vl");

                            // Here BufferedInputStream is added for fast reading.
                            bis = new BufferedInputStream(fis);
                            dis = new DataInputStream(bis);

                            BufferedReader br = new BufferedReader(new InputStreamReader(dis));
                            String strLine;
                            StringBuffer sb = new StringBuffer();
                            //Read File Line By Line
                            while ((strLine = br.readLine()) != null) {
                                // Print the content on the console
                                sb.append(strLine);
                                
                            }
                            //Close the input stream
                            // dispose all the resources after using them.
                            fis.close();
                            bis.close();
                            dis.close();
                            strLine=new String(sb);

                            System.out.println("Loading indices");

                            if(strLine.indexOf("led<<")!=-1 && strLine.indexOf("led>>")!=-1){
                                out.print("SHIFTING=1,");
                            }
                            int start=strLine.charAt(strLine.indexOf("reg[")+6)-48;
                            int end=strLine.charAt(strLine.indexOf("reg[")+4)-48;
                                       if(start>=0 && end<8)
                                      for (i = start; i <= end; i++) {
                                          out.print("LED" + i + ",");
                                      }
                           System.out.println(".........start=" + start + "....end=" + end);
                            for (i = 0; i < 4; i++) {
                                if (strLine.contains("SW" + i)) {
                                    out.print("SW" + i + ",");
                                }
                            }
                            for (i = 0; i < 8; i++) {
                                if (strLine.contains("LED" + i)) {
                                    out.print("LED" + i + ",");
                                }
                            }
                            if (strLine.indexOf("i==") != -1) {
                                i = strLine.indexOf("i==") + 3;
                                char c = strLine.charAt(i);
                                out.print("DELAY=");
                                while (c != ')') {
                                    out.print(c);
                                    System.out.print(c);
                                    c = strLine.charAt(++i);
                                }
                            }
                        } catch (Exception e) {
                            System.out.print(e);
                        }
                    }


        %>

    </body>
</html>
