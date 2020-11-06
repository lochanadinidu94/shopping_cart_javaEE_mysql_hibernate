/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Databasefile.Brand;
import Databasefile.Catagory1;
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
public class advansearchmodelselect extends HttpServlet {

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

                String cata = request.getParameter("cata");
                String scata = request.getParameter("scata");
                String brand = request.getParameter("model");

                System.out.println(cata);
                System.out.println(scata);

                Session sks = new HibernateConnection().getSessionFactory().openSession();
                
                Criteria cr = sks.createCriteria(Databasefile.Catagory1.class);
                cr.add(Restrictions.eq("name", cata));
                Databasefile.Catagory1 cw = (Catagory1) cr.uniqueResult();

                Criteria ca = sks.createCriteria(Databasefile.Catagory2.class);
                ca.add(Restrictions.eq("catagory1", cw));
                ca.add(Restrictions.eq("name", scata));
                Databasefile.Catagory2 scrt = (Databasefile.Catagory2) ca.uniqueResult();

                Criteria br = sks.createCriteria(Databasefile.Brand.class);
                br.add(Restrictions.eq("catagory1", cw));
                br.add(Restrictions.eq("catagory2", scrt));
                br.add(Restrictions.eq("name", brand));
                Databasefile.Brand buc = (Databasefile.Brand) br.uniqueResult();

                Criteria cm = sks.createCriteria(Databasefile.Model.class);
                cm.add(Restrictions.eq("catagory1", cw));
                cm.add(Restrictions.eq("catagory2", scrt));
                cm.add(Restrictions.eq("brand", buc));

                List<Databasefile.Model> blm = cm.list();

                JSONObject job = new JSONObject();
                JSONArray joa = new JSONArray();

                for (Databasefile.Model blm1 : blm) {

                    HashMap hm = new HashMap();
                    hm.put("br", blm1.getName());
                    joa.put(hm);
                }
                sks.close();
                job.put("data", joa);
                out.write(job.toString());

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
