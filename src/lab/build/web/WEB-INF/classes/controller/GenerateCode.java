/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author root
 */
public class GenerateCode extends HttpServlet {

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
            out.println("<title>Servlet GenerateCode</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GenerateCode at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
             */
            
            File fp=new File("/root/laxmikants/demo1.vl");
//            System.out.println(" Current : "+new File(".").getCanonicalFile());
//          BufferedWriter bw=new BufferedWriter(new FileWriter(fp));
//          bw.write("lax \n fdfdfdfdfdf\n fdfdfdf \nfdfdfdfdf");
//            
            
            FileOutputStream fos=null;
            PrintStream p=null;
            
            fos=new FileOutputStream(fp);
            p=new PrintStream(fos, true);
            
            p.println("laxmikant");
            p.println("kumbhare");
            
            
            
            
            
            int mat1[][]=new int[3][3];
            int mat2[][]=new int[3][3];
            for(int i=0;i<3;i++)
            {
                for(int j=0;j<3;j++)
                {
                    mat1[i][j]=Integer.parseInt(request.getParameter("txta"+i+j));
                    //mat2[i][j]=Integer.parseInt(request.getParameter("txtb"+i+j));
                }
            }
            
            for(int i=0;i<3;i++)
            {
                for(int j=0;j<3;j++)
                {
                    System.out.print(mat1[i][j]+ " ");
                }
                System.out.println();
            }
            
            
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
