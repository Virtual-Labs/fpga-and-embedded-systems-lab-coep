<%@page import="java.io.*"%>
<% 
String ws=(String)session.getAttribute("workspace");
//File file = new File("/root/Temp/"+ws+"/test.vcd");
try{
  // Open the file that is the first 
  // command line parameter
  FileInputStream fstream = new FileInputStream(constants.Constants.PATH+"27/test.vcd");
  // Get the object of DataInputStream
  DataInputStream in = new DataInputStream(fstream);
  BufferedReader br = new BufferedReader(new InputStreamReader(in));
  String strLine;
  //Read File Line By Line
StringBuffer sb=new StringBuffer();

  while ((strLine = br.readLine()) != null)   {
sb.append(strLine+"   "); 
       // Print the content on the console
    }
String final1=new String (sb);
String []vcd=final1.split("   "); 
sb=new StringBuffer();
for(int i=0;i<vcd.length;i++){
if(vcd[i].matches("#([0|1|2|3|4|5|6|7|8|9])+")){
sb.append(vcd[i]);
   System.out.println(vcd[i]);
}
}
final1=new String (sb);
String clk[]=final1.split("#");
for(int i=0;i<clk.length;i++){
//System.out.println(clk[i]);
}
int u=Integer.parseInt(clk[2].replace("#"," "));
int l=Integer.parseInt(clk[1].replace("#"," "));
out.println(u-l);

  //Close the input stream
  in.close();
    }catch (Exception e){//Catch exception if any
  System.err.println("Error: " + e.getMessage());
  }
%>