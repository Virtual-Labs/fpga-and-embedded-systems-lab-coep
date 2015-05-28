<%-- 
    Document   : syncSave
    Created on : 16 Dec, 2011, 11:48:45 AM
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

    File fp = new File("/root/Temp/" + ws + "/" + "demo1.vl");
    FileOutputStream fos = null;
    PrintStream p = null;
    fos = new FileOutputStream(fp);
    p = new PrintStream(fos, true);

    String device = (String) session.getAttribute("device");
    if (flipflop.equals("D Flip Flop")) {
        String data = (String) session.getAttribute("dataasync");
        //String answer = (String) session.getAttribute("answerasync");
        boolean checked = (Boolean) session.getAttribute("checkedasync");
        new GenerateVerilogCode().generateSyncDFlipFlop(p, device, checked, data);
    }
    if (flipflop.equals("T Flip Flop")) {
        String data = (String) session.getAttribute("dataasync");
        //String answer = (String) session.getAttribute("answerasync");
        boolean checked = (Boolean) session.getAttribute("checkedasync");
        new GenerateVerilogCode().generateSyncTFlipFlop(p, device, checked, data);
    }
    if (flipflop.equals("Counter")) {
        String counterType = (String) session.getAttribute("countertype");
        String bound = (String) session.getAttribute("bound");
                boolean enable = (Boolean) session.getAttribute("enabled");
        if (counterType.equals("Up Counter")) {
            new GenerateVerilogCode().generateSyncUpCounter(p, device, enable, bound);
        }
        if (counterType.equals("Down Counter")) {
           new GenerateVerilogCode().generateSyncDownCounter(p, device, enable, bound);
        }
    }
    session.setAttribute("loaded", "Program Loaded");
%>
