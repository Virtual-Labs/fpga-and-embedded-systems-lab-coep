<%-- 
    Document   : matMultiSave
    Created on : 2 Dec, 2011, 11:04:34 AM
    Author     : root
--%>

<%@page import="JavaFiles.GenerateVerilogCode"%>
<%@page import="java.io.PrintStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
session =request.getSession();
String device=(String)session.getAttribute("device");
PrintStream p=(PrintStream)session.getAttribute("laxp");
int m=(Integer)session.getAttribute("laxm");
int n=(Integer)session.getAttribute("laxn");
int x=(Integer)session.getAttribute("laxx");
int y=(Integer)session.getAttribute("laxy");
int[][] mat1=(int[][])session.getAttribute("laxmat1");
int[][] mat2=(int[][])session.getAttribute("laxmat2");
System.out.println("fgfgfggfg");
GenerateVerilogCode gvc=new GenerateVerilogCode();
gvc.generateAlgoMultiplication(p, m, n, x, y, mat1, mat2,device);
/*session.removeAttribute("laxp");
session.removeAttribute("laxm");
session.removeAttribute("laxn");
session.removeAttribute("laxx");
session.removeAttribute("laxy");
session.removeAttribute("laxmat1");
session.removeAttribute("laxmat2");*/
session.setAttribute("loaded", "Program Loaded");
%>