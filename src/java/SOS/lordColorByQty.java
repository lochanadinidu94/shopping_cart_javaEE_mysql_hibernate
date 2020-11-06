/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Databasefile.HibernateConnection;
import Databasefile.ProductHasColor;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
public class lordColorByQty extends HttpServlet {

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

                Criteria ca = ses.createCriteria(Databasefile.Product.class);
                ca.add(Restrictions.eq("idProduct", Integer.valueOf(request.getParameter("iid"))));//request.getParameter("iid")
                Databasefile.Product p = (Databasefile.Product) ca.uniqueResult();

                Criteria cm = ses.createCriteria(Databasefile.Color.class);
                cm.add(Restrictions.eq("name", request.getParameter("col")));
                Databasefile.Color co = (Databasefile.Color) cm.uniqueResult();

                Criteria cr = ses.createCriteria(Databasefile.ProductHasColor.class);
                cr.add(Restrictions.eq("product", p));
                cr.add(Restrictions.eq("color", co));
                Databasefile.ProductHasColor li = (Databasefile.ProductHasColor) cr.uniqueResult();
//                System.out.println(li.getQty());
                ses.close();
                out.write(li.getQty().toString());
            } catch (Exception e) {
                //e.printStackTrace();
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
