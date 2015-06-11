<%-- 
    Document   : arithSave
    Created on : 8 Dec, 2011, 4:57:31 PM
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

    String device = (String) session.getAttribute("device");
    String expr[] = (String[]) session.getAttribute("arithans");

    new GenerateVerilogCode().generatearithmeticalOperation(p, device, expr);

    /*session.removeAttribute("laxp");
    session.removeAttribute("laxm");
    session.removeAttribute("laxn");
    session.removeAttribute("laxmat1");
    session.removeAttribute("laxmat2");*/
    session.setAttribute("loaded", "Program Loaded");
%>


