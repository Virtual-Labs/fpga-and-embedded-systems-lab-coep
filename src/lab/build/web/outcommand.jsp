      <%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="extra.DbConnect"%>
<%@page import="java.io.*"%>
<%
String str=(String)request.getParameter("str");


System.out.println("file name:-"+str);
   String[] compile=str.split(" ");
String output=null;
Connection connection=null;
try
{
DbConnect db=new DbConnect();
        connection =db.getConnect();
        Statement st = connection.createStatement();
        ResultSet rs =st.executeQuery("SELECT * FROM Commands where command='"+compile[0]+"';");
        
if(rs.next()){


Process p;
    //String[] cmd = new String[2];
//			cmd[0]="cd";
//			cmd[1]="Temp";
//p = Runtime.getRuntime().exec(cmd);
 
    
p = Runtime.getRuntime().exec(compile);


			BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
			String line = "";
			//OutputStream os=new FileOutputStream("/home/pranav/Desktop/om/Report.txt");
			StringBuffer sb=new StringBuffer();
			while((line=br.readLine())!=null){
				System.out.println(line);
				sb.append(line+" <br>");
			}
		 output=new String(sb);

out.print(output);

br=new BufferedReader(new InputStreamReader(p.getErrorStream()));
while((line=br.readLine())!=null){
				System.out.println(line);
				sb.append(line+" <br>");
			}
		 output=new String(sb);
out.print(output);
}
        else{%>
        <h3>You are not a authorized user to execute this privileged Command</h3>
        <%}
}
catch (Exception e)
{        e.printStackTrace();}

   %>

<!--<span class='hotspot' onmouseover="tooltip.show('<strong>Simple verilog program which describs basic structure and syntax of module in Verilog</strong>');" onmouseout="tooltip.hide();">
    Program to Print "Hello world" </span> -->