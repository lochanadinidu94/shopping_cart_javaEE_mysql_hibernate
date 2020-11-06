/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Class.EmailHtml;
import Class.SessionCart;
import Class.SessionCartItems;
import Databasefile.Donateamount;
import Databasefile.HibernateConnection;
import Databasefile.Invoice;
import Databasefile.Invoiceinformation;
import Databasefile.Msg;
import Databasefile.Product;
import java.awt.Image;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.ImageIcon;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRTableModelDataSource;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;
import net.sf.jasperreports.j2ee.servlets.ImageServlet;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Lochana
 */
public class PaytoAll extends HttpServlet {

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
                
                System.out.println("564545");

                String UserId = request.getParameter("uid");
                String Shipping = request.getParameter("sh");
                String ShippingPlane = request.getParameter("shp");
                String Donate = request.getParameter("do");
                String DonatePlane = request.getParameter("dop");

                Session ses = new HibernateConnection().getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();

                Criteria cu = ses.createCriteria(Databasefile.User.class);
                cu.add(Restrictions.eq("idUser", 1));
                Databasefile.User User = (Databasefile.User) cu.uniqueResult();

                Databasefile.Msg mrd = new Msg();
                mrd.setMsg("Thank you Purchase ,yor item is shiped by few date s");
                mrd.setUser(User);
                mrd.setDate(new Date());
                ses.save(mrd);

                Criteria dl = ses.createCriteria(Databasefile.Delavary.class);
                dl.add(Restrictions.eq("name", ShippingPlane));
                Databasefile.Delavary Develary = (Databasefile.Delavary) dl.uniqueResult();

                if (User.getUserStatus().getName().equals("Active")) {

                    try {
                        HttpSession hs = request.getSession();

                        if (hs.getAttribute("SessionCart") != null) {

                            EnglishNumberToWords en = new EnglishNumberToWords();
                            int etot = (int) Math.round(Integer.valueOf(request.getParameter("bt")));

                            String i = "";

                            i += "<div>";
                            i += "<br/>";
                            i += "<center>";

                            i += "<table style='width: 80%;'>";
                            i += "<tr>";
                            i += "<td>";
                            i += "<img src='http://ritarsoft.com/images/images/Logo-e-commerce-english.JPG' width='300px' height='100px'/>";
                            i += "</td>";
                            i += "<td>";
                            i += "<h1 >INVOICE</h1>";
                            i += "</td>";
                            i += "<td>";
                            i += "<div ><br/>";
                            i += new Date() + "<br/>";
                            i += "Invoice No : " + 15155 + "";

                            i += "</div>";
                            i += "</td>";

                            i += "</tr>";
                            i += "<tr>";
                            i += "<td>";

                            i += "<table>";
                            i += "<tr><td>";
                            i += "<div>";

                            i += "Billing Address:-<br/>";
                            i += "DS Senanayaka Mavatha :-<br/>";
                            i += "Mathale<br/>";

                            i += "</div>";
                            i += "</td>";
                            i += "<td>";
                            i += "<div style='margin-left: 70px;'>";

                            i += "Shipping Address:-<br/>";
                            i += request.getParameter("x") + ":-<br/>";
                            i += request.getParameter("y") + ":-<br/>";
                            i += request.getParameter("z") + ":-<br/>";

                            i += "</div>";
                            i += "</td>";
                            i += "</tr>";
                            i += "</table>";
                            i += "</td>";
                            i += "</tr>";
                            i += "</table>";
                            i += "<br/><br/><br/>";
                            i += "<table class='table' style='width: 80%;'>";
                            i += "<thead>";

                            i += "<th>Product ID</th>";
                            i += "<th>Color</th>";
                            i += "<th>Qty</th>";
//                            i += "<th>Discount</th>";
//                            i += "<th>Shipping Charge</th>";
//                            i += "<th>Donate</th>";
//                            i += "<th>Total</th>";
                            i += "</thead>";

                            SessionCart sc = (SessionCart) hs.getAttribute("SessionCart");
                            List<SessionCartItems> citem = sc.getOld_ciems();

                            for (SessionCartItems sci : citem) {

                                i += "<tr>";
                                i += "<td>" + sci.getPid() + "</td>";
                                i += "<td>" + sci.getColor() + "</td>";
                                i += "<td>" + sci.getQty() + "</td>";
////                                i += "<td>" + re + "</td>";
//                                i += "<td>" + Shipping + "</td>";
//                                i += "<td>" + Donate + "</td>";
//                                i += "<td>" + tot + "</td>";

                            }

                            i += "<td></td>";
                            i += "<td></td>";
                            i += "</tr>";

                            i += "</table>";

                            i += "<div style='float: right; margin-right: 200px;'>";

                            i += "<table>";
                            i += "<tr>";
                            i += "<td>";
                            i += "<h4>" + en.convert(etot) + "</h4>";
                            i += "</td>";
                            i += "<td>";
                            i += "<h4>:</h4>";
                            i += "</td>";
                            i += "<td>";
                            i += "<h4></h4>";
                            i += "</td>";
                            i += "</tr>";
                            i += "<tr>";
                            i += "<td>";
                            i += "<h2>Grand Total</h2>";
                            i += "</td>";
                            i += "<td>";
                            i += "<h2>:</h2>";
                            i += "</td>";
                            i += "<td>";
                            i += "<h2>" + etot + "</h2>";
                            i += "</td>";
                            i += "</tr>";
                            i += "</table>";
                            i += "</div>";
                            i += "<div style='margin-top: 200px;'>";
                            i += "Thank you for Shopping at E-Market</div>";

                            i += "</center>";
                            i += "<br/>";
                            i += "<div/>";

                            EmailHtml.htmlcontent(User.getEmail(), "drpcsoftwaresolution@gmail.com", "dinidu066", i, "Invoice - (E-Market (pvt) ltd.)");

                            hs.setAttribute("SessionCart", null);
                        }

                    } catch (Exception e) {
//                            e.printStackTrace();
                    }

                    ses.close();
                    out.write("a");

                } else {
                    ses.close();
                    out.write("You Not Active User Connect Admin Active Your Account Fist");
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
