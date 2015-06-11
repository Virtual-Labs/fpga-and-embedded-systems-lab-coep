<%-- 
    Document   : reductionSave
    Created on : 14 Dec, 2011, 11:24:27 AM
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

    String data1 = (String) session.getAttribute("reddata");
    String operator = (String) session.getAttribute("redoperator");
    String device = (String) session.getAttribute("device");


    new GenerateVerilogCode().generateReductionOperation(p, data1, operator, device);

    session.setAttribute("loaded", "Program Loaded");
%>