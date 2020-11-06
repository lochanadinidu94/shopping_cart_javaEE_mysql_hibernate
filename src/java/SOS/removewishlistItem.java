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
public class removewishlistItem extends HttpServlet {

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

                String iid = request.getParameter("pid");
                String uid = request.getParameter("uid");
                String col = request.getParameter("col");
                
                System.out.println("IID"+iid);
                System.out.println("UID"+uid);
                System.out.println("COl"+col);

                Session ses = new HibernateConnection().getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();
                
                Criteria cr1 = ses.createCriteria(Databasefile.User.class);
                cr1.add(Restrictions.eq("idUser", Integer.valueOf(uid)));
                Databasefile.User u = (Databasefile.User) cr1.uniqueResult();

                Criteria cr2 = ses.createCriteria(Databasefile.Product.class);
                cr2.add(Restrictions.eq("idProduct", Integer.valueOf(iid)));
                Databasefile.Product p = (Databasefile.Product) cr2.uniqueResult();

                Criteria cr4 = ses.createCriteria(Databasefile.Color.class);
                cr4.add(Restrictions.eq("name", col));
                Databasefile.Color c = (Databasefile.Color) cr4.uniqueResult();
                
                Criteria cr3 = ses.createCriteria(Databasefile.ProductHasColor.class);
                cr3.add(Restrictions.eq("product", p));
                cr3.add(Restrictions.eq("color", c));
                Databasefile.ProductHasColor phc = (Databasefile.ProductHasColor) cr3.uniqueResult();

                Criteria c5 = ses.createCriteria(Databasefile.WishList.class);
                c5.add(Restrictions.eq("user", u));
                c5.add(Restrictions.eq("product", p));
                c5.add(Restrictions.eq("productHasColor", phc));
                Databasefile.WishList WL =  (Databasefile.WishList) c5.uniqueResult();

                ses.delete(WL);
                tr.commit();
                
                
                ses.close();
                out.write("Successfully Remove item");
                
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
