package controller;

import JavaFiles.GenerateVerilogCode;
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class VerilogAbstractionLevelExp2New extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            HttpSession session = null;
            session = request.getSession();

            String ws = (String) session.getAttribute("workspace");

            File fp = new File(constants.Constants.PATH + ws + "/" + "demo1.vl");
            FileOutputStream fos = null;
            PrintStream p = null;
            fos = new FileOutputStream(fp);
            p = new PrintStream(fos, true);
            String device = (String) session.getAttribute("device");

            String exp = (String) session.getAttribute("expt");
            String level = (String) session.getAttribute("absLevel");

            if (exp.equals("4-1 Multiplexer")) {
                String muxInput1 = (String) session.getAttribute("muxInput-1");
                String muxInput2 = (String) session.getAttribute("muxInput-2");
                String muxInput3 = (String) session.getAttribute("muxInput-3");
                String muxInput4 = (String) session.getAttribute("muxInput-4");
                String muxS1 = (String) session.getAttribute("mux-s1");
                String muxS0 = (String) session.getAttribute("mux-s0");

                if (level.equals("Gate level (Structural)")) {
                    new GenerateVerilogCode().generateMuxGateLevel(p, device, muxInput1, muxInput2, muxInput3, muxInput4, muxS1, muxS0);
                } else if (level.equals("Data flow level")) {
                    new GenerateVerilogCode().generateMuxFlowLevel(p, device, muxInput1, muxInput2, muxInput3, muxInput4, muxS1, muxS0);
                } else if (level.equals("Behavioural level")) {
                    new GenerateVerilogCode().generateMuxBehaviouralLevel(p, device, muxInput1, muxInput2, muxInput3, muxInput4, muxS1, muxS0);
                }
            } else {
                String adderInput1 = (String) session.getAttribute("adderInput-1");
                String adderInput2 = (String) session.getAttribute("adderInput-2");
                String adderCarry = (String) session.getAttribute("adder-carry");
                if (level.equals("Data flow level")) {
                    new GenerateVerilogCode().generateAdderFlowLevel(p, device, adderInput1, adderInput2, adderCarry);
                } else if (level.equals("Behavioural level")) {
                    new GenerateVerilogCode().generateAdderBehaviouralLevel(p, device, adderInput1, adderInput2, adderCarry);
                }else if(level.equals("Gate level (Structural)")){
                    new GenerateVerilogCode().generateAdderGateLevel(p, device, adderInput1, adderInput2, adderCarry);
                }
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
