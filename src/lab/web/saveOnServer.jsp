<%-- 
    Document   : newjspsaveOnServer
    Created on : 6 Dec, 2011, 4:47:47 PM
    Author     : root
--%>

<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
//not of use


String ws="";


ws=(String)session.getAttribute("workspace"); 
//////////////////////////////////////////////////////////
String exp=(String)session.getAttribute("expNo");
String fname=(String)request.getParameter("fname");
OutputStream os=null;
if(fname!=null && ws!=null)
try{
    if(exp.equals("7") ||exp.equals("8")||exp.equals("9") ){os = new FileOutputStream(constants.Constants.PATH + ws + "/" + fname + ".c");
     session.setAttribute("SaveLog","<h3>File is saved on the server with name '"+fname+".c' in your Worksapce,\n You can work with this file onwards even in other session. </h3><br/>");
    } else{
        os = new FileOutputStream(constants.Constants.PATH + ws + "/" + fname + ".vl");
    session.setAttribute("SaveLog","<h3>File is saved on the server with name '"+fname+".vl' in your Worksapce,\n You can work with this file onwards even in other session. </h3><br/>");
//VerilogSyntaxPro vsp=new VerilogSyntaxPro();
//vsp.setContent(ws, fname);
//if(vsp.checkModule()!=null){
//session.setAttribute("bugs",vsp.checkModule());
//}

    }

}
catch(Exception e){
System.out.print(e);
}

%>
