/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Databasefile.Color;
import Databasefile.HibernateConnection;
import Databasefile.ProductHasColor;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Vector;
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
public class lordinformation extends HttpServlet {

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

                Databasefile.Catagory1 cata = pro.getCatagory1();
                Databasefile.Catagory2 scata = pro.getCatagory2();
                Databasefile.Brand br = pro.getBrand();
                Databasefile.Model mod = pro.getModel();
                Databasefile.Size si = pro.getSize();

                Criteria c2 = ses.createCriteria(Databasefile.ProductHasColor.class);
                c2.add(Restrictions.eq("product", pro));
                List<Databasefile.ProductHasColor> li = c2.list();

                JSONObject jsono = new JSONObject();
                JSONArray jsar = new JSONArray();
//                HashMap hmm = new HashMap();
                jsono.put("cate", cata.getName());
                jsono.put("scate", scata.getName());
                jsono.put("brand", br.getName());
                jsono.put("model", mod.getName());
                jsono.put("size", si.getName());

                Criteria cimg = ses.createCriteria(Databasefile.Productimage.class);
                cimg.add(Restrictions.eq("product", pro));
                Databasefile.Productimage pi = (Databasefile.Productimage) cimg.uniqueResult();

                if (pi != null) {
                    jsono.put("img1", pi.getUrl1());
                    jsono.put("img2", pi.getUrl2());
                    jsono.put("img3", pi.getUrl3());
                    jsono.put("img4", pi.getUrl4());
                }

                for (ProductHasColor li1 : li) {
                    HashMap hm = new HashMap();

                    Databasefile.Color col = li1.getColor();
                    hm.put("color", col.getName());
                    hm.put("qty", li1.getQty());

                    jsar.put(hm);
                }
                jsono.put("data", jsar);
                
                ses.close();
                out.write(jsono.toString());
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
