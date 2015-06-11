<%@page import="java.io.File"%>
<%@page import="extra.TestBench"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
   <%
String fname=(String)request.getParameter("FileName");


System.out.println("file name:-"+fname);
String output=null;
Process p;
 String ws=(String)session.getAttribute("workspace");
if (fname!=null ){
    //String[] cmd = new String[2];
//			cmd[0]="cd";
//			cmd[1]="Temp";
//p = Runtime.getRuntime().exec(cmd); arm-none-linux-gnueabi-gcc -o testfile-arm test.c
    String[] compile=new String[4];
    compile[0]="/opt/cross-compiler/usr/local/arm/4.3.2/bin/arm-none-linux-gnueabi-gcc";
    compile[1]="-o";
    compile[2]="/var/www/ARM_BOARD/"+fname+"arm";
    compile[3]=constants.Constants.PATH+ws+"/"+fname+".c";
      //System.out.println(command);null,new File("/root/Temp/"+ws)*/
p = Runtime.getRuntime().exec(compile);
			BufferedReader br = new BufferedReader(new InputStreamReader(p.getErrorStream()));
			String line = "";
			//OutputStream os=new FileOutputStream("/home/pranav/Desktop/om/Report.txt");
			StringBuffer sb=new StringBuffer();
			while((line=br.readLine())!=null){
				//System.out.println(line);
				sb.append(line+" &nbsp; \n");
			}
		 output=new String(sb);
System.out.print("output recorded "+output.length());




}

session.setAttribute("FileName",fname);
   %>
        File "<%=fname%>.c" is compiled on server :
        <%if(output.length()==0){ %>
          Compiled successfully with 0 errors

   <% }else { %>
   <%=output%>
   <%} %>

