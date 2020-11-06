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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.json.JSONObject;

/**
 *
 * @author Lochana pakaya
 */
public class ratingcount extends HttpServlet {

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

                int pid = Integer.valueOf(request.getParameter("pid"));

                Session ses = new HibernateConnection().getSessionFactory().openSession();

                Criteria cp = ses.createCriteria(Databasefile.Product.class);
                cp.add(Restrictions.eq("idProduct", pid));
                Databasefile.Product pro = (Databasefile.Product) cp.uniqueResult();

                Criteria cr = ses.createCriteria(Databasefile.Ratting.class);
                cr.add(Restrictions.eq("product", pro));
                cr.add(Restrictions.eq("states", "UnLike"));
                int ul = cr.list().size();

                Criteria cr1 = ses.createCriteria(Databasefile.Ratting.class);
                cr1.add(Restrictions.eq("product", pro));
                cr1.add(Restrictions.eq("states", "Like"));
                int li = cr1.list().size();

                HashMap hm = new HashMap();
                hm.put("like", li);
                hm.put("Unlike", ul);

                JSONObject jo = new JSONObject();
                jo.put("data", hm);

                out.write(jo.toString());

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
