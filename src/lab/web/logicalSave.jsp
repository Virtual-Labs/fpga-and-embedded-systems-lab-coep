<%-- 
    Document   : logicalSave
    Created on : 13 Dec, 2011, 2:43:14 PM
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

    String data1 = (String) session.getAttribute("logdata1");
    String data2 = (String) session.getAttribute("logdata2");
    String device = (String) session.getAttribute("device");

    String logop = (String) session.getAttribute("logop");
    String logdtype1 = (String) session.getAttribute("logdtype1");
    String logdtype2 = (String) session.getAttribute("logdtype2");

    new GenerateVerilogCode().generateLogicalOperation(p, data1, data2, logop, logdtype1, logdtype2, device);

    session.setAttribute("loaded", "Program Loaded");
%>