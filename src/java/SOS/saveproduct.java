/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Databasefile.Discount;
import Databasefile.HibernateConnection;
import Databasefile.Product;
import Databasefile.ProductHasColor;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.derby.vti.Restriction;
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
public class saveproduct extends HttpServlet {

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
                System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
                
                String proName, cate, subCate, Bra, Mode, Size, SizeType, Discri, QtyFist, c_q1t, c_q2t, c_q3t, c_q4t, c_q5t, Price, DisType, Dis, colour1, colour2, colour3, colour4, colour5;

                proName = request.getParameter("proName");
                cate = request.getParameter("cate");
                subCate = request.getParameter("subCate");
                Bra = request.getParameter("Bra");
                Mode = request.getParameter("Mode");
                Size = request.getParameter("Size");
                SizeType = request.getParameter("SizeType");
                Discri = request.getParameter("Discri");
                QtyFist = request.getParameter("QtyFist");
                c_q1t = request.getParameter("c_q1t");
                c_q2t = request.getParameter("c_q2t");
                c_q3t = request.getParameter("c_q3t");
                c_q4t = request.getParameter("c_q4t");
                c_q5t = request.getParameter("c_q5t");
                Price = request.getParameter("Price");
                DisType = request.getParameter("DisType");
                Dis = request.getParameter("Dis");
                colour1 = request.getParameter("color1");
                colour2 = request.getParameter("color2");
                colour3 = request.getParameter("color3");
                colour4 = request.getParameter("color4");
                colour5 = request.getParameter("color5");

                if (colour1.equals("~Choos")) {
                    colour1 = "";
                } else if (colour2.equals("~Choos")) {
                    colour2 = "";
                } else if (colour3.equals("~Choos")) {
                    colour3 = "";
                } else if (colour4.equals("~Choos")) {
                    colour4 = "";
                } else if (colour5.equals("~Choos")) {
                    colour5 = "";
                }

                Session ses = new HibernateConnection().getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();

                Databasefile.Product p = new Product();
                p.setName(proName);
                p.setDiscription(Discri);
                p.setQty(Integer.parseInt(QtyFist));
                p.setAmount(Double.parseDouble(Price));

                Criteria cata = ses.createCriteria(Databasefile.Catagory1.class);
                cata.add(Restrictions.eq("name", cate));
                Databasefile.Catagory1 cata_ob = (Databasefile.Catagory1) cata.uniqueResult();

                p.setCatagory1(cata_ob);

                Criteria subcata = ses.createCriteria(Databasefile.Catagory2.class);
                subcata.add(Restrictions.eq("catagory1", cata_ob));
                subcata.add(Restrictions.eq("name", subCate));
                Databasefile.Catagory2 scata_ob = (Databasefile.Catagory2) subcata.uniqueResult();

                p.setCatagory2(scata_ob);

                Criteria brand = ses.createCriteria(Databasefile.Brand.class);
                brand.add(Restrictions.eq("catagory1", cata_ob));
                brand.add(Restrictions.eq("catagory2", scata_ob));
                brand.add(Restrictions.eq("name", Bra));
                Databasefile.Brand br_ob = (Databasefile.Brand) brand.uniqueResult();

                p.setBrand(br_ob);

                Criteria Model = ses.createCriteria(Databasefile.Model.class);
                Model.add(Restrictions.eq("catagory1", cata_ob));
                Model.add(Restrictions.eq("catagory2", scata_ob));
                Model.add(Restrictions.eq("name", Mode));
                Databasefile.Model mo_ob = (Databasefile.Model) Model.uniqueResult();

                p.setModel(mo_ob);

                Criteria SizeTypec = ses.createCriteria(Databasefile.Sizetype.class);
                SizeTypec.add(Restrictions.eq("name", SizeType));
                Databasefile.Sizetype st_ob = (Databasefile.Sizetype) SizeTypec.uniqueResult();

                Criteria Sizec = ses.createCriteria(Databasefile.Size.class);
                Sizec.add(Restrictions.eq("sizetype", st_ob));
                Sizec.add(Restrictions.eq("name", Size));
                Databasefile.Size s_ob = (Databasefile.Size) Sizec.uniqueResult();

