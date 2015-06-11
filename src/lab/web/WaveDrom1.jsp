

<%@page import="JavaFiles.Calculations"%>
<%@page import="java.util.Vector"%>
<%@page import="extra.TestBench"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Set"%>
<%@page import="extra.VcdParse"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="shortcut icon" href="images/favicon.ico"/> 
        <script src="scripts/html5slider.js"></script>
        
        <script type="text/javascript" src="scripts/jquery.js"></script>
        <script type="text/javascript" src="scripts/jquery-ui.js"></script>
        <script src="highcharts.js"></script>
        <script src="exporting.js"></script>
        
	<script type="text/javascript" src="WaveDrom.js"></script> 
        <script type="text/javascript" src="WaveDromEditor.js"></script>
    </head>
   <% 
   String ws=(String)session.getAttribute("workspace");File dir = new File(constants.Constants.PATH+ws+"");
String[] children = dir.list();int f=0;
if(children!=null)for(int i=0;i<children.length;i++)
if(children[i].contains("vcd")){f=1;}
if(f==1){ 


   /*
   String et=(String)request.getParameter("limit");
String fname=(String)session.getAttribute("FileName");
TestBench tb=new TestBench();
String tbcontent=null;
if(et!=null){
tb.setContent(ws,"testbench");
tbcontent=tb.getStrFileContent();
out.print(tbcontent); 
tbcontent=tbcontent.replaceAll("initial(\\s+)begin(\\s+)#(\\s?)(\\d+)","initial begin #"+et+" ");
out.print(tbcontent);
String tbstring=tbcontent;
try{
OutputStream os=new FileOutputStream("/root/Temp/"+ws+"/testbench.vl");
int i=0;
while(i<tbstring.length()){
os.write(tbstring.charAt(i));i++;}
os.close();
}
catch(Exception e){
System.out.print(e);
}
if(fname!=null && ws!=null){ ///     
    String[] compile=new String[5];
    compile[0]="iverilog";
    compile[1]="-o";
    compile[2]="/root/Temp/"+ws+"/"+fname;
    compile[3]="/root/Temp/"+ws+"/"+fname+".vl";
    compile[4]="/root/Temp/"+ws+"/testbench.vl";
Process p=Runtime.getRuntime().exec(compile);
   
compile=new String[2];
    compile[0]="vvp";
    compile[1]="/root/Temp/"+ws+"/"+fname;
p = Runtime.getRuntime().exec(compile,null,new File("/root/Temp/"+ws));
BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
			String line = "";
			//OutputStream os=new FileOutputStream("/home/pranav/Desktop/om/Report.txt");
			StringBuffer sb=new StringBuffer();
			while((line=br.readLine())!=null){
				System.out.println(line);
				sb.append(line+" &nbsp; \n");
			}
                        out.print("Output of Execution: "+new String(sb));
}
}    */
String prev_et=(String)session.getAttribute("ET");
if(prev_et==null)prev_et="0";
int et=Integer.parseInt(prev_et);
%>
    <form action="RecompileTB" method="post"> 
    Select Execution Time<select name="limit">
        <% 

        for(int i=10;i<1800;){
            i=i+10;
if(et==i) out.print("<option value=\""+i+"\" selected>"+i+"</option>"); 
else    
out.print("<option value=\""+i+"\">"+i+"</option>");           

}
        %>
        
  
    </select>nsec. 
        <input type="submit" value="Get Timing Diagram"></input>
    </form>
    <%
    
%>
    <body onload="WaveDrom.ProcessAll('skins/default.svg')">        
<%
Random r=new Random();
VcdParse vp=new VcdParse();
System.out.print("workspace: "+ws);
vp.setTick(ws);
vp.setVcd(ws);
Map<Object,String> mp=null;
vp.setSignals(ws);
mp=vp.getMp();
Set s=mp.entrySet();   
Iterator it=s.iterator();
String[] signal=null;
Vector<Double> sig=new Vector<Double>(); 
%>
<script type="WaveDrom"> { "signal" : [
        <% 
while(it.hasNext()){
    int a=r.nextInt(6);
          if(a==0 | a==1|a==2 )a=3;
Map.Entry m =(Map.Entry)it.next();           
            String key=(String)m.getKey();
            String value=(String)m.getValue();
           System.out.println(key+"="+value+"<br>");                       
       signal=vp.fillSignals(key);
if(value.equals("u[31:0]"))
{
//    System.out.println("alpha");
    for(int g=0;g<signal.length;g++)
        if(signal[g]!=null)
        {
            //System.out.println("signal["+g+"]"+signal[g]);
            String str = signal[g].substring(1);
            
            
            ///////
            
            int l=str.length();
            double result=0;
            double result1=0;
            double result2 = 0;
            System.out.println("s-->"+s);
            System.out.println("l-->"+l);
            if(l<32)
            {
                int d=32-l;
                for(int i=0;i<d;i++)
                {
                    str="0"+str;
                    
                }
                System.out.println("s final-->>"+str);
            }
            
            
            ///// test  //////
            System.out.println("Str Before :"+ str);
            if(str.charAt(0)=='1'){
                for(int i=1;i<l;i++){
                    if(str.charAt(i) == '1'){
                        str = new Calculations().replaceCharAt(str,i,'0');
                    }else{
                        str = new Calculations().replaceCharAt(str,i,'1');
                    }
                }
            }
            System.out.println("Str After :"+ str);

            ///// test  //////
            
            int j=0;
            for(int i=11;i>0;i--)
            {
                double s1 =0;
                if(str.charAt(i)=='1')
                {
                    s1 = 1;
                }
                
                result1 += s1 * Math.pow(2, j);
                
                j=j+1;
            }
            System.out.println("result1-->>"+result1);
            int j1=-1;
            System.out.println("ddddddd");
            for(int i=12;i<32;i++)
            {
                
                
                double s1 =0;
                if(str.charAt(i)=='1')
                {
                    s1 = 1;
                }
                
                
                result2 += s1 * Math.pow(2, j1);
                j1=j1-1; 
            }
            //System.out.println("secong="+res11);
            result=result1+result2;
            if(str.charAt(0)=='1')
            {
              result=0-result;  
            }
            System.out.println("result final=" + result);
            
            ///////
            sig.add(result);
        }
            
}
for(Double i:sig)
{
    System.out.println("values----"+i);
} 
session.setAttribute("uvalue", sig);
                 
 for(int g=0;g<signal.length;g++)
     System.out.println("signal["+g+"]="+signal[g]);        

System.out.println("Carry Ahead Called for "+key);
/*
if(value.contains("clk")|value.contains("clock")|value.contains("clck")|value.contains("clck")){
if(signal[0].trim().equals("0")){
out.print("{ \"name\": \""+value+"\", \"wave\":");
    out.print("\"n");
      for(int i=1;i<signal.length;i++)
        out.print(".");
    out.println("\"},");
}
else if(signal[0].trim().equals("1")){
out.print("{ \"name\": \""+value+"\", \"wave\":");
    out.print("\"p");
      for(int i=1;i<signal.length;i++)
        out.print(".");
    out.println("\"},");
}
}
else */
    if(vp.isOneBit(value)==1){
    signal=vp.carryAhead(signal);
        System.out.println("Value="+value+" is one bit.");
    out.println("{ \"name\": \""+value+"\", \"wave\":");
    out.print("\"");
      for(int i=0;i<signal.length;i++)
        out.print(signal[i]);
    out.println("\"},");
    
    
    }
else if(vp.isOneBit(value)>1){
    signal=vp.carryAhead(signal);
System.out.println("Value="+value+" is more thwn one bit. ");
 out.println("{ \"name\": \""+value+"\", \"wave\":");
    out.print("\"");
      for(int i=0;i<signal.length;i++){          
          if(signal[i]==null)out.print(".");
                 else out.print(a);}
    out.print("\",\"data\":[");
     for(int i=0;i<signal.length;i++){
         if(signal[i]!=null){
      if(signal[i].contains("b")){   
        if(signal[i].contains("z"))out.print("\"Z\"");
               else
          if(signal[i].contains("x"))out.print("\"X\"");
        else  
        out.print("\""+Long.parseLong(signal[i].replace("b",""),2)+"\"");
             }
           else  if(signal[i].contains("h")){   
        if(signal[i].contains("z"))out.print("\"Z\"");
               else
               if(signal[i].contains("x"))out.print("\"X\"");
        else
          out.print("\""+Long.parseLong(signal[i].replace("h",""),16)+"\"");
             } else  if(signal[i].contains("d")){
        if(signal[i].contains("z"))out.print("\"Z\"");
               else                   
        if(signal[i].contains("x"))out.print("\"X\"");
        else
          out.print("\""+Long.parseLong(signal[i].replace("d",""),10)+"\"");
             }
            if(i<signal.length-1)out.print(",");
     }    
         }
        out.print("] },");   
}

}

        %>          
]}

</script> 
<b>Note:</b>
<% 
String zoom=request.getParameter("zoom");
if(zoom==null)zoom="1";
out.print("<b>One tick="+vp.getClockTime()+" nsec.</b> <br><br>");
%>
<form action="WaveDrom1.jsp">
Zoom Level:<select name="zoom"> 
    <option value="1" <%if(zoom.equals("1"))out.print("selected");%>>1</option>
    <option value="2" <%if(zoom.equals("2"))out.print("selected");%> >2</option>
    <option value="3"<%if(zoom.equals("3"))out.print("selected");%> >3</option>
    <option value="4"<%if(zoom.equals("4"))out.print("selected");%> >4</option>
    <option value="5"<%if(zoom.equals("5"))out.print("selected");%> >5</option>
</select>
    <input type="submit" value="Get Zoom" />
</form>
<!--<form action="GenerateGraphExp7new.jsp">
    <br><br>    
    <input type="submit" value="Plot Graph" />
</form>-->

<div>
    <br><br>
    <input type="button" id="genGraph2" value="Plot Graph"/>
</div>

<%
           session = request.getSession();
           String transfer=(String) session.getAttribute("transferFunction");
           String operation=(String) session.getAttribute("operation");
           String time=(String) session.getAttribute("samplingTime");
           String setpoint=(String) session.getAttribute("setPoint");
           String kpval=(String) session.getAttribute("kp");
           String kdval=(String) session.getAttribute("kd");
           String kival=(String) session.getAttribute("ki");
       %>
       
       <div>
           <br><br>
           <table class="table">
               <tr>
                   <td style="width: 30%">
                       Transfer Function
                   </td>
                   <td style="width: 10%">
                       :
                   </td>
                   <td style="width: 60%">
                       <%= transfer%>
                   </td>
                   
               </tr>
               <tr>
                   <td style="width: 30%">
                       Operation
                   </td>
                   <td style="width: 10%">
                       :
                   </td>
                   <td style="width: 60%">
                       <%= operation%>
                   </td>
               </tr>
               <tr>
                   <td>
                       Sampling Time
                   </td>
                   <td>
                       :
                   </td>
                   <td>
                       <%= time%>
                   </td>
               </tr>
               <tr>
                   <td>
                       Set Point
                   </td>
                   <td>
                       :
                   </td>
                   <td>
                       <%= setpoint%>
                   </td>
               </tr>
               <tr>
                   <td>
                       kp
                   </td>
                   <td>
                       :
                   </td>
                   <td>
                       <%= kpval%>
                   </td>
               </tr>
               <tr>
                   <td>
                       kd
                   </td>
                   <td>
                       :
                   </td>
                   <td>
                       <%= kdval%>
                   </td>
               </tr>
               <tr>
                   <td>
                       ki
                   </td>
                   <td>
                       :
                   </td>
                   <td>
                       <%= kival%>
                   </td>
               </tr>
           </table>
     </div>

<div id ="graph2" style="width:100%; height: 30%">

</div>
<script type="text/javascript">WaveDrom.SetHScale(<%=zoom%>); </script>
    <% }
   else out.print("Test Bench Generation data is not ready!!!");
    %>
    
    
    </body>
    <script type="text/javascript" src="Exp7new1.js"></script>
</html>
