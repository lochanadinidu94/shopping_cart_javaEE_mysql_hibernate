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
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Lochana
 */
public class changestatus extends HttpServlet {

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

                String uid =request.getParameter("uid");

                Session ses = new HibernateConnection().getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();

                Criteria cr = ses.createCriteria(Databasefile.User.class);
                cr.add(Restrictions.eq("idUser", Integer.valueOf(uid)));
                Databasefile.User ur = (Databasefile.User) cr.uniqueResult();

                if (ur.getUserStatus().getIdUserStatus() == 1) {
                    Criteria cr1 = ses.createCriteria(Databasefile.UserStatus.class);
                    cr1.add(Restrictions.eq("idUserStatus", 2));
                    Databasefile.UserStatus us = (Databasefile.UserStatus) cr1.uniqueResult();

                    ur.setUserStatus(us);
                } else {
                    Criteria cr1 = ses.createCriteria(Databasefile.UserStatus.class);
                    cr1.add(Restrictions.eq("idUserStatus", 1));
                    Databasefile.UserStatus us = (Databasefile.UserStatus) cr1.uniqueResult();

                    ur.setUserStatus(us);
                }
                tr.commit();
                ses.close();
                out.write("Successful Change");
            } catch (Exception e) {
                e.printStackTrace();
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
