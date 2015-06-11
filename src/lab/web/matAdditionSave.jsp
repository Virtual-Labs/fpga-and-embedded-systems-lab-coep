<%-- 
    Document   : matAdditionSave
    Created on : 1 Dec, 2011, 5:58:58 PM
    Author     : root
--%>

<%@page import="JavaFiles.GenerateVerilogCode"%>
<%@page import="java.io.PrintStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    session = request.getSession();
    String device = (String) session.getAttribute("device");
    PrintStream p = (PrintStream) session.getAttribute("laxp");
    int m = (Integer) session.getAttribute("laxm");
    int n = (Integer) session.getAttribute("laxn");
    int[][] mat1 = (int[][]) session.getAttribute("laxmat1");
    int[][] mat2 = (int[][]) session.getAttribute("laxmat2");
    System.out.println("fgfgfggfg");
    GenerateVerilogCode gvc = new GenerateVerilogCode();
    gvc.generateAlgoAddition(p, m, n, mat1, mat2, device);
    /*session.removeAttribute("laxp");
    session.removeAttribute("laxm");
    session.removeAttribute("laxn");
    session.removeAttribute("laxmat1");
    session.removeAttribute("laxmat2");*/
    session.setAttribute("loaded", "Program Loaded");
%>