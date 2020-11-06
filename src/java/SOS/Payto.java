/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Class.EmailHtml;
import Databasefile.Donateamount;
import Databasefile.HibernateConnection;
import Databasefile.Invoice;
import Databasefile.Invoiceinformation;
import Databasefile.Msg;
import java.awt.Image;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
public class Payto extends HttpServlet {

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

                String ItemId = request.getParameter("iid");
                String UserId = request.getParameter("uid");
                String Color = request.getParameter("col");
                String Qty = request.getParameter("qty");
                String Shipping = request.getParameter("sh");
                String ShippingPlane = request.getParameter("shp");
                String Donate = request.getParameter("do");
                String DonatePlane = request.getParameter("dop");

                System.out.println(Color);
                System.out.println(UserId);

                Session ses = new HibernateConnection().getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();

                Criteria cp = ses.createCriteria(Databasefile.Product.class);
                cp.add(Restrictions.eq("idProduct", Integer.valueOf(ItemId)));
                Databasefile.Product Product = (Databasefile.Product) cp.uniqueResult();

                Criteria cc = ses.createCriteria(Databasefile.Color.class);
                cc.add(Restrictions.eq("name", Color));
                Databasefile.Color Colorc = (Databasefile.Color) cc.uniqueResult();

                Criteria chp = ses.createCriteria(Databasefile.ProductHasColor.class);
                chp.add(Restrictions.eq("product", Product));
                chp.add(Restrictions.eq("color", Colorc));
                Databasefile.ProductHasColor ProductHC = (Databasefile.ProductHasColor) chp.uniqueResult();

                Criteria cu = ses.createCriteria(Databasefile.User.class);
                cu.add(Restrictions.eq("idUser", Integer.valueOf(UserId)));
                Databasefile.User User = (Databasefile.User) cu.uniqueResult();

                Databasefile.Msg mrd = new Msg();
                mrd.setMsg("Thank you Purchase ,yor item is shiped by few date s");
                mrd.setUser(User);
                mrd.setDate(new Date());
                ses.save(mrd);

                Criteria dl = ses.createCriteria(Databasefile.Delavary.class);
                dl.add(Restrictions.eq("name", ShippingPlane));
                Databasefile.Delavary Develary = (Databasefile.Delavary) dl.uniqueResult();

                if (ProductHC.getQty() >= Integer.valueOf(Qty)) {

                    if (User.getUserStatus().getName().equals("Active")) {

                        Criteria cdo = ses.createCriteria(Databasefile.Donateresion.class);
                        cdo.add(Restrictions.eq("name", DonatePlane));
                        Databasefile.Donateresion dresion = (Databasefile.Donateresion) cdo.uniqueResult();

                        Databasefile.Donateamount da = new Donateamount();
                        da.setAmount(Double.valueOf(Donate));
                        da.setDonateresion(dresion);
                        da.setUser(User);
                        ses.save(da);

                        Criteria cdd = ses.createCriteria(Databasefile.Discount.class);
                        cdd.add(Restrictions.eq("product", Product));
                        Databasefile.Discount disc = (Databasefile.Discount) cdd.uniqueResult();

                        DecimalFormat df = new DecimalFormat("#.00");

                        SimpleDateFormat sdd = new SimpleDateFormat("yyyy-MM-dd");
                        SimpleDateFormat sdt = new SimpleDateFormat("HH:mm");

                        double fa = Product.getAmount() * Integer.valueOf(Qty);
                        double ad = disc.getDiscount() * Integer.valueOf(Qty);
                        double disco = 0;
                        double tot = 0;

                        if (disc.getDistype().getType().equals("Cash")) {
                            tot = (fa - ad) + Double.valueOf(Shipping) + Double.valueOf(Donate);
                            disco = ad;
                        } else {
                            tot = fa - (fa * disc.getDiscount() / 100) + Double.valueOf(Shipping) + Double.valueOf(Donate);
                            disco = (fa * disc.getDiscount() / 100);
                        }

                        Databasefile.Invoice inv = new Invoice();
                        inv.setAmount(tot);
                        inv.setDate(sdd.format(new Date()));
                        inv.setTime(sdt.format(new Date()));
                        inv.setUser(User);
                        inv.setUser(User);
                        inv.setDelavary(Develary);
                        inv.setDonateamount(da);
                        inv.setShAmount(Double.valueOf(Shipping));
                        ses.save(inv);

                        Databasefile.Invoiceinformation im = new Invoiceinformation();
                        im.setColor(Colorc);
                        im.setInvoice(inv);
                        im.setProduct(Product);
                        ses.save(im);

                        Product.setQty(Integer.valueOf(Product.getQty() - Integer.valueOf(Qty)));
                        ses.save(Product);

                        ProductHC.setQty(Integer.valueOf(ProductHC.getQty() - Integer.valueOf(Qty)));
                        ses.save(ProductHC);

                        tr.commit();

                        try {

                            EnglishNumberToWords en = new EnglishNumberToWords();
                            int etot = (int) Math.round(tot);

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
                            i += "Invoice No : " + inv.getIdInvoice() + "";

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

                            i += "<th>Product Name</th>";
                            i += "<th>Unit Price</th>";
                            i += "<th>Qty</th>";
                            i += "<th>Discount</th>";
                            i += "<th>Shipping Charge</th>";
                            i += "<th>Donate</th>";
                            i += "<th>Total</th>";
                            i += "</thead>";

                            i += "<tr>";
                            i += "<td>" + Product.getName() + "</td>";
                            i += "<td>" + Product.getAmount() + "</td>";
                            i += "<td>" + Qty + "</td>";
                            i += "<td>" + disco + "</td>";
                            i += "<td>" + Shipping + "</td>";
                            i += "<td>" + Donate + "</td>";
                            i += "<td>" + tot + "</td>";

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
                            i += "<h2>" + tot + "</h2>";
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

                        } catch (Exception e) {
//                            e.printStackTrace();
                        }

                        ses.close();
                        out.write("a");

                    } else {
                        ses.close();
                        out.write("You Not Active User Connect Admin Active Your Account Fist");
                    }

                } else {
                    ses.close();
                    out.write("QTY is Not Available !");
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
