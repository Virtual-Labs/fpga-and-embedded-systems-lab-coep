<%-- 
    Document   : asyncSave
    Created on : 15 Dec, 2011, 4:19:04 PM
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
    String flipflop = (String) session.getAttribute("flipfloptasync");
    String data = (String) session.getAttribute("dataasync");
    //String answer = (String) session.getAttribute("answerasync");
    boolean checked = (Boolean) session.getAttribute("checkedasync");
    File fp = new File("/root/Temp/" + ws + "/" + "demo1.vl");
    FileOutputStream fos = null;
    PrintStream p = null;
    fos = new FileOutputStream(fp);
    p = new PrintStream(fos, true);

    String device = (String) session.getAttribute("device");
    if (flipflop.equals("D Flip Flop")) {
        new GenerateVerilogCode().generateAsyncDFlipFlop(p, device, checked, data);
    }
    if (flipflop.equals("T Flip Flop")) {
        new GenerateVerilogCode().generateAsyncTFlipFlop(p, device, checked, data);
    }
    session.setAttribute("loaded", "Program Loaded");
%>
