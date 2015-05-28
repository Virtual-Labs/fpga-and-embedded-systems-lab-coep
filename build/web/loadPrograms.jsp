<%-- 
    Document   : loadPrograms
    Created on : 29 Nov, 2011, 3:53:10 PM
    Author     : root
--%>

<%@page import="java.io.File"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // String fpath=request.getParameter("mypro");
    // System.out.println(fpath);
    String filecontent = new String();
    String ws = (String) session.getAttribute("workspace");
    File fp = new File("/root/Temp/" + ws + "/" + "demo1.vl");
    FileInputStream fis = new FileInputStream(fp);
    DataInputStream dis = new DataInputStream(fis);
    while (dis.available() != 0) {
        out.println(dis.readLine());
    }
%>
