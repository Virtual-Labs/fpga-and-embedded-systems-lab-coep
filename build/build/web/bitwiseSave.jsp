<%-- 
    Document   : bitwiseSave
    Created on : 12 Dec, 2011, 3:57:42 PM
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
    File fp = new File("/root/Temp/" + ws + "/" + "demo1.vl");
    FileOutputStream fos = null;
    PrintStream p = null;
    fos = new FileOutputStream(fp);
    p = new PrintStream(fos, true);

    String device = (String) session.getAttribute("device");
    String data1 = (String) session.getAttribute("bitdata1");
    String data2 = (String) session.getAttribute("bitdata2");
    String operator = (String) session.getAttribute("bitop");
    new GenerateVerilogCode().generateBitwiseOperation(p, device, data1, data2, operator);

    session.setAttribute("loaded", "Program Loaded");
%>