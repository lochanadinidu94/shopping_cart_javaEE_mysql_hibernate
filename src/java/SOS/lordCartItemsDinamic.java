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
import com.sun.scenario.effect.impl.prism.ps.PPSBlend_ADDPeer;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import javax.json.JsonObject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Lochana
 */
public class lordCartItemsDinamic extends HttpServlet {

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
                a += "            <th>Add Wish List</th>";
                a += "            <th>CheckOut</th>";
                a += "            <th>Remove</th>";
                a += " </tr>";

                HttpSession hs = request.getSession();

                System.out.println("1");

                String y = "Your Shopping Cart is Empty";

                DecimalFormat dcf = new DecimalFormat("#.00");

                double tot = 0.00;
                if (hs.getAttribute("SessionCart") != null) {

                    Session ses = new HibernateConnection().getSessionFactory().openSession();

                    System.out.println("2");

                    SessionCart sc = (SessionCart) hs.getAttribute("SessionCart");
                    List<SessionCartItems> citem = sc.getOld_ciems();

                    for (SessionCartItems sci : citem) {

                        System.out.println("3");

                        y = "<button  class='btn btn-info' onclick='checkallofcart()'>Check out all</button>";

                        System.out.println("PID" + sci.getPid());

                       
                        Criteria cr = ses.createCriteria(Databasefile.Product.class);
                        cr.add(Restrictions.eq("idProduct", sci.getPid()));
                        Databasefile.Product pp = (Product) cr.uniqueResult();

                        Criteria cc = ses.createCriteria(Databasefile.Color.class);
                        cc.add(Restrictions.eq("name", sci.getColor()));
                        Databasefile.Color color = (Databasefile.Color) cc.uniqueResult();

                        Criteria cm = ses.createCriteria(Databasefile.ProductHasColor.class);
                        cm.add(Restrictions.eq("product", pp));
                        cm.add(Restrictions.eq("color", color));
                        Databasefile.ProductHasColor phs = (Databasefile.ProductHasColor) cm.uniqueResult();

                        tot += sci.getQty() * pp.getAmount();

                        a += "<tr>";
                        a += "    <td>" + pp.getName() + "</td>";
                        a += "    <td>" + pp.getDiscription() + "</td>";
                        a += "    <td>" + sci.getColor() + "</td>";
                        a += "    <td>" + sci.getQty() + "</td>";
                        a += "    <td>" + dcf.format(pp.getAmount()) + "</td>";
                        a += "    <td><button class='btn btn-default' onclick='lordinfor(" + sci.getPid() + ");'>Info</button></td>";
                        a += "    <td><button class=\"btn btn-default\" onclick=\"addToWL('" + sci.getPid() + "','" + sci.getColor() + "','" + sci.getQty() + "','" + phs.getQty() + "');\">Add Wish List</button></td>";
                        a += "    <td><button class=\"btn btn-info\" onclick=\"Checkout('" + sci.getPid() + "','" + sci.getColor() + "','" + sci.getQty() + "');\">CheckOut</button></td>";
                        a += "    <td><button class=\"btn btn-danger\" onclick=\"removeItem('" + sci.getPid() + "','" + sci.getColor() + "');\">Remove</button></td>";
                        a += "</tr>";

                    }
                    ses.close();

                }
                JSONObject jo = new JSONObject();
//                JSONArray ja = new JSONArray();

                HashMap hm = new HashMap();
                hm.put("table", a);

                hm.put("tot", "Your Shopping Cart total amount Rs = " + dcf.format(tot) + "(LKR)");
                hm.put("msg", y);

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
