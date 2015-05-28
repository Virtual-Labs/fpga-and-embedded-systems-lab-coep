/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import extra.TestBench;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author root
 */
public class RecompileTB extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RecompileTB</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RecompileTB at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
             */
        } finally {            
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      HttpSession session=request.getSession();
String ws=(String)session.getAttribute("workspace");
String et=(String)request.getParameter("limit");
session.setAttribute("ET", et);
String fname=(String)session.getAttribute("FileName");
TestBench tb=new TestBench();
String tbcontent=null;
if(et!=null){
tb.setContent(ws,"testbench");
tbcontent=tb.getStrFileContent();
System.out.print(tbcontent); 
tbcontent=tbcontent.replaceAll("initial(\\s+)begin(\\s+)#(\\s?)(\\d+)","initial begin #"+et+" ");
System.out.print(tbcontent);
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



}
} 
   response.sendRedirect("ReexecuteTB");
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
