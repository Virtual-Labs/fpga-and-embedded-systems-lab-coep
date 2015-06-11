/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;

/**
 *
 * @author coepfpgavlabs
 */
public class FetchDataSecond extends HttpServlet {

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
            System.out.println("alpha-beta");
            int cnt = Integer.parseInt(request.getParameter("cnt"));
            
            HttpSession session = request.getSession();
            
/*            JSONObject obj = (JSONObject) session.getAttribute("graph-data");

            Vector<Double> vec = new Vector<Double>();
            Vector<Double> vec1 = new Vector<Double>();
            Vector<Double> vec2 = new Vector<Double>();

            
            Vector<Double> ve = new Vector<Double>();
            Vector<Double> ve1 = new Vector<Double>();
            Vector<Double> ve2 = new Vector<Double>();
            
            vec = (Vector<Double>) obj.get("tvalues");
            vec1 = (Vector<Double>) obj.get("uvalues");
            vec2 = (Vector<Double>) obj.get("setpoint");

//            List<Double> ve = vec.subList(cnt, cnt + 100);
//            List<Double> ve1 = vec1.subList(cnt, cnt + 100);
//            List<Double> ve2 = vec2.subList(cnt, cnt + 100);

            Iterator<Double> it=vec.iterator();
            Iterator<Double> it1=vec1.iterator();
            Iterator<Double> it2=vec2.iterator();
            
            
            int cntm=0;
            while(it.hasNext()){
                
                if((cntm%200)==0){
                    ve.add(it.next());
                     ve1.add(it1.next());
                      ve2.add(it2.next());
                }
                else{
                    it.next();
                    it1.next();
                    it2.next();
                }
                cntm++;
            }
            
*/
            
            
            /////////////////////////////////////////////
            
            String setpoint=(String) session.getAttribute("setPoint");
            double sp=Double.parseDouble(setpoint);
            Vector<Double> spoints =new Vector<Double>();
//            Vector<Double> time =new Vector<Double>();
            Vector <Double> u=(Vector <Double>) session.getAttribute("uvalue");
            int s=u.size();
            System.out.println("Size="+s);
            for(int i =0;i<s;i++)
            {
                spoints.add(sp);
                
            }
            
/*            int cn=0;
            while(it.hasNext()){
                
                if((cntm%200)==0  && cn < s){
                    time.add(it.next());
                }
                else{
                    it.next();
                    
                }
                cntm++;
                cn++;
            }
*/          
            Vector<Double> t=(Vector<Double>) session.getAttribute("timesecond");
            
            Vector<Double>  time= new Vector<Double>();
            Iterator<Double> it=t.iterator();
            int cntm=0;
            int c=0;
            while(it.hasNext()){
                
                if((cntm%200)==0 && c<s){
                    time.add(it.next());
                    c++;
                }
                else{
                    it.next();
                }
                cntm++;
                
            }
            
            int x=0,y=0,z=0;
            
            for(Double i:spoints)
            {
                System.out.println("setpoint["+x+"]="+i);
                x++;
            }
            
            for(Double i:time)
            {
                System.out.println("time["+y+"]="+i);
                y++;
            }
            
            for(Double i:u)
            {
                System.out.println("u["+z+"]="+i);
                z++;
            }
            
            JSONObject obj2 = new JSONObject();
            obj2.put("spvalues", spoints);
            obj2.put("u", u);
            obj2.put("timevalue",time);
            
            response.setContentType("application/json");

            out.println(obj2);
            
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
