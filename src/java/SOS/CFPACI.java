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
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import static javafx.scene.paint.Color.color;
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
public class CFPACI extends HttpServlet {

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


                String msg = "";

                double dis = 00.0;

                Session sr = new HibernateConnection().getSessionFactory().openSession();

                double dic = 00.00;

                HttpSession hs = request.getSession();

                DecimalFormat dcf = new DecimalFormat("#.00");

                double tot = 0.00;
                int qry = 0;

                boolean bool = true;

                System.out.println("222222222");
                
                if (hs.getAttribute("SessionCart") != null) {

                    SessionCart sc = (SessionCart) hs.getAttribute("SessionCart");
                    List<SessionCartItems> citem = sc.getOld_ciems();

                    for (SessionCartItems sci : citem) {

                        System.out.println("3");

                        System.out.println("PID" + sci.getPid());

                        Criteria cr = sr.createCriteria(Databasefile.Product.class);
                        cr.add(Restrictions.eq("idProduct", sci.getPid()));
                        Databasefile.Product pp = (Product) cr.uniqueResult();

                        Criteria cc = sr.createCriteria(Databasefile.Color.class);
                        cc.add(Restrictions.eq("name", sci.getColor()));
                        Databasefile.Color color = (Databasefile.Color) cc.uniqueResult();

                        Criteria cm = sr.createCriteria(Databasefile.ProductHasColor.class);
                        cm.add(Restrictions.eq("product", pp));
                        cm.add(Restrictions.eq("color", color));
                        Databasefile.ProductHasColor phs = (Databasefile.ProductHasColor) cm.uniqueResult();

                        Criteria dro = sr.createCriteria(Databasefile.Discount.class);
                        dro.add(Restrictions.eq("product", pp));
                        Databasefile.Discount diso = (Databasefile.Discount) dro.uniqueResult();

                        if (phs.getQty() >= sci.getQty()) {
                            if (diso.getDistype().getType().equals("Presentage")) {
                                dic += (pp.getAmount() * diso.getDiscount() / 100) * sci.getQty();
                            } else {
                                dic += diso.getDiscount() * sci.getQty();
                            }
                            System.out.println("Discount: " + dic);

                            qry += phs.getQty();
                            tot += sci.getQty() * pp.getAmount();
                        } else {
                            bool = false;
                            break;
                        }
                    }
                }

                if (bool) {

                    int i = Integer.valueOf(14);
                    GregorianCalendar g = new GregorianCalendar();
                    g.setTime(new Date());
                    g.add(Calendar.DATE, i);

                    SimpleDateFormat sdf = new SimpleDateFormat("EEE, MMM d, ''yy");
                    JSONObject jo = new JSONObject();

                    HashMap hm = new HashMap();

                    hm.put("dis", dic);
                    hm.put("tot", tot);
                    hm.put("da", sdf.format(g.getTime()));

                    jo.put("data", hm);

                    sr.close();
                    out.write(jo.toString());
                } else {
                    out.write("This Qty is Not Avalable");
                    sr.close();
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
