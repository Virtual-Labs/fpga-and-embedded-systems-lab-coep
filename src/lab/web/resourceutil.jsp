<%@page import="java.util.Date"%>
<%@page import="extra.SynthesisODIN"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="extra.RTLParser"%>
<%@page import="extra.ConfigFile"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="reserror.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
<%
        String ws=(String)session.getAttribute("workspace");
        String filename=(String)session.getAttribute("FileName");
        String device=(String)session.getAttribute("device");
        String nog=null;
        if(device.contains("Spartan 3E"))nog="50 K";
        else 
        if(device.contains("Spartan 3A"))nog="1800 K";
        else 
        if(device.contains("Virtex 4"))nog="11 Millions";
        else 
        if(device.contains("Virtex II"))nog="1500 K";
        else 
        if(device.contains("Virtex 5"))nog="1800 K";
        else 
        if(device.contains("Spartan 6"))nog="1800 K";
        
        //out.print("<h3>Resource Utilization Report of "+filename+".vl for the device:"+device+" </h3>");
        ConfigFile conf=new ConfigFile();
    if(conf.createConfig(ws, filename))System.out.print("Config file is created");
       else System.out.print("Config file is not created. Please contact Administrator");
       //out.print(" Output=");
       conf.generateRTL(ws,filename);

      RTLParser rtlp=new RTLParser();
      rtlp.gateParser(ws, filename);
        %>
       <!-- <table border="1" bgcolor="#FAF8CC">
            <tr>
            <td>AND</td>
              <td>OR</td>
              <td>NOT</td>
              <td>NOR</td>
               <td>XNOR</td>
                   <td>XOR</td>
               <td>Buf</td>
               <td>Bufif0</td>
                 <td>Bufif1</td>
                   <td>Notif0</td>
                 <td>Notif1</td>
            </tr>
            <tr>
            <td><%=rtlp.getAnd()%></td>
            <td><%=rtlp.getOr()%></td>
            <td><%=rtlp.getNot()%></td>
            <td><%=rtlp.getNor()%></td>
            <td><%=rtlp.getXnor()%></td>
            <td><%=rtlp.getXor()%></td>
            <td><%=rtlp.getBuf()%></td>
            <td><%=rtlp.getBufif0()%></td>
            <td><%=rtlp.getBufif1()%></td>
            <td><%=rtlp.getNotif0()%></td>
            <td><%=rtlp.getNotif1()%></td>
            </tr>
        </table><br/>
            <table border="1" bgcolor="#FAF8CC">
                <tr><td>Total number of Gates(K)</td></tr>
                <tr><td>
<%
float total=(rtlp.getAnd()+rtlp.getOr()+rtlp.getNot()+rtlp.getNor()+rtlp.getXnor()+rtlp.getXor()+rtlp.getBuf()+rtlp.getBufif0()+rtlp.getBufif1()+rtlp.getNotif0()+rtlp.getNotif1());
double d=total/1000;
DecimalFormat twoDForm = new DecimalFormat("#.###");

%>
                        <%=twoDForm.format(d)%>K
                    </td></tr>
            </table>-->
                      
                        <br>
        <pre>
========================================================================
|<b>Resource Utilization Report  </b>                                        | 
========================================================================
Device                  :<%=device%>
------------------------------------------------------------------------
Generated on            :<%Date date=new Date(); out.print(date); %>
------------------------------------------------------------------------
Logic Used              :<%SynthesisODIN so=new SynthesisODIN();out.print(so.getContent(ws, filename).replace("-----------------------------","").replace("BEGIN STAT DUMP","").replace("END STAT DUMP","").trim());%>
------------------------------------------------------------------------
Number of Gates used    :
------------------------------------------------------------------------
Total Number of gates available:<%=nog%>
------------------------------------------------------------------------
% Utilization           : 
------------------------------------------------------------------------

        </pre>
                <!--        <table border="1" bgcolor="#FFF8C6" width="100%">
                            <tr>
                                <th>Device</td>
                                <th>Generated on</td>
                                <th>Logic used</td>
                                <th>Number of Gates used</td>
                                <th>Total Number of gates available</td>
                                <th>% Utilization</td>
                            </tr>
                            <tr>
                                <td><%=device%></td>
                                <td><%// Date date=new Date(); out.print(date); %></td>
                                <td></td>
                                <td></td>
                                <td><%=nog%></td>
                                <td></td>
                            </tr>
                        </table>-->
                            
    </body>
</html>
