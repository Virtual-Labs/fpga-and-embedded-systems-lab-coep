<%@page import="extra.VerilogSyntaxPro"%><%
VerilogSyntaxPro vsp=new VerilogSyntaxPro();
vsp.setContent("21", "helloworld");
if(vsp.checkModule()!=null){%>
<a href="#"><span class='hotspot' onmouseover="tooltip.show('<strong><%=vsp.checkModule()%></strong>')" onmouseout="tooltip.hide()">Syntax Errors detected in the code</span></a>
<%}%>