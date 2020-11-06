/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Databasefile.HibernateConnection;
import Databasefile.Model;
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
public class lordmodel extends HttpServlet {

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

                String cat , scat , br ;

                cat = request.getParameter("cat");
                scat = request.getParameter("scat");
                br = request.getParameter("br");

                Session ses = new HibernateConnection().getSessionFactory().openSession();

                Criteria c1 = ses.createCriteria(Databasefile.Catagory1.class);
                c1.add(Restrictions.eq("name", cat));
                Databasefile.Catagory1 cat1 = (Databasefile.Catagory1) c1.uniqueResult();

                Criteria c2 = ses.createCriteria(Databasefile.Catagory2.class);
                c2.add(Restrictions.eq("name", scat));
                c2.add(Restrictions.eq("catagory1", cat1));
                Databasefile.Catagory2 cat2 = (Databasefile.Catagory2) c2.uniqueResult();

                Criteria c3 = ses.createCriteria(Databasefile.Brand.class);
                c3.add(Restrictions.eq("name", br));
                c3.add(Restrictions.eq("catagory1", cat1));
                c3.add(Restrictions.eq("catagory2", cat2));
                Databasefile.Brand brand = (Databasefile.Brand) c3.uniqueResult();

                Criteria c4 = ses.createCriteria(Databasefile.Model.class);
                c4.add(Restrictions.eq("brand", brand));
                c4.add(Restrictions.eq("catagory1", cat1));
                c4.add(Restrictions.eq("catagory2", cat2));

                List<Databasefile.Model> li = c4.list();

                JSONObject job = new JSONObject();
                JSONArray joa = new JSONArray();

                for (Model li1 : li) {
                    HashMap hm = new HashMap();
                    hm.put("model", li1.getName());
                    joa.put(hm);
                }
                job.put("data", joa);
                
                ses.close();
                out.write(job.toString());

            } catch (Exception e) {
                out.write(e.toString());
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
