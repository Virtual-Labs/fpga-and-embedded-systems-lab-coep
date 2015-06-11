<%-- 
    Document   : helloWorldSave
    Created on : 15 Dec, 2011, 11:17:43 AM
    Author     : root
--%>


<%@page import="JavaFiles.GenerateVerilogCode"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.PrintStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>




<%
    session = request.getSession();
    String ws = (String) session.getAttribute("workspace");
    String msg = (String) session.getAttribute("yourmsg");
    File fp = new File(constants.Constants.PATH + ws + "/" + "demo1.vl");
    FileOutputStream fos = null;
    PrintStream p = null;
    fos = new FileOutputStream(fp);
    p = new PrintStream(fos, true);

    String device = (String) session.getAttribute("device");

    new GenerateVerilogCode().generateHelloWorld(p, device, msg);

    session.setAttribute("loaded", "Program Loaded");
%>
