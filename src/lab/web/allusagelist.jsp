<%@ page language="java" import="java.util.*" contentType= "json ; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
    
    
    <%
    response.getWriter().println(request.getAttribute("usageReportList").toString());
	
%>

