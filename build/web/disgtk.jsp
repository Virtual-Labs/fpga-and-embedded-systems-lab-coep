<%-- 
    Document   : disgtk
    Created on : 12 May, 2011, 2:12:25 PM
    Author     : root
--%>

<%@page import="javax.swing.ImageIcon"%>
<%@page import="com.sun.imageio.plugins.png.PNGImageWriter"%>
<%@page import="javax.imageio.ImageWriter"%>
<%@page import="javax.imageio.stream.FileImageInputStream"%>
<%@page import="javax.imageio.stream.ImageInputStreamImpl"%>
<%@page import="java.awt.Image"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.Rectangle"%>
<%@page import="java.awt.Robot"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.File"%>
<%@page contentType="image/gif" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>


    <%
System.out.print("dsfssssssffffffffffffffffffffffffffffffffffffffffffddddddddddd");
       String ws=(String)session.getAttribute("workspace");
    if(ws!=null){
       OutputStream o = response.getOutputStream();
    InputStream is = new FileInputStream(new File("/root/Temp/"+ws+"/saved.jpeg"));
    byte[] buf = new byte[32 * 1024];
    int nRead = 0;
    while( (nRead=is.read(buf)) != -1 ) {
        o.write(buf, 0, nRead);
    }

    


}
    %>

      
    </body>
</html>
