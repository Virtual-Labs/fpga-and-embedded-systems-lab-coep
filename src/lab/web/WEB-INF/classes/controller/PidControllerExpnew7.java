/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import JavaFiles.Calculations;
import JavaFiles.GenerateVerilogCode;
import java.io.*;
import java.util.Iterator;
import java.util.ListIterator;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author shree
 */
public class PidControllerExpnew7 extends HttpServlet {

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
            
            File fp = new File(constants.Constants.PATH + ws + "/" + "demo1.vl");
            FileOutputStream fos = null;
            PrintStream p = null;
            fos = new FileOutputStream(fp);
            p = new PrintStream(fos, true);
            String device = (String) session.getAttribute("device");
            
            Vector<Double> sumError = (Vector<Double>) session.getAttribute("sum-error");
            Vector<String> sumErrorString = new Vector<String>();
            Vector<Double> error = (Vector<Double>) session.getAttribute("error");
            Vector<String> err = new Vector<String>();
//            int x=0;
            for(double i:error)
            {
                err.add(Double.toString(i));
//                System.out.println("error org["+x+"]="+i);
//                x++;
                
            }
            for(double i:sumError)
            {
               sumErrorString.add(Double.toString(i));
//                System.out.println("error org["+x+"]="+i);
//                x++;
            }
            
            Vector<String> e = new Vector<String>();
            Vector<String> e_pre = new Vector<String>();
//            Iterator<String> it=err.iterator();
            ListIterator<String> it = err.listIterator();
            ListIterator<String> it1 = err.listIterator();
            int cntm=0;
            while(it.hasNext()){
                
                if((cntm%200)==0){
                    e.add(it.next()); 
                }
                else{
                    it.next();
                }
                cntm++;
            }
      //      String zero="0";
      //      e_pre.add(zero);
            int cntm1=0;
            while(it1.hasNext())
            {
                if((cntm1%200)==199)
                {
                    e_pre.add(it1.next());
                }
                else
                {
                    it1.next();
                }
                cntm1++;
            }
/*            int y=0;
            for(String i:e)
            {
               System.out.println("error["+y+"]="+i);
               y++;
            }
            int z=0;
            for(String i:e_pre)
            {
               System.out.println("error pre["+z+"]="+i);
               z++;
            }
 
*/ 

            Vector<String> e1 = new Vector<String>();
            Vector<String> e1_pre = new Vector<String>();
            Vector<String> sumErrorHex = new Vector<String>();
            for(String i: e)
            {
                long temp = new Calculations().convertToFixPoint2(i,20,11);
                String hexval=Long.toHexString(temp);
                e1.add(hexval);
            }
            for(String i: e_pre)
            {
                long temp_pre = new Calculations().convertToFixPoint2(i,20,11);
                String hexval_pre=Long.toHexString(temp_pre);
                e1_pre.add(hexval_pre);
            }
            for(String i: sumErrorString)
            {
               long tempSumError = new Calculations().convertToFixPoint2(i,20,11);
               String hexvalSumError=Long.toHexString(tempSumError);
               sumErrorHex.add(hexvalSumError);
            }
/*            for(String i:e1)
            {
                System.out.println("errrrr---"+i);
            }
            for(String i:e1_pre)
            {
                System.out.println("errrrr_pre---"+i);
            }
*/            
            String transfer = (String) session.getAttribute("transferFunction");
            
            String operation = (String) session.getAttribute("operation");
            
            String typeop = (String) session.getAttribute("typeofop");
            
            String time = (String) session.getAttribute("samplingTime");
            
            String setpoint = (String) session.getAttribute("setpoint");
            
            String kpval1 = (String) session.getAttribute("kp");
            double kp1=Double.parseDouble(kpval1);
            String kpval = Double.toString(kp1);
//            System.out.println("kp-->>"+kpval);
            String kdval1 = (String) session.getAttribute("kd");
            double kd1=Double.parseDouble(kdval1);
            String kdval = Double.toString(kd1);
//            System.out.println("kd-->>"+kdval);
            String kival1 = (String) session.getAttribute("ki");
            double ki1=Double.parseDouble(kival1);
            String kival = Double.toString(ki1);
//            System.out.println("ki-->>"+kival);
            //double sp = Double.parseDouble(setpoint);
            double kp = Double.parseDouble(kpval);
            double kd = Double.parseDouble(kdval);
            double ki = Double.parseDouble(kival);
           // double t = Double.parseDouble(time);
         
                if (operation.equals("Floating Point")) 
                {
                    if (typeop.equals("IEEE 754 format Half Precision")) {
                        
                        long laxt1 = new Calculations().convertToFixPoint(time, 10, 5);//decimal fix point of float for half precision...10.....5
                        long laxt2 = new Calculations().convertToFixPoint(setpoint, 10, 5);
                        long laxt3 = new Calculations().convertToFixPoint(kpval, 10, 5);
                        long laxt4 = new Calculations().convertToFixPoint(kdval, 10, 5);
                        long laxt5 = new Calculations().convertToFixPoint(kival, 10, 5);
                        new GenerateVerilogCode().generatePidControllerHalfPrecisionFloat(p, device, laxt1, time, laxt2, setpoint, laxt3, kpval, laxt4, kdval, laxt5, kival);
                    }
                    if (typeop.equals("IEEE 754 format Single Precision")) {
                        long laxt1 = new Calculations().convertToFixPoint(time, 23, 8);//decimal fix point of float for half precision...10.....5
                        long laxt2 = new Calculations().convertToFixPoint(setpoint, 23, 8);
                        long laxt3 = new Calculations().convertToFixPoint(kpval, 23, 8);
                        long laxt4 = new Calculations().convertToFixPoint(kdval, 23, 8);
                        long laxt5 = new Calculations().convertToFixPoint(kival, 23, 8);
                        new GenerateVerilogCode().generatePidControllerSinglePrecisionFloat(p, device, laxt1, time, laxt2, setpoint, laxt3, kpval, laxt4, kdval, laxt5, kival);
                    }
                    if (typeop.equals("IEEE 754 format Double Precision")) {
                        long laxt1 = new Calculations().convertToFixPoint(time,52,11);//decimal fix point of float for half precision...10.....5
                        long laxt2 = new Calculations().convertToFixPoint(setpoint,52,11);
                        long laxt3 = new Calculations().convertToFixPoint(kpval,52,11);
                        long laxt4 = new Calculations().convertToFixPoint(kdval,52,11);
                        long laxt5 = new Calculations().convertToFixPoint(kival,52,11);
                        new GenerateVerilogCode().generatePidControllerDoublePrecisionFloat(p, device, laxt1, time, laxt2, setpoint, laxt3, kpval, laxt4, kdval, laxt5, kival);
                    }
                }
                    else if (operation.equals("Fixed Point"))
                {
                    
                    long laxt3 = new Calculations().convertToFixPoint2(kpval, 20, 11);
                    String hexkp = Long.toHexString(laxt3);
//                    System.out.println("hex"+hex);
                   
                    long laxt4 = new Calculations().convertToFixPoint2(kdval, 20, 11);
                    String hexkd = Long.toHexString(laxt4);
                    long laxt5 = new Calculations().convertToFixPoint2(kival, 20, 11);
                    String hexki = Long.toHexString(laxt5);
                    new GenerateVerilogCode().generatePidControllerFixed(p, device,hexkp,kpval,hexkd,kdval, hexki,kival,e1,e1_pre,sumErrorHex);
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
