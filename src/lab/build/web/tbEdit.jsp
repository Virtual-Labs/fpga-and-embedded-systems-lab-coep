<%-- 
    Document   : tbEdit
    Created on : 18 Jul, 2011, 7:27:18 PM
    Author     : root
--%>

<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    <script language="Javascript" type="text/javascript" src="edit_area/edit_area_full.js"></script>
         <script language="Javascript" type="text/javascript" >
           editAreaLoader.init({
                         id: "prog"	// id of the textarea to transform
			,start_highlight: true
			,font_size: "8"
			,font_family: "verdana, monospace"
			,allow_resize: "y"
			,allow_toggle: false
			,language: "en"
               
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
        <h1> 
        Test Bench
        </h1>
                    <% 
String filename=(String)session.getAttribute("FileName");            
out.print("Test Bench for \""+filename+".vl :\" ");%>
        <form action="tbEdit1.jsp" method="post">

            <textarea rows="20" cols="40" name="tb" id="prog">
<% 
String ws=(String)session.getAttribute("workspace");
File file = new File("/root/Temp/"+ws+"/testbench.vl");
try{
FileInputStream fin = new FileInputStream(file);
byte fileContent[] = new byte[(int)file.length()];
fin.read(fileContent);
String strFileContent = new String(fileContent);
//out.print(strFileContent);
strFileContent=strFileContent.replaceAll(";", ";  ");
String []t=strFileContent.split("  ");
for(int i=0;i<t.length;i++){
out.println(t[i]);
}
System.out.println("File content : "+strFileContent.trim());
     
}catch(FileNotFoundException e){
System.out.println("File not found" + e);
}
catch(IOException ioe){
System.out.println("Exception while reading the file " + ioe);
}
%>
            </textarea>
            <input type="submit" value="Submit Test Bench"/>            
        </form>
            <br><b>Note:</b> You can edit this auto generated Test Bench.<br> Test bench renders the signal behavior into Timing Diagram.<br>
    You can see your changes reflected in the timing diagram such as input initialization,setting the delay and clocks etc.
    </body>
</html>
