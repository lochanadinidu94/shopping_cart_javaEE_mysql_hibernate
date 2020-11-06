/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Class.EmailHtml;
import Databasefile.HibernateConnection;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Lochana
 */
public class forgetpassword extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {
                
                Session ses = new HibernateConnection().getSessionFactory().openSession();
                Criteria cr = ses.createCriteria(Databasefile.Login.class);
                cr.add(Restrictions.eq("email", request.getParameter("email")));
                Databasefile.Login lo =  (Databasefile.Login) cr.uniqueResult();
                
                EncryptDecrypt en = new EncryptDecrypt();

                String html = "<table width=\"750px\" height=\"500\">\n"
                        + "            <tr height=\"150px\" style=\"background-color: #A0A0A4\">\n"
                        + "            <td><center><h1>Password</h1></center></td>\n"
                        + "        </tr>\n"
                        + "        <tr height=\"250px\" style=\"background-color: #FFBF00\">\n"
                        + "            <td><center><h3 style=\"font-size: 25px\" >'" + en.decrypttwo(lo.getPassword()) + "'</h3></center></td>\n"
                        + "        </tr>\n"
                        + "        <tr height=\"100\" style=\"background-color: #A0A0A4\">\n"
                        + "        <td><center><a href=\"http://localhost:8080/Final_AJD_Project/_userregistation_login.jsp\">Click & Login</a></center></td> \n"
                        + "    </tr>\n"
                        + "</table>";

                EmailHtml.htmlcontent(request.getParameter("email"), "drpcsoftwaresolution@gmail.com", "dinidu066", html, "Password - (E-Market (pvt) ltd.)");

                
                ses.close();
                out.write("Check Your Email and get Password");
                
            } catch (Exception e) {
                out.write("Wrong Email");
            }

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
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
     * Handles the HTTP <code>POST</code> method.
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
