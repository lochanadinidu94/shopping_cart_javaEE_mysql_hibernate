/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Databasefile.HibernateConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Lochana
 */
@WebServlet(name = "login", urlPatterns = {"/login"})
public class login extends HttpServlet {

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
                RequestDispatcher rd = request.getRequestDispatcher("/_index.jsp");

                HashMap hm = new HashMap();
                HttpSession hts = request.getSession();

                String email = request.getParameter("email");
                String password = request.getParameter("password");

                System.out.println(request.getParameter("check2"));

                if (email != null && password != null) {

                    EncryptDecrypt en = new EncryptDecrypt();
                    Session s = new HibernateConnection().getSessionFactory().openSession();
                    Criteria ca = s.createCriteria(Databasefile.Login.class);
                    ca.add(Restrictions.eq("email", email));
                    Databasefile.Login lo = (Databasefile.Login) ca.uniqueResult();
                    if (en.decrypttwo(lo.getPassword()).equals(password)) {

                        Databasefile.User u = lo.getUser();
                        Criteria a = s.createCriteria(Databasefile.UserStatus.class);
                        a.add(Restrictions.eq("idUserStatus", u.getUserStatus().getIdUserStatus()));
                        Databasefile.UserStatus usa = (Databasefile.UserStatus) a.uniqueResult();

                        if (usa.getName().equals("Active")) {
                            hm.put("login_user", u.getFistName());

                            if (request.getParameter("check2") != null) {
                                Cookie uid = new Cookie("loginUserId", u.getIdUser() + "");

                                uid.setMaxAge(60 * 60 * 24 * 15);

                                response.addCookie(uid);
                            } else {
                                hts.setAttribute("loginUserId", u.getIdUser());
                            }

                            rd.forward(request, response);
                        } else {
                            s.close();
                            hm.put("login_msg", "Your account is not activate now! Please try again few minits");
                            hts.setAttribute("login_msg", hm);
                            response.sendRedirect("_userregistation_login.jsp");
                        }
                    } else {
                        s.close();
                        hm.put("login_msg", "Your password is wrong! Check password and try again.");
                        hts.setAttribute("login_msg", hm);
                        response.sendRedirect("_userregistation_login.jsp");
                    }

                } else {
                    response.sendRedirect("_userregistation_login.jsp");

                }

            } catch (Exception e) {
                //response.sendRedirect("_Admin_DashBord.jsp");

                response.sendRedirect("_userregistation_login.jsp");

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
        //processRequest(request, response);
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
