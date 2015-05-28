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
public class SaveExp3 extends HttpServlet {

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
            HttpSession session = request.getSession();
            String operation = (String) session.getAttribute("operationsexp3");
            String architecture = (String) session.getAttribute("architectureexp3");

            String ws = (String) session.getAttribute("workspace");
            File fp = new File("/root/Temp/" + ws + "/" + "demo1.vl");
            FileOutputStream fos = null;
            PrintStream p = null;
            fos = new FileOutputStream(fp);
            p = new PrintStream(fos, true);

            String device = (String) session.getAttribute("device");


            if (operation.equals("Matrix Multiplication")) {
                int m = (Integer) session.getAttribute("laxm");
                int n = (Integer) session.getAttribute("laxn");
                int x = (Integer) session.getAttribute("laxx");
                int y = (Integer) session.getAttribute("laxy");
                int[][] mat1 = (int[][]) session.getAttribute("laxmat1");
                int[][] mat2 = (int[][]) session.getAttribute("laxmat2");
                if (architecture.equals("Serial (Single PE) Architecture")) {
                    new GenerateVerilogCode().generateSerialSinglePE(p, device, m, n, x, y, mat1, mat2);
                }
                if (architecture.equals("Parallel (N - PE) Architecture")) {
                    new GenerateVerilogCode().generateParallelNPE(p, device, m, n, x, y, mat1, mat2);
                }
                if (architecture.equals("Iterative (4 - PE) Architecture")) {
                    new GenerateVerilogCode().generateIterative4PE(p, device, m, n, x, y, mat1, mat2);
                }
            }

            if (operation.equals("Roots of Quadratic Equations")) {
                if (architecture.equals("Serial (Single PE) Architecture")) {
                    new GenerateVerilogCode().generateSerialSinglePEForRoots(p, device);
                }
                if (architecture.equals("Parallel (N - PE) Architecture")) {
                    new GenerateVerilogCode().generateParallelNPEForRoots(p, device);
                }
                if (architecture.equals("Iterative (4 - PE) Architecture")) {
                    new GenerateVerilogCode().generateIterative4PEForRoots(p, device);
                }
            }
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
