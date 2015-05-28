/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import JavaFiles.GenerateVerilogCode;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
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
public class LinearEquationSolver extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    HttpSession session;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LinearEquationSolver</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LinearEquationSolver at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
             * 
             */
            session = request.getSession();
            String ws = (String) session.getAttribute("workspace");
            File fp = new File("/root/Temp/" + ws + "/" + "demo1.vl");
            FileOutputStream fos = null;
            PrintStream p = null;
            fos = new FileOutputStream(fp);
            p = new PrintStream(fos, true);
            String device = (String) session.getAttribute("device");
            double equ2[][] = (double[][]) session.getAttribute("equ2exp5");
            double answer2[] = (double[]) session.getAttribute("answerexp5");
            double ans[] = (double[]) session.getAttribute("ansexp5");
            int rank = (Integer) session.getAttribute("rankexp5");
            String dataType = (String) session.getAttribute("datatypeexp5");
            String solveMethod = (String) session.getAttribute("solveexp5");
            int equ1[][] = new int[rank][rank];
            int answer1[] = new int[rank];
            if (dataType.equals("Fix Point")) {
                for (int i = 0; i < rank; i++) {
                    for (int j = 0; j < rank; j++) {
                        equ1[i][j] = (int) equ2[i][j];
                    }
                    answer1[i] = (int) answer2[i];
                }

                if (solveMethod.equals("Gauss-Jordan Elimination")) {
                    new GenerateVerilogCode().generateLinearSolverGaussFixPoint(p, device, equ1, answer1, rank); 
                } else {
                    new GenerateVerilogCode().generateLinearSolverLUFactorizationFixPoint(p, device, equ1, answer1, rank);
                }



            } else {
                if (solveMethod.equals("Gauss-Jordan Elimination")) {
                    new GenerateVerilogCode().generateLinearSolverGaussFloatingPoint(p, device, equ2, answer2, rank);
                } else {
                    new GenerateVerilogCode().generateLinearSolverLUFactorizationFloatingPoint(p, device, equ2, answer2, rank);
                }
            }






            System.out.println("\n\n\n\n\nComing to servlet\n\n\n\n\n");
            session.setAttribute("loaded", "Program Loaded");

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
