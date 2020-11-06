/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Databasefile.HibernateConnection;
import Databasefile.Login;
import java.io.IOException;
import java.io.PrintWriter;
import java.rmi.ServerException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
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
@WebServlet(name = "validation", urlPatterns = {"/validation"})
public class validation extends HttpServlet {

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
//            RequestDispatcher rd = request.getRequestDispatcher("/activation.jsp");
//            RequestDispatcher rd1 = request.getRequestDispatcher("/login.jsp");
            try {
                String email = request.getParameter("email");
                String activation = request.getParameter("activation");

                System.out.println(email);
                System.out.println(activation);

                if (email.isEmpty() || activation.isEmpty()) {
                    //request.setAttribute("msg", "Enter all information and activation later");
                    //rd.forward(request, response);
                    response.sendRedirect("_activation.jsp?msg=Enter all information and activation later");
                } else {
                    Session s = new HibernateConnection().getSessionFactory().openSession();
                    Criteria c = s.createCriteria(Databasefile.Login.class);
                    c.add(Restrictions.eq("email", email));
                    Databasefile.Login l = (Databasefile.Login) c.uniqueResult();

                    if (l.getValidation().equals(activation)) {

                        Transaction t = s.beginTransaction();
                        Criteria ck = s.createCriteria(Databasefile.User.class);
                        ck.add(Restrictions.eq("email", email));
                        Databasefile.User u = (Databasefile.User) ck.uniqueResult();
                        
                        Criteria cr = s.createCriteria(Databasefile.UserStatus.class);
                        cr.add(Restrictions.eq("name", "Active"));
                        Databasefile.UserStatus us = (Databasefile.UserStatus) cr.uniqueResult();
                        
                        u.setUserStatus(us);
                        s.save(u);
                        t.commit();
                        
                        s.close();
                        response.sendRedirect("_userregistation_login.jsp");
                    }else{
                        s.close();
                        response.sendRedirect("_activation.jsp?msg=Plese Enter correct activation key and email");
                    }
                    

                }

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
//        processRequest(request, response);
        response.sendRedirect("_404er.jsp");
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
