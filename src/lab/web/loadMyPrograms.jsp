<%@page import="java.io.IOException"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%
String fname=(String)request.getParameter("mypro");
String ws=(String)session.getAttribute("workspace");
File file = new File(constants.Constants.PATH+ws+"/"+fname);
try{
FileInputStream fin = new FileInputStream(file);
byte fileContent[] = new byte[(int)file.length()];
fin.read(fileContent);
String strFileContent = new String(fileContent);
System.out.println("File content : ");
out.println(strFileContent.trim());
}
catch(FileNotFoundException e)
{
System.out.println("File not found" + e);
}
catch(IOException ioe)
{
System.out.println("Exception while reading the file " + ioe);
}
%>