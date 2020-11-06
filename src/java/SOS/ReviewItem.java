/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Class.SessionCart;
import Class.SessionCartItems;
import Databasefile.HibernateConnection;
import com.javapapers.java.security.Modulo26Crypto;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Lochana
 */
public class ReviewItem extends HttpServlet {

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

                System.out.println("asdfghjkllkjhgfdsasddfhgjhklklpoiuyddedinidudinidudindudididndudindidu");

                EncryptDecrypt en = new EncryptDecrypt();
                Modulo26Crypto mo = new Modulo26Crypto();

                String iid = ((Integer.valueOf(request.getParameter("iid")) - 525) * 525) + "";
                String uid = ((Integer.valueOf(request.getParameter("uid")) - 725) * 527) + "";
                String col = request.getParameter("color");
                String qty = ((Integer.valueOf(request.getParameter("qty")) - 925) * 529) + "";

                String rt = request.getParameter("rt");

                if (rt.equals("cart")) {
                    int pid = Integer.valueOf(request.getParameter("iid"));
                    String cola = request.getParameter("color");

                    SessionCartItems sct = new SessionCartItems();
                    sct.setPid(pid);
                    sct.setColor(cola);

                    SessionCart sc = (SessionCart) request.getSession().getAttribute("SessionCart");
                    sc.removeSessionCartItems(sct);

                    request.getSession().setAttribute("SessionCart", sc);
                } else if (rt.equals("wl")) {
//                   
                    Session ses = new HibernateConnection().getSessionFactory().openSession();
                    Transaction tr = ses.beginTransaction();

                    Criteria cr1 = ses.createCriteria(Databasefile.User.class);
                    cr1.add(Restrictions.eq("idUser", Integer.valueOf(request.getParameter("uid"))));
                    Databasefile.User u = (Databasefile.User) cr1.uniqueResult();

                    Criteria cr2 = ses.createCriteria(Databasefile.Product.class);
                    cr2.add(Restrictions.eq("idProduct", Integer.valueOf(request.getParameter("iid"))));
                    Databasefile.Product p = (Databasefile.Product) cr2.uniqueResult();

                    Criteria cr4 = ses.createCriteria(Databasefile.Color.class);
                    cr4.add(Restrictions.eq("name", request.getParameter("color")));
                    Databasefile.Color c = (Databasefile.Color) cr4.uniqueResult();

                    Criteria cr3 = ses.createCriteria(Databasefile.ProductHasColor.class);
                    cr3.add(Restrictions.eq("product", p));
                    cr3.add(Restrictions.eq("color", c));
                    Databasefile.ProductHasColor phc = (Databasefile.ProductHasColor) cr3.uniqueResult();

                    Criteria c5 = ses.createCriteria(Databasefile.WishList.class);
                    c5.add(Restrictions.eq("user", u));
                    c5.add(Restrictions.eq("product", p));
                    c5.add(Restrictions.eq("productHasColor", phc));
                    Databasefile.WishList WL = (Databasefile.WishList) c5.uniqueResult();

                    ses.delete(WL);
                    tr.commit();
                    ses.close();
                }

                JSONObject jo = new JSONObject();

                HashMap hm = new HashMap();
                hm.put("pid", request.getParameter("iid"));
                hm.put("col", request.getParameter("color"));
                hm.put("rwi", "_ReviewItem.jsp?iid=" + iid + "&uid=" + uid + "&col=" + col + "&qty=" + qty + "");

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
