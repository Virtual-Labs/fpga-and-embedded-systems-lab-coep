/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import JavaFiles.Emailer;
import JavaFiles.UserActivity;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import javabeans.UserData;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author shree
 */
public class RegisterUser extends HttpServlet {

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
        int res = 0;
        try {
            
            String name = request.getParameter("name");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String college = request.getParameter("college");
            String password = request.getParameter("password");
            String url=request.getParameter("url");
            
            System.out.println("name : "+ name);
            System.out.println("username : "+ username);
            System.out.println("email : "+ email);
            System.out.println("college : "+ college);
            System.out.println("password : "+ password);
            System.out.println("url : "+ url);

//            Random ran=new Random();
//            ran.setSeed(33);
//            final int PASSWORD_LENGTH = 8;
//            StringBuffer password = new StringBuffer();
//            for (int x = 0; x < PASSWORD_LENGTH; x++) {
//                password.append((char) ((int) (Math.random() * 26) + 97));
//            }


            UserData ud = new UserData();

            ud.setPassword(password);
            ud.setCollege(college);
            ud.setEmail(email);
            ud.setName(name);
            ud.setUsername(username);

            UserActivity ua = new UserActivity();
  //          int checkAvailability = ua.validateUser(name, password);
  //          if(checkAvailability == 1){
                res = ua.registerUser(ud);
  //          }
                    
            if (res == 1) {
                System.out.println("regis");
                String aFromEmailAddr = "coepinstrumentationdepartmenT@gmail.com";
                String aToEmailAddr = ud.getEmail();
                String aSubject = "Virtual Lab User Registration...";
                String aBody = "Registration Successful!!\nYour Username is : " + ud.getUsername() + " \n Your password is : " + ud.getPassword();
                aBody =
                        "\n<html>"
                        + "\n    <body>"
                        + "\n        <div>"
                        + "\n            <table cellspacing='2' cellpadding='2' style=\"width: 60%; height: 60%\">"
                        + "\n                <tr>"
                        + "\n                    <td style=\"width: 25%; height: 10%\">"
                        + "\n"
                        + "\n                    </td>"
                        + "\n                    <td align=\"center\" style=\"width: 50%; height: 10%; vertical-align: middle\">"
                        + "\n"
                        + "\n                    </td>"
                        + "\n                    <td style=\"width: 25%; height: 10%\">"
                        + "\n"
                        + "\n                    </td>"
                        + "\n                </tr>"
                        + "\n                <tr>"
                        + "\n                    <td style=\"width: 25%; height: 60%\">"
                        + "\n"
                        + "\n                    </td>"
                        + "\n                    <td align=\"center\" style=\"width: 50%; height: 60%; vertical-align: middle\">"
                        + "\n                        <table>"
                        + "\n                            <tr>"
                        + "\n                                <td style=\"border: 1px black solid; border-radius: 20px;-moz-border-radius: 20px;-webkit-border-radius: 20px;\">"
                        + "\n"
                        + "\n                                    <table cellspacing='7' cellpadding='7' style=\"width: 90%; height: 90%\">"
                        + "\n                                        <tr>"
                        + "\n                                            <td style=\"background-color: gray; font-weight: bold\">"
                        + "\n                                                Name "
                        + "\n                                            </td>"
                        + "\n                                            <td>"
                        + "\n                                                :"
                        + "\n                                            </td>"
                        + "\n                                            <td>"
                        + "\n                                                " + ud.getName()
                        + "\n                                            </td>"
                        + "\n                                        </tr>"
                        + "\n                                        <tr>"
                        + "\n                                            <td style=\"background-color: gray; font-weight: bold\">"
                        + "\n                                                Username"
                        + "\n                                            </td>"
                        + "\n                                            <td>"
                        + "\n                                                :"
                        + "\n                                            </td>"
                        + "\n                                            <td>"
                        + "\n                                                " + ud.getUsername()
                        + "\n                                            </td>"
                        + "\n                                        </tr>"
                        + "\n                                        <tr>"
                        + "\n                                            <td style=\"background-color: gray; font-weight: bold\">"
                        + "\n                                                Password"
                        + "\n                                            </td>"
                        + "\n                                            <td>"
                        + "\n                                                :"
                        + "\n                                            </td>"
                        + "\n                                            <td>"
                        + "\n                                                " + ud.getPassword()
                        + "\n                                            </td>"
                        + "\n                                        </tr>"
                        + "\n                                    </table>"
                        + "\n                                </td>"
                        + "\n                            </tr>"
                        + "\n                        </table>"
                        + "\n"
                        + "\n                    </td>"
                        + "\n                    <td style=\"width: 25%; height: 60%\">"
                        + "\n"
                        + "\n                    </td>"
                        + "\n                </tr>"
                        + "\n            </table>"
                        + "\n"
                        + "\n        </div>"
                        + "\n    </body>"
                        + "\n</html>";

                new Emailer().sendEmail(aFromEmailAddr, aToEmailAddr, aSubject, aBody);
                
               response.sendRedirect("RegisterSuccess.jsp?expNo="+url);
            } else {
               
               response.sendRedirect("registerNew.jsp");
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
