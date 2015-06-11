<%@page import="extra.TestBench"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String fname = (String) request.getParameter("FileName");
    System.out.println("fname = " + fname);
    String tb = (String) request.getParameter("tb");
    if (tb == null) {
        tb = "false";
    }
    System.out.println("file name:-" + fname + " TB" + tb);
    String output = null;
    Process p;
    String ws = (String) session.getAttribute("workspace");
    if (fname != null && tb.equals("false")) {
        //String[] cmd = new String[2];
//			cmd[0]="cd";
//			cmd[1]="Temp";
//p = Runtime.getRuntime().exec(cmd);
        System.out.println("fname = " + fname);
        String[] compile = new String[4];
        compile[0] = "iverilog";
        compile[1] = "-o";
        compile[2] = constants.Constants.PATH + ws + "/" + fname;
        compile[3] = constants.Constants.PATH + ws + "/" + fname + ".vl";
       
        // compile[3] = "/root/Temp/" + ws + "/" + fname + ".vl";
        //System.out.println(command);*/
        System.out.println("alo");
        p = Runtime.getRuntime().exec(compile);
         
        BufferedReader br = new BufferedReader(new InputStreamReader(p.getErrorStream()));
        String line = "";
        //OutputStream os=new FileOutputStream("/home/pranav/Desktop/om/Report.txt");
        StringBuffer sb = new StringBuffer();
        while ((line = br.readLine()) != null) {
            //System.out.println(line);
            sb.append(line + " &nbsp; \n");
        }
        output = new String(sb);
        System.out.print("output recorded " + output.length());




    } else if (fname != null && tb.equals("true")) {
        TestBench t = new TestBench();
        if (t.getTestBenchFile(ws, fname)) {

            String[] compile = new String[5];
            compile[0] = "iverilog";
            compile[1] = "-o";
            compile[2] = constants.Constants.PATH + ws + "/" + fname;
            compile[3] = constants.Constants.PATH + ws + "/" + fname + ".vl";
            compile[4] = constants.Constants.PATH + ws + "/testbench.vl";
            //System.out.println(command);*/
            p = Runtime.getRuntime().exec(compile);
            BufferedReader br = new BufferedReader(new InputStreamReader(p.getErrorStream()));
            String line = "";
            //OutputStream os=new FileOutputStream("/home/pranav/Desktop/om/Report.txt");
            StringBuffer sb = new StringBuffer();
            while ((line = br.readLine()) != null) {
                //System.out.println(line);
                sb.append(line + " &nbsp; \n");
            }
            output = new String(sb);
            System.out.print("output recorded " + output.length());

        }
    }
    session.setAttribute("FileName", fname);
%>
File "<%=fname%>.vl" is compiled on server :
<%if (output.length() == 0) {%>
Compiled successfully with 0 errors 

<% } else {%>
<%=output%>
<%}%>

