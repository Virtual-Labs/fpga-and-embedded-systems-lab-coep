<%-- 
    Document   : tbEdit1
    Created on : 18 Jul, 2011, 7:31:01 PM
    Author     : root
--%>

<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <%
        String ws=(String)session.getAttribute("workspace");
String fname=(String)session.getAttribute("FileName");
String tbstring=(String)request.getParameter("tb");
try{
OutputStream os=new FileOutputStream(constants.Constants.PATH+ws+"/testbench.vl");
int i=0;
while(i<tbstring.length()){
os.write(tbstring.charAt(i));i++;}
os.close();
}
catch(Exception e){
System.out.print(e);
}

//out.println(fname+" "+ws);

if(fname!=null && ws!=null){ /// 
    
    String[] compile=new String[5];
    compile[0]="iverilog";
    compile[1]="-o";
    compile[2]=constants.Constants.PATH+ws+"/"+fname;
    compile[3]=constants.Constants.PATH+ws+"/"+fname+".vl";
    compile[4]=constants.Constants.PATH+ws+"/testbench.vl";
Process p=Runtime.getRuntime().exec(compile);
out.print("<h1>Test Bench Generation Data is ready.."
+ "Click on 'Execute' to see the output and then click on Timing Analysis to view the waveform"
+ "</h1>");
%>

        <%
}

       %>
    <input type="button" value="Close This WIndow" onclick="window.close()">
    </body>
</html>
