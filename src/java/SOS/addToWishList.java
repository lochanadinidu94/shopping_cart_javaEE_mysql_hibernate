/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Databasefile.HibernateConnection;
import Databasefile.WishList;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.jboss.weld.SimpleCDI;

/**
 *
 * @author Lochana
 */
public class addToWishList extends HttpServlet {

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

                String IId = request.getParameter("iid");
                String UId = request.getParameter("uid");
                String Col = request.getParameter("color");
                String qty = request.getParameter("qty");

                SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");

                if (IId.isEmpty() || UId.isEmpty() || Col.isEmpty() || qty.isEmpty()) {
                    out.write("Try Again");
                } else {
                    Session ses = new HibernateConnection().getSessionFactory().openSession();
                    Transaction tr = ses.beginTransaction();

                    Criteria pc = ses.createCriteria(Databasefile.Product.class);
                    pc.add(Restrictions.eq("idProduct", Integer.valueOf(IId)));
                    Databasefile.Product product = (Databasefile.Product) pc.uniqueResult();

                    Criteria cc = ses.createCriteria(Databasefile.Color.class);
                    cc.add(Restrictions.eq("name", Col));
                    Databasefile.Color color = (Databasefile.Color) cc.uniqueResult();

                    Criteria cpc = ses.createCriteria(Databasefile.ProductHasColor.class);
                    cpc.add(Restrictions.eq("product", product));
                    cpc.add(Restrictions.eq("color", color));
                    Databasefile.ProductHasColor phc = (Databasefile.ProductHasColor) cpc.uniqueResult();

                    Criteria cu = ses.createCriteria(Databasefile.User.class);
                    cu.add(Restrictions.eq("idUser", Integer.valueOf(UId)));
                    Databasefile.User user = (Databasefile.User) cu.uniqueResult();

                    if (user.getUserStatus().getName().equals("Active")) {
                        int i = Integer.valueOf(30);
                        GregorianCalendar g = new GregorianCalendar();
                        g.setTime(new Date());
                        g.add(Calendar.DATE, i);

                        Criteria up = ses.createCriteria(Databasefile.WishList.class);
                        up.add(Restrictions.eq("user", user));
                        up.add(Restrictions.eq("product", product));
                        up.add(Restrictions.eq("productHasColor", phc));
                        Databasefile.WishList wif = (Databasefile.WishList) up.uniqueResult();

                        if (wif != null) {
                            if (phc.getQty() >= Integer.valueOf(qty) + wif.getQty()) {
                                wif.setQty(wif.getQty() + Integer.valueOf(qty));
                                wif.setDate(new Date());
                                wif.setDate(g.getTime());

                                ses.update(wif);
                                tr.commit();
                                ses.close();
                                out.write("Successfully add to Wish List. This item automaticaly remove after " + sdf.format(g.getTime()) + ".Please Checkout before");
                            } else {
                                ses.close();
                                out.write("You all ready add this item.You Can't add Enough Qty");
                            }
                        } else {
                            if (phc.getQty() >= Integer.valueOf(qty)) {
                                Databasefile.WishList wl = new WishList();
                                wl.setUser(user);
                                wl.setProduct(product);
                                wl.setProductHasColor(phc);
                                wl.setQty(Integer.valueOf(qty));
                                wl.setDate(new Date());
                                wl.setExpDate(g.getTime());

                                ses.save(wl);
                                tr.commit();
                                ses.close();
                                out.write("Successfully add to Wish List. This item automaticaly remove after " + sdf.format(g.getTime()) + ".Please Checkout before");
                            } else {
                                ses.close();
                                out.write("Bad Qty selected");
                            }
                        }
                    } else {
                        ses.close();
                        out.write("You Not Active User Connect Admin Active Your Account Fist");
                    }

                }

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
