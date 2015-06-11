<%--
    Document   : executevl
    Created on : 25 Feb, 2011, 4:38:07 PM
    Author     : root
--%>

<%@page import="java.io.File"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
      <%
String fname=(String)request.getParameter("FileName");
   String ws=(String)session.getAttribute("workspace");
   session.setAttribute("FileName",fname);
System.out.println("file name:-"+fname);
String output=null;
Process p;
if (fname!=null && ws!=null){
    //String[] cmd = new String[2];
//			cmd[0]="cd";
//			cmd[1]="Temp";
//p = Runtime.getRuntime().exec(cmd);
    String[] compile=new String[1];
    compile[0]="./a.out";

p = Runtime.getRuntime().exec(compile,null,new File(constants.Constants.PATH+ws));


			BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
			String line = "";
			//OutputStream os=new FileOutputStream("/home/pranav/Desktop/om/Report.txt");
			StringBuffer sb=new StringBuffer();
			while((line=br.readLine())!=null){
				System.out.println(line);
				sb.append(line+" &nbsp; \n");
			}
		 output=new String(sb);

System.out.print("output recorded"+output);

}
   %>
        <h3>File "<%=ws%>/<%=fname%>.c" is executed on server and the output is:<br/> <%=output%></h3>
</html>
