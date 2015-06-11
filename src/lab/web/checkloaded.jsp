<%-- 
    Document   : checkloaded
    Created on : 2 Dec, 2011, 12:07:36 PM
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    if ((String) session.getAttribute("workspace") == null) {
        out.write("Your Session has been expired...Please Login Again");
    } else {
        out.write(session.getAttribute("loaded").toString());
    }%>
