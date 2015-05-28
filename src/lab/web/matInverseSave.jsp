<%-- 
    Document   : matInverseSave
    Created on : 7 Dec, 2011, 10:06:17 AM
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
    System.out.println("fgfgfggfg");
    String inverseType = (String) session.getAttribute("inversetype");
    if (inverseType.equals("LU Factorization")) {
        new GenerateVerilogCode().generateInverseAlgoLUFactorization(p, m, n, mat1, device);
    } else if (inverseType.equals("Gauss-Jordan Elimination")) {
        new GenerateVerilogCode().generateInverseAlgoGaussElimination(p, m, n, mat1, device);
    } else if (inverseType.equals("Cholesky Factorization")) {
        new GenerateVerilogCode().generateInverseAlgoCholeskyFactorization(p, m, n, mat1, device);
    }

//new GenerateVerilogCode().generateInverseAlgo(p, m, n, mat1, device);
/*session.removeAttribute("laxp");
    session.removeAttribute("laxm");
    session.removeAttribute("laxn");
    session.removeAttribute("laxmat1");
    session.removeAttribute("laxmat2");*/
    session.setAttribute("loaded", "Program Loaded");
%>