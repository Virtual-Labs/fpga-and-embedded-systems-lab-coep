/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import JavaFiles.Calculations;
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
public class FloatingPointArithmeticsCodeGenerator extends HttpServlet {

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
            HttpSession session = null;
            session = request.getSession();
            String ws = (String) session.getAttribute("workspace");
            File fp = new File("/root/Temp/" + ws + "/" + "demo1.vl"); 
            FileOutputStream fos = null;
            PrintStream p = null;
            fos = new FileOutputStream(fp);
            p = new PrintStream(fos, true);
            String device = (String) session.getAttribute("device");
            String givenDecimal2="";
            long laxt2=0;
            String operation = (String) session.getAttribute("operation6");
            String subOperation = (String) session.getAttribute("suboperation61");
            String givenDecimal1 = (String) session.getAttribute("givendec61");
            if (!subOperation.equals("Square Root")) {
            givenDecimal2 = (String) session.getAttribute("givendec62");
            laxt2=new Calculations().convertToFixPoint(givenDecimal2,23,8);
            }
            long laxt=new Calculations().convertToFixPoint(givenDecimal1,23,8);//decimal fix point of float...all single precision

            if(subOperation.equals("Addition")){
                new GenerateVerilogCode().generateFloatingAddition(p, device, laxt+"" , laxt2+"",givenDecimal1,givenDecimal2);
            }
            if(subOperation.equals("Multiplication")){
                
               new GenerateVerilogCode().generateFloatingMultiplcation(p, device, laxt+"" , laxt2+"",givenDecimal1,givenDecimal2);
            }
            if(subOperation.equals("Division")){
                
            }
            if(subOperation.equals("Square Root")){
                
            }
            if(subOperation.equals("Subtraction")){
                new GenerateVerilogCode().generateFloatingSubtraction(p, device, laxt+"" , laxt2+"",givenDecimal1,givenDecimal2);
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
