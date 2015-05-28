<%-- 
    Document   : shiftSave
    Created on : 12 Dec, 2011, 11:07:21 AM
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
    int len=Integer.parseInt(request.getParameter("length"));
    String dataType=request.getParameter("datatype");
    String shiftType=request.getParameter("shiftType");
    File fp = new File("/root/Temp/" + ws + "/" + "demo1.vl");
        FileOutputStream fos = null;
            PrintStream p = null;
            fos = new FileOutputStream(fp);
            p = new PrintStream(fos, true);
        
    String device = (String) session.getAttribute("device");
    String expr=(String)session.getAttribute("exprs");
    
    new GenerateVerilogCode().generateShiftOperations(p, device, expr, len, shiftType,dataType);
    
    /*session.removeAttribute("laxp");
    session.removeAttribute("laxm");
    session.removeAttribute("laxn");
    session.removeAttribute("laxmat1");
    session.removeAttribute("laxmat2");*/
    session.setAttribute("loaded", "Program Loaded");
%>
