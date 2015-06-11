
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="extra.VcdParse"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Flot Examples</title>
    <link href="layout.css" rel="stylesheet" type="text/css">
    <!--[if lte IE 8]><script language="javascript" type="text/javascript" src="../excanvas.min.js"></script><![endif]-->
    <script language="javascript" type="text/javascript" src="flot/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="flot/jquery.flot.js"></script>
    <script language="javascript" type="text/javascript" src="flot/jquery.flot.stack.js"></script>
     <script language="javascript" type="text/javascript" src="flot/jquery.flot.selection.js"></script>

 </head>
    <body>
        <h1>Timing Analysis</h1>
<%
VcdParse vp=new VcdParse();String ws=(String)session.getAttribute("workspace");
System.out.print("workspace: "+ws);
vp.setTick(ws);
vp.setVcd(ws);
Map<Object,String> mp=null;
vp.setSignals(ws);
mp=vp.getMp();
Set s=mp.entrySet();   
Iterator it=s.iterator();
String[] signal=null;
%>
    
    Clock Time=<%=vp.getClockTime() %>
<br>
Limit=<%=(vp.getLimit()+vp.getClockTime())%>
<script id="source" type="text/javascript">
$(function () {
  
	var t=0;
        var clk=<%=vp.getClockTime()%>;
        var limit=<%=(vp.getLimit()+vp.getClockTime())%>;
<%
int varCount=0;
while(it.hasNext()){
           Map.Entry m =(Map.Entry)it.next();           
            String key=(String)m.getKey();
            String value=(String)m.getValue();
           System.out.println(key+"="+value+"<br>");                       
         signal=vp.fillSignals(key);
signal=vp.carryAhead(signal);
out.println("var d"+varCount+"=[];");

if(signal[0].trim().equals("0")|signal[0].trim().equals("1")){ 
for(int i=0;i<signal.length;i++)
out.println("d"+varCount+".push(["+i+","+signal[i]+"]);");
    %> 
         var stack = 0, bars = true, lines = false, steps = true;

        $.plot($("#placeholder<%=varCount%>"), [d<%=varCount%>], {
            series: {
                stack: stack,
                lines: { show: lines, fill: true, steps: steps },
                bars: { show: bars, barWidth: 1 , fill: false}
           
            }
	
        ,xaxis:{ show:false,ticks: 20,min:0,max: (limit/clk)
},
        grid: { hoverable: true, autoHighlight: true },
        yaxis: {show:false, min:0 , max: 2 },
        selection: { mode: "x" }    
});
var placeholder = $("#placeholder<%=varCount%>");

placeholder.bind("plotselected", function (event, ranges) {
        $("#selection").text((ranges.xaxis.to.toFixed(1)-ranges.xaxis.from.toFixed(1))*clk);   
    });
     placeholder.bind("plotunselected", function (event) {
        $("#selection").text("");
    });
    
    

    $("#clearSelection").click(function () {
        plot.clearSelection();
    });

    $("#setSelection").click(function () {
        plot.setSelection({ xaxis: { from: 1994, to: 1995 } });
    });
<%
         
}
else // if the signal is more than 1 bit
       { %>
          //var stack = 0, bars = true, lines = false, steps = true;

        $.plot($("#placeholder<%=varCount%>"), [d<%=varCount%>], {
            series: {
                stack: 0,
                lines: { show: false, fill: true, steps: true },
                bars: { show: true, barWidth: 1 , fill: false}
           
            }
	
        ,xaxis:{ show:false,ticks: 20,min:0,max: (limit/clk)
},
        grid: { hoverable: true, autoHighlight: true },
        yaxis: {show:false, min:0 , max: 2 },
        selection: { mode: "x" }    
});
var placeholder = $("#placeholder<%=varCount%>");

placeholder.bind("plotselected", function (event, ranges) {
        $("#selection").text((ranges.xaxis.to.toFixed(1)-ranges.xaxis.from.toFixed(1))*clk);   
    });
     placeholder.bind("plotunselected", function (event) {
        $("#selection").text("");
    });
    
    

    $("#clearSelection").click(function () {
        plot.clearSelection();
    });

    $("#setSelection").click(function () {
        plot.setSelection({ xaxis: { from: 1994, to: 1995 } });
    });

<%
}
varCount++;        
        } 
%>


    
    
    


//plotWithOptions();


      
});
</script>

<% 
for(int i=0;i<varCount;i++){
%>
<div id="placeholder<%=i%>" style="width:<%=(vp.getLimit()+vp.getClockTime())*2600/600%>px;height:80px;"></div>
<%
}
%>
    <p>(Number of Clock cycles selected by you * Clock cycle time )=<span id="selection"></span> &nbsp;nsec</p>

 </body>
</html>