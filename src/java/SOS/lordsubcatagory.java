/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Databasefile.Catagory2;
import Databasefile.HibernateConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
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
public class lordsubcatagory extends HttpServlet {

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

                String catname = request.getParameter("cat");

                Session ses = new HibernateConnection().getSessionFactory().openSession();
                Criteria c = ses.createCriteria(Databasefile.Catagory1.class);
                c.add(Restrictions.eq("name", catname));
                Databasefile.Catagory1 cat1 = (Databasefile.Catagory1) c.uniqueResult();

                Criteria c1 = ses.createCriteria(Databasefile.Catagory2.class);
                c1.add(Restrictions.eq("catagory1", cat1));

                JSONObject jsob = new JSONObject();
                JSONArray jsar = new JSONArray();

                List<Databasefile.Catagory2> li = c1.list();
                for (Catagory2 li1 : li) {
                    HashMap hm = new HashMap();
                    hm.put("subcat", li1.getName());
                    jsar.put(hm);
                }
                jsob.put("data", jsar);
                
                ses.close();
                out.write(jsob.toString());

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
