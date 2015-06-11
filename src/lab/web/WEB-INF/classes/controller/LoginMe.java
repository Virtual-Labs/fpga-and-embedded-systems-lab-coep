/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import JavaFiles.UserActivity;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

/**
 *
 * @author shree
 */
public class LoginMe extends HttpServlet {

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
            String name = request.getParameter("name");
            String password = request.getParameter("password");
            String url = request.getParameter("url");
            String message = "";
            System.out.println("url exp:"+url);
            
            int code = new UserActivity().validateUser(name, password);
            if (code == 2) {
                message = "You are a registered member!!";
                
                
                //System.out.println("Coming...."+url.split("url=")[1]);
                //response.sendRedirect(url.split("url=")[1]);
                response.sendRedirect("SimFpga.jsp?expNo="+url+"&name="+name);
            } else {
                if (code == 0) {
                    message = "You are not a registered member!!";
                } else if (code == 1) {
                    message = "Password is wrong!!";
                }
                
                //response.sendRedirect("indexF.html?url="+url.split("url=")[1]);
                
                response.sendRedirect("loginUser.jsp?expNo="+url);
            }
            System.out.println("msg :"+ message);

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
