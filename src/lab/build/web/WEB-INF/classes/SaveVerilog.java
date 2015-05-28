/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import extra.CountUsers;
import extra.VerilogSyntaxPro;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SaveVerilog extends HttpServlet {

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
            out.println("<title>Servlet SaveVerilog</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SaveVerilog at " + request.getContextPath () + "</h1>");
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
        processRequest(request, response);
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
        String prog = (String) request.getParameter("program");
        String fname = (String) request.getParameter("filename");
        System.out.println(prog + "File name:-" + fname);
//////////////////////////////////////////////////////////
        String ws = null;
        String cookieName = "workspace";
        Cookie cookies[] = request.getCookies();
        Cookie myCookie = null;
        if (cookies != null) {
            for (int i = 0; i < cookies.length; i++) {
                if (cookies[i].getName().equals(cookieName)) {
                    myCookie = cookies[i];
                    break;
                }
            }
        }
        if (myCookie == null) {
            CountUsers c = new CountUsers();

            int ucount = c.count();
            Cookie cookie = new Cookie("workspace", Integer.toString(ucount));
            cookie.setMaxAge(365 * 24 * 60 * 60);
            response.addCookie(cookie);
            session.setAttribute("workspace", Integer.toString(ucount));
            ws = Integer.toString(ucount);
            boolean s = c.createdir("/root/Temp/" + ws);
            if (s == false) {
                ws = "default";
                session.setAttribute("workspace", ws);
            }
        } else {
            ws = myCookie.getValue();
            session.setAttribute("workspace", myCookie.getValue());
        }


        ws = (String) session.getAttribute("workspace");
//////////////////////////////////////////////////////////
        String exp = (String) session.getAttribute("expNo");
        OutputStream os = null;
        if (fname != null && ws != null) {
            try {
                if ( exp.equals("11") || exp.equals("12")) {
                    os = new FileOutputStream("/root/Temp/" + ws + "/" + fname + ".c");
                    session.setAttribute("SaveLog", "<h3>File is saved on the server with name '" + fname + ".c' in your Worksapce.</h3><br/>");
                } else {
                    os = new FileOutputStream("/root/Temp/" + ws + "/" + fname + ".vl");
                    session.setAttribute("SaveLog", "<h3>File is saved on the server with name '" + fname + ".vl' in your Worksapce. </h3><br/>");
//VerilogSyntaxPro vsp=new VerilogSyntaxPro();
//vsp.setContent(ws, fname);
//if(vsp.checkModule()!=null){
//session.setAttribute("bugs",vsp.checkModule());
//}

                }
                Integer i = 0;
                while (i < prog.length()) {
                    os.write(prog.charAt(i));
                    i++;
                }

                session.setAttribute("Program", prog);
                session.setAttribute("FileName", fname);
                
                session.setAttribute("changeCompileColor", "change");
                
            } catch (Exception e) {
                System.out.print(e);
            }
        }

        response.sendRedirect("SimFpga.jsp?expNo="+exp);
//getServletConfig().getServletContext().getRequestDispatcher("/SimFpga.jsp").forward(request,response);

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
