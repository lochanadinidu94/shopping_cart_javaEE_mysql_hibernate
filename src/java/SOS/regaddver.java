/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Class.EmailHtml;
import Databasefile.Addinvoice;
import Databasefile.Addreg;
import Databasefile.HibernateConnection;
import Databasefile.Msg;
import Databasefile.Msgadmin;
import java.io.IOException;
import java.io.PrintWriter;
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

/**
 *
 * @author Lochana pakaya
 */
public class regaddver extends HttpServlet {

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

                String uid = request.getParameter("uid");
                String pla = request.getParameter("pla");
                String rea = request.getParameter("rea");

                int i = 1;

                if (pla.equals("Silver")) {
                    i = 7;
                } else if (pla.equals("Gold")) {
                    i = 14;
                } else if (pla.equals("Platinum")) {
                    i = 30;
                }

                GregorianCalendar g = new GregorianCalendar();
                g.setTime(new Date());
                g.add(Calendar.DATE, i);

                Session ses = new HibernateConnection().getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();

                Criteria cr = ses.createCriteria(Databasefile.User.class);
                cr.add(Restrictions.eq("idUser", Integer.valueOf(uid)));
                Databasefile.User user = (Databasefile.User) cr.uniqueResult();

                Databasefile.Msg mg = new Msg();
                mg.setUser(user);
                mg.setDate(new Date());
                mg.setMsg("Your Advertisement is successfully add.Advertisement was activated in 2h.");
                ses.save(mg);

                Databasefile.Msgadmin ma = new Msgadmin();
                ma.setDate(new Date());
                ma.setMsg("E-Market add new Advertisement.Check and Active it");
                ses.save(ma);

                Databasefile.Addreg ar = new Addreg();
                ar.setPlan(pla);
                ar.setReason(rea);
                ar.setUser(user);
                ar.setExpdate(g.getTime());
                ar.setStates("Pending");
                ses.save(ar);

                Databasefile.Addinvoice ai = new Addinvoice();
                ai.setAddreg(ar);

                if (pla.equals("Silver")) {
                    ai.setAmount(750.00);
                } else if (pla.equals("Gold")) {
                    ai.setAmount(2000.00);
                } else if (pla.equals("Platinum")) {
                    ai.setAmount(4000.00);
                }

                int v = ar.getIdAddreg();

                ai.setDate(new Date());
                ses.save(ai);
                tr.commit();
                ses.close();

                try {

                    EnglishNumberToWords en = new EnglishNumberToWords();
                    int etot = (int) Math.round(ai.getAmount());

                    String ii = "";

                    ii += "<div>";
                    ii += "<br/>";
                    ii += "<center>";

                    ii += "<table style='width: 80%;'>";
                    ii += "<tr>";
                    ii += "<td>";
                    ii += "<img src='http://ritarsoft.com/images/images/Logo-e-commerce-english.JPG' width='300px' height='100px'/>";
                    ii += "</td>";
                    ii += "<td>";
                    ii += "<h1 >INVOICE</h1>";
                    ii += "</td>";
                    ii += "<td>";
                    ii += "<div ><br/>";
                    ii += new Date() + "<br/>";
                    ii += "Invoice No : " + ai.getIdAddinvoice() + "";

                    ii += "</div>";
                    ii += "</td>";

                    ii += "</tr>";
                    ii += "<tr>";
                    ii += "<td>";

                    ii += "<table>";
                    ii += "<tr><td>";
                    ii += "<div>";

                    ii += "Billing Address:-<br/>";
                    ii += "DS Senanayaka Mavatha :-<br/>";
                    ii += "Mathale<br/>";

                    ii += "</div>";
                    ii += "</td>";
                    ii += "<td>";
                    ii += "<div style='margin-left: 70px;'>";

                    ii += "</div>";
                    ii += "</td>";
                    ii += "</tr>";
                    ii += "</table>";
                    ii += "</td>";
                    ii += "</tr>";
                    ii += "</table>";
                    ii += "<br/><br/><br/>";
                    ii += "<table class='table' style='width: 80%;'>";
                    ii += "<thead>";

                    ii += "<th>Advertisement Plan</th>";
                    ii += "<th>Advertisement Address</th>";
                    ii += "<th>Total</th>";
                    ii += "</thead>";

                    ii += "<tr>";
                    ii += "<td>" + pla+ "</td>";
                    ii += "<td>" + rea + "</td>";
                    ii += "<td>" + ai.getAmount() + "</td>";

                    ii += "<td></td>";
                    ii += "<td></td>";
                    ii += "</tr>";

                    ii += "</table>";

                    ii += "<div style='float: right; margin-right: 200px;'>";

                    ii += "<table>";
                    ii += "<tr>";
                    ii += "<td>";
                    ii += "<h4>" + en.convert(etot) + "</h4>";
                    ii += "</td>";
                    ii += "<td>";
                    ii += "<h4>:</h4>";
                    ii += "</td>";
                    ii += "<td>";
                    ii += "<h4></h4>";
                    ii += "</td>";
                    ii += "</tr>";
                    ii += "<tr>";
                    ii += "<td>";
                    ii += "<h2>Grand Total</h2>";
                    ii += "</td>";
                    ii += "<td>";
                    ii += "<h2>:</h2>";
                    ii += "</td>";
                    ii += "<td>";
                    ii += "<h2>" + ai.getAmount() + "</h2>";
                    ii += "</td>";
                    ii += "</tr>";
                    ii += "</table>";
                    ii += "</div>";
                    ii += "<div style='margin-top: 200px;'>";
                    ii += "Thank you for Shopping at E-Market</div>";

                    ii += "</center>";
                    ii += "<br/>";
                    ii += "<div/>";

                    EmailHtml.htmlcontent(user.getEmail(), "drpcsoftwaresolution@gmail.com", "dinidu066", ii, "Invoice - (E-Market (pvt) ltd.)");

                } catch (Exception e) {
//                            e.printStackTrace();
                }

                out.print(v);

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
