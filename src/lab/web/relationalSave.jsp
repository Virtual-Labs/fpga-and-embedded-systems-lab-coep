<%-- 
    Document   : relationalSave
    Created on : 13 Dec, 2011, 11:35:10 AM
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
    File fp = new File(constants.Constants.PATH + ws + "/" + "demo1.vl");
    FileOutputStream fos = null;
    PrintStream p = null;
    fos = new FileOutputStream(fp);
    p = new PrintStream(fos, true);

    String data1=request.getParameter("data1");
    String data2=request.getParameter("data2");
    String type1=request.getParameter("type1");
    String type2=request.getParameter("type2");
    String operator=request.getParameter("operator");
    String device = (String) session.getAttribute("device");
    
    new GenerateVerilogCode().generateRelationalOperation(p, data1, data2, type1, type2, operator, device);

    session.setAttribute("loaded", "Program Loaded");
%>