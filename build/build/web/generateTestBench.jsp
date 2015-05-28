<%-- 
    Document   : generateTestBench
    Created on : 20 May, 2011, 6:34:59 PM
    Author     : root
--%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="extra.TestBench"%>
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

TestBench tb=(TestBench)session.getAttribute("TestBench");
String args[]=tb.getArguments();
String type[]=new String[args.length];      
String msb[]=new String[args.length];
String lsb[]=new String[args.length];
for(int i=0;i<args.length;i++){
type[i]=(String)request.getParameter(args[i]);
msb[i]=(String)request.getParameter("MSB"+args[i]);
lsb[i]=(String)request.getParameter("LSB"+args[i]);
}
StringBuffer rawTB=new StringBuffer("module counter_tb;");

for(int i=0;i<args.length;i++){
if(type[i].equals("input")){
if(msb[i]!=null && lsb[i]!=null){ 
    rawTB.append(" reg ["+msb[i]+":"+lsb[i]+"] "+args[i]+";");
} else   rawTB.append(" reg "+args[i]+";");

}
else if(type[i].equals("output")){
if((msb[i]==null || msb[i].length()==0)|| (lsb[i]==null || lsb[i].length()==0) )
rawTB.append(" wire "+args[i]+";");
    else{
    rawTB.append(" wire ["+msb[i]+":"+lsb[i]+"] "+args[i]+";");}
}
}

StringBuffer call=new StringBuffer(" "+tb.getModule()+" inst1(");
for(int i=0;i<args.length;i++){
call.append("."+args[i]+"("+args[i]+")");
if(i!=(args.length-1))call.append(",");
}
rawTB.append(call);
rawTB.append(");");

rawTB.append(" initial begin ");

for(int i=0;i<args.length;i++){
if(type[i].equals("input"))rawTB.append(" "+args[i]+"=0;");
}
String nanoclk=(String)session.getAttribute("clk");
if(nanoclk==null){
nanoclk="20";
}
rawTB.append("end initial begin $dumpfile(\"test.vcd\"); $dumpvars; end  always #"+nanoclk+" clk=!clk; initial begin #600 $finish; end endmodule");

String tbstring=new String(rawTB);

out.print(tbstring);

String ws=(String)session.getAttribute("workspace");
String fname=(String)session.getAttribute("FileName");
try{
OutputStream os=new FileOutputStream("/root/Temp/"+ws+"/testbench.vl");
int i=0;
while(i<tbstring.length()){
os.write(tbstring.charAt(i));i++;}

}
catch(Exception e){
System.out.print(e);
}
request.getRequestDispatcher("tbEdit.jsp").forward(request,response);

/*
if(fname!=null && ws!=null){
    String[] compile=new String[5];
    compile[0]="iverilog";
    compile[1]="-o";
    compile[2]="/root/Temp/"+ws+"/"+fname;
    compile[3]="/root/Temp/"+ws+"/"+fname+".vl";
    compile[4]="/root/Temp/"+ws+"/testbench.vl";
Process p=Runtime.getRuntime().exec(compile);
out.print("<h1>Test Bench Generation Data is ready.."
+ "Click on 'Execute' to see the output and then click on Timing Analysis to view the waveform"
+ "</h1>");


        
} */
       %>
       <input type="button" value="Close This WIndow" onclick="window.close()">
    </body>
</html>
