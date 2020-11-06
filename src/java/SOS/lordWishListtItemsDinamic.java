/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Class.SessionCart;
import Class.SessionCartItems;
import Databasefile.HibernateConnection;
import Databasefile.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.json.JSONObject;

/**
 *
 * @author Lochana
 */
public class lordWishListtItemsDinamic extends HttpServlet {

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

                String a = "";

                a += " <tr>";
                a += "            <th>Name</th>";
                a += "            <th>Description</th>";
                a += "            <th>Color</th>";
                a += "            <th>Qty</th>";
                a += "            <th>Amount</th>";
                a += "            <th>Info</th>";
                a += "            <th>CheckOut</th>";
                a += "            <th>Remove</th>";
                a += " </tr>";

                String y = "Your Wish List is Empty";

                Session ses = new HibernateConnection().getSessionFactory().openSession();

                Criteria ui = ses.createCriteria(Databasefile.User.class);
                ui.add(Restrictions.eq("idUser", Integer.valueOf(request.getParameter("Uid"))));
                Databasefile.User usr = (Databasefile.User) ui.uniqueResult();
                double tot = 0.0;

                if (usr.getUserStatus().getName().equals("Active")) {

                    Criteria cr = ses.createCriteria(Databasefile.WishList.class);
                    cr.add(Restrictions.eq("user", usr));
                    List<Databasefile.WishList> wi = cr.list();

                    for (Databasefile.WishList v : wi) {

                        if (v.getDate().before(new Date())) {

                            y = "";

                            tot += v.getQty() * v.getProduct().getAmount();

                            a += "<tr>";
                            a += "    <td>" + v.getProduct().getName() + "</td>";
                            a += "    <td>" + v.getProduct().getDiscription() + "</td>";
                            a += "    <td>" + v.getProductHasColor().getColor().getName() + "</td>";
                            a += "    <td>" + v.getQty() + "</td>";
                            a += "    <td>" + v.getProduct().getAmount() + "</td>";
                            a += "    <td><button class='btn btn-default' onclick='lordinfor(" + v.getProduct().getIdProduct() + ");'>Info</button></td>";
                            a += "    <td><button class=\"btn btn-info\" onclick=\"Checkout('" + v.getProduct().getIdProduct() + "','" + v.getProductHasColor().getColor().getName() + "','" + v.getQty() + "');\">CheckOut</button></td>";
                            a += "    <td><button class=\"btn btn-danger\" onclick=\"removeItem('" + v.getProduct().getIdProduct() + "','" + v.getProductHasColor().getColor().getName() + "');\">Remove</button></td>";
                            a += "</tr>";

                        }

                    }
                } else {
                    y = "Your are Deactive user tyr again";
                }

                JSONObject jo = new JSONObject();
//                JSONArray ja = new JSONArray();

                HashMap hm = new HashMap();
                hm.put("table", a);

                hm.put("tot", "Your Shopping Cart total amount Rs = " + tot + "(LKR)");
                hm.put("msg", y);

                jo.put("data", hm);
                ses.close();
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
