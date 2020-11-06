/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Databasefile.HibernateConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import static javafx.scene.paint.Color.color;
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
 * @author Lochana
 */
public class CheckFinalpay extends HttpServlet {

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

                String iid = request.getParameter("iid");
                String uid = request.getParameter("uid");
                String col = request.getParameter("col");
                String qty = request.getParameter("qty");
                String sc = request.getParameter("sc");

                String msg = "";

                double dis = 00.0;

                Session sr = new HibernateConnection().getSessionFactory().openSession();

                Criteria ck = sr.createCriteria(Databasefile.Product.class);
                ck.add(Restrictions.eq("idProduct", Integer.valueOf(iid)));
                Databasefile.Product product = (Databasefile.Product) ck.uniqueResult();

                Criteria cc = sr.createCriteria(Databasefile.Color.class);
                cc.add(Restrictions.eq("name", col));
                Databasefile.Color colo = (Databasefile.Color) cc.uniqueResult();

                Criteria cp = sr.createCriteria(Databasefile.ProductHasColor.class);
                cp.add(Restrictions.eq("product", product));
                cp.add(Restrictions.eq("color", colo));
                Databasefile.ProductHasColor phc = (Databasefile.ProductHasColor) cp.uniqueResult();

                Criteria cu = sr.createCriteria(Databasefile.User.class);
                cu.add(Restrictions.eq("idUser", Integer.valueOf(uid)));
                Databasefile.User usr = (Databasefile.User) cu.uniqueResult();

                Criteria ci = sr.createCriteria(Databasefile.Productimage.class);
                ci.add(Restrictions.eq("product", product));
                Databasefile.Productimage pi = (Databasefile.Productimage) ci.uniqueResult();

                Criteria cdd = sr.createCriteria(Databasefile.Discount.class);
                cdd.add(Restrictions.eq("product", product));
                Databasefile.Discount disc = (Databasefile.Discount) cdd.uniqueResult();

                DecimalFormat df = new DecimalFormat("#.00");

                double fa = product.getAmount() * Integer.valueOf(qty);
                double ad = disc.getDiscount() * Integer.valueOf(qty);
                double disco = 0;
                double tot = 0;

                int i = Integer.valueOf(14);
                GregorianCalendar g = new GregorianCalendar();
                g.setTime(new Date());
                g.add(Calendar.DATE, i);

            
                
                if (disc.getDistype().getType().equals("Cash")) {
                    tot = (fa - ad) + Double.valueOf(sc);
                    disco = ad;
                } else {
                    tot = fa - (fa * disc.getDiscount() / 100) + Double.valueOf(sc);
                    disco = (fa * disc.getDiscount() / 100);
                }
                SimpleDateFormat sdf = new SimpleDateFormat("EEE, MMM d, ''yy");
                if (Integer.valueOf(qty) <= phc.getQty()) {

                    JSONObject jo = new JSONObject();

                    HashMap hm = new HashMap();
                    hm.put("amo", fa);
                    hm.put("qty", Integer.valueOf(qty));
                    hm.put("dis", disco);
                    hm.put("tot", tot);
                    hm.put("sc", Double.valueOf(sc));
                    hm.put("da", sdf.format(g.getTime()));

                    jo.put("data", hm);
                    
                    sr.close();
                    out.write(jo.toString());
                } else {
                    out.write("This Qty is Not Avalable");
                    sr.close();
                }

            } catch (Exception e) {
//                e.printStackTrace();
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
