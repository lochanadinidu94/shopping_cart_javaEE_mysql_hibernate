/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Databasefile.HibernateConnection;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.derby.vti.Restriction;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Lochana
 */
public class updateUser extends HttpServlet {

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
                String uid = request.getParameter("uid");
                String add1 = request.getParameter("add1");
                String add2 = request.getParameter("add2");
                String cty = request.getParameter("cty");
                String pass = request.getParameter("pass");
                String email = request.getParameter("email");
                String mob = request.getParameter("mob");
                
                Session ses = new HibernateConnection().getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();
                
                Criteria cr = ses.createCriteria(Databasefile.User.class);
                cr.add(Restrictions.eq("idUser", Integer.valueOf(uid)));
                Databasefile.User user = (Databasefile.User) cr.uniqueResult();
                
                user.setAddress1(add1);
                user.setAddress2(add2);
                user.setCity(cty);
                user.setEmail(email);
                ses.update(user);
                
                EncryptDecrypt ec = new EncryptDecrypt();
                String password1 = ec.encrypttwo(pass);
                
                Criteria ck = ses.createCriteria(Databasefile.Login.class);
                ck.add(Restrictions.eq("user", user));
                Databasefile.Login login = (Databasefile.Login) ck.uniqueResult();
                
                login.setEmail(email);
                login.setPassword(password1);
                ses.update(login);
                
                tr.commit();
                
                ses.close();
                out.write("Successfully Update");
                
            } catch (Exception e) {
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