                p.setSize(s_ob);

                ////////////////////////////////////////////////////////////////
                Databasefile.Discount disc = new Discount();
                disc.setProduct(p);
                disc.setDiscount(Double.parseDouble(Dis));

                Criteria dtc = ses.createCriteria(Databasefile.Distype.class);
                dtc.add(Restrictions.eq("type", DisType));
                Databasefile.Distype d_ob = (Databasefile.Distype) dtc.uniqueResult();

                disc.setDistype(d_ob);
//
//                ////////////////////////////////////////////////////////////////

                Criteria pst = ses.createCriteria(Databasefile.Productstates.class);
                pst.add(Restrictions.eq("name", "Available"));
                Databasefile.Productstates psc = (Databasefile.Productstates) pst.uniqueResult();

                p.setProductstates(psc);

                ////////////////////////////////////////////////////////////////
                ses.save(p);
                ses.save(disc);

                if (colour1 != null && colour1 != "") {
                    Databasefile.ProductHasColor phc = new ProductHasColor();
                    Criteria c1 = ses.createCriteria(Databasefile.Color.class);
                    c1.add(Restrictions.eq("name", colour1));
                    Databasefile.Color co1 = (Databasefile.Color) c1.uniqueResult();

                    if (co1 != null) {
                        phc.setProduct(p);
                        phc.setColor(co1);
                        phc.setQty(Integer.valueOf(c_q1t));
                        System.out.println("1");
                        ses.save(phc);
                    }
                }
                if (colour2 != null && colour2 != "") {
                    Databasefile.ProductHasColor phc2 = new ProductHasColor();
                    Criteria c2 = ses.createCriteria(Databasefile.Color.class);
                    c2.add(Restrictions.eq("name", colour2));
                    Databasefile.Color co2 = (Databasefile.Color) c2.uniqueResult();

                    if (co2 != null) {
                        phc2.setProduct(p);
                        phc2.setColor(co2);
                        phc2.setQty(Integer.valueOf(c_q2t));
                        ses.save(phc2);
                        System.out.println("2");
                    }
                }
                if (colour3 != null && colour3 != "") {
                    Databasefile.ProductHasColor phc3 = new ProductHasColor();
                    Criteria c3 = ses.createCriteria(Databasefile.Color.class);
                    c3.add(Restrictions.eq("name", colour3));
                    Databasefile.Color co3 = (Databasefile.Color) c3.uniqueResult();

                    if (co3 != null) {
                        phc3.setProduct(p);
                        phc3.setColor(co3);
                        phc3.setQty(Integer.valueOf(c_q3t));
                        ses.save(phc3);
                        System.out.println("3");
                    }
                }
                if (colour4 != null && colour4 != "") {
                    Databasefile.ProductHasColor phc4 = new ProductHasColor();
                    Criteria c4 = ses.createCriteria(Databasefile.Color.class);
                    c4.add(Restrictions.eq("name", colour4));
                    Databasefile.Color co4 = (Databasefile.Color) c4.uniqueResult();
                    if (co4 != null) {
                        phc4.setProduct(p);
                        phc4.setColor(co4);
                        phc4.setQty(Integer.valueOf(c_q4t));
                        ses.save(phc4);
                        System.out.println("4");
                    }
                }
                if (colour5 != null && colour5 != "") {
                    Databasefile.ProductHasColor phc5 = new ProductHasColor();
                    Criteria c5 = ses.createCriteria(Databasefile.Color.class);
                    c5.add(Restrictions.eq("name", colour5));
                    Databasefile.Color co5 = (Databasefile.Color) c5.uniqueResult();
                    if (co5 != null) {
                        phc5.setProduct(p);
                        phc5.setColor(co5);
                        phc5.setQty(Integer.parseInt(c_q5t));
                        ses.save(phc5);
                        System.out.println("5");
                    }
                }
                tr.commit();
                JSONObject job = new JSONObject();
                JSONArray jar = new JSONArray();
                HashMap hm = new HashMap();
                hm.put("pid", p.getIdProduct());
                jar.put(hm);
                job.put("data", jar);
                
                
                ses.close();
                out.write(job.toString());
                
//                out.write("1");
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
