<%@page import="extra.CountUsers"%>
<%
String ws=(String)session.getAttribute("workspace");
if(ws!=null){
     CountUsers c=new CountUsers();
String files[]=c.files(ws);
if(files.length==0){
    out.println("No Files in your workspace....");
}
else{
out.println("Files in your workspace: (You can work with these files later from the same machine)");
   
for(int i=0;i<files.length;i++){
out.println(" "+files[i]);
}
}
}
else{
out.print("You have to workspace created on the server!!! Workspace can be created by saving the file on server");
}
%>