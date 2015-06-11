<%-- 
    Document   : readVcd
    Created on : 12 May, 2011, 9:50:17 AM
    Author     : root
--%>

<%@page import="java.io.File"%>
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
       String ws=(String)session.getAttribute("workspace");
       File dir = new File(constants.Constants.PATH+ws+"");
String[] children = dir.list();
int f=0;
for(int i=0;i<children.length;i++)
if(children[i].contains("vcd")){
    out.println("Test Bench generation data is ready for the simulation:"); f=1;
session.setAttribute("flag_tb", Boolean.TRUE);
}

if(f==0){ out.print("Test Bench Generation data is not ready!!!");
session.setAttribute("flag_tb",Boolean.FALSE);
}
%>

    </body>
</html>
