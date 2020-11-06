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
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Lochana
 */
public class lorddiscount extends HttpServlet {

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
                String pid = request.getParameter("pid");

                Session ses = new HibernateConnection().getSessionFactory().openSession();
                Criteria cr = ses.createCriteria(Databasefile.Product.class);
                cr.add(Restrictions.eq("idProduct", Integer.valueOf(pid)));
                Databasefile.Product pro = (Databasefile.Product) cr.uniqueResult();

                Criteria cr2 = ses.createCriteria(Databasefile.Discount.class);
                cr2.add(Restrictions.eq("product", pro));
                Databasefile.Discount dis = (Databasefile.Discount) cr2.uniqueResult();

                Criteria cr3 = ses.createCriteria(Databasefile.Distype.class);
                cr3.add(Restrictions.eq("idDisType", dis.getDistype().getIdDisType()));
                Databasefile.Distype dti = (Databasefile.Distype) cr3.uniqueResult();

                double d = pro.getAmount();
                double b = dis.getDiscount();
                double am = 00.0;

                if (dti.getType().equals("Cash")) {
                    am = d - b;
                } else {
                    am = d - (d * b / 100);
                }

                JSONArray jsa = new JSONArray();
                JSONObject job = new JSONObject();

                job.put("Dis", b);
                job.put("DisTy", dti.getType());
                job.put("Amo", am);

                ses.close();
                out.write(job.toString());

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
