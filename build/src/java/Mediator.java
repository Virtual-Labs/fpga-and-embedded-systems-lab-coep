/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.HttpSession;
/**
 *
 * @author root
 */
public class Mediator extends HttpServlet {
   
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
            out.println("<title>Servlet Mediator</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Mediator at " + request.getContextPath () + "</h1>");
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
        //processRequest(request, response);
String prog=(String)request.getParameter("Program");
String fname=(String)request.getParameter("FileName");
OutputStream os=new FileOutputStream("/home/Temp/"+fname);
Integer i=0;
	while(i<prog.length()){
	os.write(prog.charAt(i));i++;}
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
        //processRequest(request, response);
      HttpSession session = request.getSession(true);
      String command=(String)request.getParameter("area");
      System.out.println(command);
Process p = Runtime.getRuntime().exec(command);
			BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
			String line = "";
			//OutputStream os=new FileOutputStream("/home/pranav/Desktop/om/Report.txt");
			StringBuffer sb=new StringBuffer();
			while((line=br.readLine())!=null){
				System.out.println(line);
				sb.append(line+" &nbsp; \n");
			}
		String output=new String(sb);
                session.setAttribute("output",output);
System.out.print("output recorded");
try{
    response.sendRedirect("index.jsp");}catch(Exception e){
        System.out.print(e);
}
                //    getServletConfig().getServletContext().getRequestDispatcher("index.jsp").forward(request,response);

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
