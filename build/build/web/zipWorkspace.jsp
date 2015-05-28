<%-- 
    Document   : zipWorkspace
    Created on : 28 Jun, 2011, 11:13:27 AM
    Author     : root
--%>

<%@page import="java.util.zip.ZipEntry"%>
<%@page import="java.util.zip.ZipOutputStream"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        String ws=(String)session.getAttribute("workspace");
        File outFolder=new File("/root/Temp/zip/workspace"+ws+".zip");
 ZipOutputStream out1 = new ZipOutputStream(new
BufferedOutputStream(new FileOutputStream(outFolder)));
        if(ws!=null){
        
            try{
 File inFolder=new File("/root/Temp/"+ws);
   
 BufferedInputStream in = null;
 byte[] data  = new byte[1000];
 String files[] = inFolder.list();
 for (int i=0; i<files.length; i++)
  {
  in = new BufferedInputStream(new FileInputStream
(inFolder.getPath() + "/" + files[i]), 1000);
out1.putNextEntry(new ZipEntry(files[i]));
  int count;
  while((count = in.read(data,0,1000)) != -1)
  {
 out1.write(data, 0, count);
  }
  out1.closeEntry();
  }
  out1.flush();
  out1.close();
  }
  catch(Exception e)
 {
  e.printStackTrace();
  } %>


<% try {
   String filename = "/root/Temp/zip/workspace"+ws+".zip";

   // set the http content type to "APPLICATION/OCTET-STREAM
         response.setContentType("application/zip");
BufferedInputStream buf=null;
  
   String disHeader = "attachment; filename=workspace"+ws+".zip";
   response.setHeader("Content-Disposition", disHeader);
    
                      
     FileInputStream in = new FileInputStream(filename);
     byte buf2[] = new byte[2048];
     int len;
     while ((len = in.read(buf2)) > 0) {
      out.write(buf2, 0, len);
     }
      out.closeEntry();
      in.close();
                        
    }catch(Exception e) // file IO errors
   {
   e.printStackTrace();
}

           
       
        }%>


    </body>
</html>
