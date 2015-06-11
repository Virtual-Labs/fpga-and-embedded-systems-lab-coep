<%-- 
    Document   : loadTbMapping
    Created on : 20 May, 2011, 5:00:57 PM
    Author     : root
--%>

<%@page import="extra.TestBench"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <script type="text/javascript">
        function disableit(flag,selectname){
	   var selectname1;
          
          if(flag){
             selectname1="L"+selectname;
            document.getElementById(selectname1).removeAttribute("disabled");
            selectname1="M"+selectname;
            document.getElementById(selectname1).removeAttribute("disabled");
                }
                else{
                    selectname1="L"+selectname;
                    document.getElementById(selectname1).setAttribute("disabled",true);
            selectname1="M"+selectname;
            document.getElementById(selectname1).setAttribute("disabled",true);
                }
    }
        </script>
    <body>
        <h1>Test Bench Mapping</h1>
<%
String args[]=null;
String filename=(String)request.getParameter("FileName");
session.setAttribute("FileName",filename);
String ws=(String)session.getAttribute("workspace");
out.print("Test Bench Mapping for \""+filename+".vl\"");
//out.print("In load mapping......"+filename+ws);
if(filename!=null && ws!=null){ 
TestBench tb=new TestBench();
System.out.print(" Setting the content..");
tb.setContent(ws, filename);
args=tb.getArguments();
tb.setModule();
session.setAttribute("TestBench",tb);
//out.print("args="+args.length);
if(args==null ||args[0].trim().equals("")){ out.print("<br><h3> Test Bench can not generated for this program as there is no INPUT/OUTPUT arguments</h3>");
%>
<br><input type="button" value="Close This WIndow" onclick="window.close()">
        <%
}else{
%>
<form name="f1" action="generateTestBench.jsp" method="post">
    <br>

    <table border="1">
        <tr><td>Variable</td><td>Bus</td><td>Type</td><td>Data Width</td></tr>
        <%
if(args!=null)
        for(int i=0;i<args.length;i++){
%>
<tr><td><%=args[i]%></td><td><input type="checkbox"onclick="disableit(this.checked,'<%=args[i]%>')"/></td><td><select name="<%=args[i]%>"><option value=input>INPUT</option><option value=output>OUTPUT</option></select></td><td>MSB:<input type=text id='M<%=args[i]%>' name='MSB<%=args[i]%>' disabled size=4> LSB:<input type=text id='L<%=args[i]%>' name='LSB<%=args[i]%>' disabled size=4></td></tr>
<%
        }


        %>
</table>
<input type="submit">
<% }
}
%>
</form>

    </body>
</html>
