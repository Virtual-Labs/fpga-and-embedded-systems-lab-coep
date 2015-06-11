<%-- 
    Document   : gtkSimulation
    Created on : 12 May, 2011, 9:31:43 AM
    Author     : root
--%>

<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Test Bench Generation</title>
<script type="text/javascript" src="gtkSimul.js">
        </script>
    </head>
    <body>
        <h4>Timing analysis:</h4>
        <div id="files">            
        </div>
         <%
       String ws=(String)session.getAttribute("workspace");
       File dir = new File(constants.Constants.PATH+ws+"");
String[] children = dir.list();
int f=0;
if(children!=null)
for(int i=0;i<children.length;i++)
if(children[i].contains("vcd")){
    out.println("Test Bench generation data is ready for the simulation:"); f=1;
}

if(f==0){ out.print("Test Bench Generation data is not ready!!!");
}
%>
        <% 
if(f==1){
%>

        <form action="displayGtk.jsp" onsubmit= "document.getElementById('divMess').style.display = 'block'; return true;">
Select Zoom Level: <select name="zoom">
	
	<option value=3 selected>3</option>
	
		
		</select>
        <input type="submit" Value="Simulate the timing wave"/>
        <!--
        onclick="window.open
('http://59.163.223.71:8089/FPGAExp1/displayGtk.jsp','window','width=400,height=200')"
        -->
      </form>  
<% 
}
%>
<div id="divMess" style="display:none"><h4 style="background-color:aqua"> Please wait while the server process your request</h4></div>
    
<br>
<a href="WaveDrom.jsp"> View New Timing Analysis (under developing)</a>
    </body>
</html>
