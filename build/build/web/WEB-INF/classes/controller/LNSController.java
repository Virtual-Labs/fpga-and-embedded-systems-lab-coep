/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import JavaFiles.Calculations;
import JavaFiles.GenerateVerilogCode;
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author shree
 */
public class LNSController extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
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

            String operation = (String) session.getAttribute("selected-op");
            System.out.println("selected-op" + operation);

            if (operation.equals("Log of a Number (Base 2)") || operation.equals("Antilog of a Number (Base 2)")) {
                String number = (String) session.getAttribute("number-log");
                double num = Double.parseDouble(number);
                String number1 = Double.toString(num);
                double answer = (Double) session.getAttribute("answer");
                if(operation.equals("Log of a Number (Base 2)")){
                    long num1 = new Calculations().convertToFixPoint(number1,23,8);
                    System.out.println("in log loop");
                    new GenerateVerilogCode().generateLogLNS(p, device, num1);
                }else{
                    System.out.println("in antilog loop");
                }

            } else if (operation.equals("Division")) {
                double number1 = (Double) session.getAttribute("number-div-11");
                double number2 = (Double) session.getAttribute("number-div-22");
                double answer = (Double) session.getAttribute("answer");

                String num11 = Double.toString(number1);
                String num22 = Double.toString(number2);
                long num1=new Calculations().convertToFixPoint(num11,23,8);
                long num2=new Calculations().convertToFixPoint(num22,23,8);
                //System.out.println("num1 is :"+num1);
                //System.out.println("num2 is :"+num2);
                
                new GenerateVerilogCode().generateDivisionLNS(p, device, num1, num2);

            } else if (operation.equals("Square Root")) {
                double number = (Double) session.getAttribute("number-sq-1");
                double answer = (Double) session.getAttribute("answer");
                
                String number1= Double.toString(number);
                long num=new Calculations().convertToFixPoint(number1,23,8);
                //System.out.println("num is :"+num);
                
                new GenerateVerilogCode().generateSquareRootLNS(p, device, num);
            } else {
                String number = (String) session.getAttribute("number-pow");
                String numberPowerFactor = (String) session.getAttribute("number-pow-factor");
                double answer = (Double) session.getAttribute("answer");
            }
            
            session.setAttribute("loaded", "Program Loaded");
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
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
     * Handles the HTTP
     * <code>POST</code> method.
     *
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
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
