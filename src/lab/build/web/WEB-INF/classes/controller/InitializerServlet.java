/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import extra.CountUsers;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author root
 */
public class InitializerServlet extends HttpServlet {

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
            HttpSession session=request.getSession();
            /* TODO output your page here
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet InitializerServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InitializerServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
             * 
             * 
             * 
             */
            
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

            session.setAttribute("loaded", "Program not loaded");
            System.out.println("Initializing.......");
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
        processRequest(request, response);
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
