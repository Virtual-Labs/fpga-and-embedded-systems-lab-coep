<%
String clk=(String)request.getParameter("clk");
String device=(String)request.getParameter("device");
int nanoclk=500/Integer.parseInt(clk);
System.out.print(nanoclk+device);
session.setAttribute("clk"," "+nanoclk);
session.setAttribute("device",device);
session.setAttribute("clock",clk);
%>