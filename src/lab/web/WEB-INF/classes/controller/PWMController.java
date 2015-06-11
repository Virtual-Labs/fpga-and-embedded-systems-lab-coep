/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import JavaFiles.Calculations;
import JavaFiles.GenerateVerilogCode;
import java.io.*;
import java.text.DecimalFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author shree
 */
public class PWMController extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            System.out.println("Coming");
            
            HttpSession session = null;
            session = request.getSession();
            
            String ws = (String) session.getAttribute("workspace");
            
            File fp = new File(constants.Constants.PATH + ws + "/" + "demo1.vl");
            FileOutputStream fos = null;
            PrintStream p = null;
            fos = new FileOutputStream(fp);
            p = new PrintStream(fos, true);
            String device = (String) session.getAttribute("device");
            
            String pwmPeriod = (String) session.getAttribute("pwmPeriod");
            String pwmCycle = (String) session.getAttribute("pwm-cycle");
            String clock = (String) session.getAttribute("clock");
            
            System.out.println("pwmPeriod"+pwmPeriod);
            System.out.println("pwmCycle"+pwmCycle);
            
            double temp = Double.parseDouble(pwmPeriod);
            DecimalFormat dec = new DecimalFormat("#.#######");
            String temp1 = dec.format(temp);
            System.out.println("temp1 val is :"+temp1);
            
            long period = new Calculations().convertToFixPoint3(temp1,31,1);
            String hexPeriod=Long.toHexString(period);
            System.out.println("hexPeriod: "+hexPeriod);
            
            long cycle = new Calculations().convertToFixPoint4(pwmCycle,31,1);
            String hexCycle = Long.toHexString(cycle);
            System.out.println("hexCycle: "+hexCycle);
            
            new GenerateVerilogCode().generatePWM(p, device, hexPeriod, hexCycle,clock);
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
