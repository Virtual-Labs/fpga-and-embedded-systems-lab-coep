<%-- 
    Document   : approvalPortal
    Created on : 24 Aug, 2011, 5:04:00 PM
    Author     : root
--%>

<%@page import="extra.CountUsers"%>
<%@page import="extra.DbConnect"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
      <script  type="text/javascript" src="edit_area/edit_area_full.js"></script>
         <script  type="text/javascript" >
           editAreaLoader.init({
                         id: "program"	// id of the textarea to transform
			,start_highlight: true
			,font_size: "8"
			,font_family: "verdana, monospace"
			,allow_resize: "y"
			,allow_toggle: false
			,language: "en"
                        ,allow_toggle: true
			,syntax: "css"
			,toolbar: "search, go_to_line, |, undo, redo, |, select_font, |, change_smooth_selection, highlight, reset_highlight"
			,load_callback: "my_load"
			,save_callback: "my_save"
			,plugins: "charmap"
			,charmap_default: "arrows"
	
});

        </script>
    </head>
    <body>
        <% 
String key=(String)request.getParameter("key");  
if(key==null){
%>
<h1 style="background: #D6E1FE">Welcome to contribute request approval portal of College of Engineering,Pune.</h1>
<br></br>
<br/><br/>
    <center>
        <form method="post">
            Enter the key:<input type="password" name="key">
            <input type="submit" value="Enter into portal"/>
                
        </form>
        
    </center>

        <%
}
else
//if(key.equals("59.163.223.71")){     
    if(key.equals("59.163.223.69")){    
%>
 <h1>Sir, Welcome to contribute request approval portal of College of Engineering, Pune. </h1>
<br></br>
<br/><br/> 
<% 
String id=(String)request.getParameter("id");
Connection conn=null;
DbConnect a=new DbConnect();
conn=(Connection)a.getConnect();
Statement stmt = null;
ResultSet rs = null;
stmt=conn.createStatement();
rs=stmt.executeQuery("Select name,email,institute,contact,filecontri,description ,title from VirtualLab.ContributeRequests where ID="+id);
rs.next();    
CountUsers cu=new CountUsers();
String content=cu.getContent(rs.getString("filecontri"));
%>
<b>Approval Request Details:</b>
<table>
    
<tr><td></td></tr>
<tr><td>Name</td><td><%=rs.getString("name")%></td></tr> 
<tr><td>Email</td><td><%=rs.getString("email")%></td></tr>
<tr><td>Institute</td><td><%=rs.getString("institute")%></td></tr>
<tr><td>Contact</td><td><%=rs.getString("contact")%></td></tr>
<tr><td>Program content:</td><td><textarea name="program" id="program" rows="25" cols="40"><%=content%></textarea></td></tr>
<tr><td>Title</td><td><textarea name="title" rows="5" cols="40"><%=rs.getString("title")%></textarea></td></tr>
<tr><td>Description</td><td><textarea name="description" rows="5" cols="40"><%=rs.getString("description")%></textarea></td></tr>
<tr><td>Select the Experiment Number in which you want to allocate the program</td><td>
        <select name="expNo">
            <option value="1">1</option>
             <option value="1">2</option>
              <option value="1">3</option>
               <option value="1">4</option>
                <option value="1">5</option>
        </select>
        
    </td></tr>
<tr><td><input type="submit" value="Approve"></input></td><td><input type="submit" value="Reject"></input></td></tr>
</table>

<% }else{
%>
<h1>You are not authorized to view this page. </h1>
<%
}%></body>
</html>
