/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Databasefile.HibernateConnection;
import Databasefile.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
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
public class TShirtItemLord extends HttpServlet {

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
                System.out.println("redda methanata en nedda ykoo");

                String a = "";

                Session ses = new HibernateConnection().getSessionFactory().openSession();

                Criteria cc = ses.createCriteria(Databasefile.Catagory1.class);
                cc.add(Restrictions.eq("name", "TShirt"));
                Databasefile.Catagory1 cat1 = (Databasefile.Catagory1) cc.uniqueResult();

                Criteria cr = ses.createCriteria(Databasefile.Product.class);
                cr.add(Restrictions.eq("catagory1", cat1));

                try {

                    Databasefile.Catagory2 cat2 = null;
                    Databasefile.Brand bnd = null;
                    Databasefile.Model mdl = null;

                    System.out.println("sub" + request.getParameter("sub"));
                    System.out.println("brn" + request.getParameter("brn"));
                    System.out.println("mod" + request.getParameter("mod"));
                    System.out.println("currentpage" + request.getParameter("mod"));

                    if ((request.getParameter("sub").equals("a"))) {
                        System.out.println("###########");
                    } else {
                        Criteria we = ses.createCriteria(Databasefile.Catagory2.class);
                        we.add(Restrictions.eq("catagory1", cat1));
                        we.add(Restrictions.eq("name", request.getParameter("sub")));
                        cat2 = (Databasefile.Catagory2) we.uniqueResult();
                        System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
                        cr.add(Restrictions.eq("catagory2", cat2));
                    }

                    if ((request.getParameter("brn").equals("a"))) {
                    } else {

                        Criteria we = ses.createCriteria(Databasefile.Brand.class);
                        we.add(Restrictions.eq("catagory1", cat1));
                        we.add(Restrictions.eq("catagory2", cat2));
                        we.add(Restrictions.eq("name", request.getParameter("brn")));
                        bnd = (Databasefile.Brand) we.uniqueResult();

                        cr.add(Restrictions.eq("brand", bnd));
                        System.out.println("01010101014010101101010101010101");
                    }

                    if ((request.getParameter("mod").equals("a"))) {
                    } else {
                        Criteria we = ses.createCriteria(Databasefile.Model.class);
                        we.add(Restrictions.eq("catagory1", cat1));
                        we.add(Restrictions.eq("catagory2", cat2));
                        we.add(Restrictions.eq("brand", bnd));
                        we.add(Restrictions.eq("name", request.getParameter("mod")));
                        mdl = (Databasefile.Model) we.uniqueResult();

                        cr.add(Restrictions.eq("model", mdl));
                        System.out.println("020202020202020202020202020202020202");

                    }
                } catch (Exception e) {
//                    e.printStackTrace();
                }

                List<Databasefile.Product> li = cr.list();
                System.out.println("####################################hshshshs" + li.size());

                int t = li.size();
                int x = 1;
                int y = t;

                int pag = 0;

                int currentpage = 0;

                try {
                    currentpage = Integer.parseInt(request.getParameter("currentpage"));
                } catch (Exception e) {
                }

                if ((cr.list().size() % 9) != 0) {
                    ++pag;
                }

                try {
                    int newpage = currentpage * 9;

                    for (int j = (currentpage * 9) + 1; j <= li.size(); j++) {

                        Product li1 = li.get(j - 1);

                        Criteria cri = ses.createCriteria(Databasefile.Productimage.class);
                        cri.add(Restrictions.eq("product", li1));
                        Databasefile.Productimage pi = (Databasefile.Productimage) cri.uniqueResult();

                        System.out.println(li1.getIdProduct());
                        System.out.println(li1.getName());

                        if (pi != null) {
                            if (x > 0 && x <= 3) {
                                System.out.println("fist" + x);
                                if (x == 1) {
                                    a += "<tr>";
                                }

                                a += "<td>";
                                a += "<center>";

                                a += "<table width='1350px' height='300px'  style='position: relative;top: 0px;' class='table table-bordered'>";
                                a += "    <tr>";
                                a += "        <td height='175px'>";
                                a += "    <center>";
                                a += "        <img src='" + pi.getUrl1() + "' width='150px' height='150px' id='11' class='img-responsive' onclick='lordinfor(" + li1.getIdProduct() + ");'>";
                                a += "    </center>";
                                a += "    </td>";
                                a += "    </tr>";
                                a += "    <tr>";
                                a += "        <td>";
                                a += "            <label id='' style='float: left' class='label label-danger'>Rs:" + li1.getAmount() + "(LKR)</label>";
                                a += "            <label id='' style='float: right' class='label label-warning'>" + li1.getProductstates().getName() + "</label>";
                                a += "        </td>";
                                a += "    </tr>";
                                a += "    <tr>";
                                a += "        <td>";
                                a += "            <label id='' style='text-align: center;' class='label label-default'>" + li1.getDiscription() + "</label>";
                                a += "<label class='label label-warning' style='float: right'>" + li1.getSize().getName() + "</label>";
                                a += "        </td>";
                                a += "    </tr>";
                                a += "    <tr>";
                                a += "        <td>";
                                a += "    <center>";
                                a += "<button onclick=\"bl('popUpDiv','" + li1.getIdProduct() + "');\" class=\"btn btn-default\">Add to Cart</button>";
                                a += "<button onclick=\"bl('popUpDiv2','" + li1.getIdProduct() + "');\" class=\"btn btn-default\">Add to WishList</button>";
                                a += "<button onclick=\"bl('popUpDiv3','" + li1.getIdProduct() + "');\" class=\"btn btn-info\">CheckOut</button>";
                                a += "    </center>";
                                a += "    </td>";
                                a += "    </tr>";
                                a += "</table>";

                                a += "</center>";

                                a += "</td>";
                                //bl('popUpDiv','" + li1.getProduct().getIdProduct() + "');
                                System.out.println(x);
                                if (x == 3) {
                                    a += "</tr>";
                                }
                                x++;
                                System.out.println(x);

                            } else if (4 <= x && x <= 6) {
                                System.out.println("second" + x);
                                if (x == 4) {
                                    a += "<tr>";
                                }

                                a += "<td>";
                                a += "<center>";

                                a += "<table width='1350px' height='300px'  style='position: relative;top: 0px;' class='table table-bordered'>";
                                a += "    <tr>";
                                a += "        <td height='175px'>";
                                a += "    <center>";
                                a += "        <img src='" + pi.getUrl1() + "' width='150px' height='150px' id='11' class='img-responsive' onclick='lordinfor(" + li1.getIdProduct() + ");'>";
                                a += "    </center>";
                                a += "    </td>";
                                a += "    </tr>";
                                a += "    <tr>";
                                a += "        <td>";
                                a += "            <label id='' style='float: left' class='label label-danger'>Rs:" + li1.getAmount() + "(LKR)</label>";
                                a += "            <label id='' style='float: right' class='label label-warning'>" + li1.getProductstates().getName() + "</label>";
                                a += "        </td>";
                                a += "    </tr>";
                                a += "    <tr>";
                                a += "        <td>";
                                a += "            <label id='' style='text-align: center;' class='label label-default'>" + li1.getDiscription() + "</label>";
                                a += "<label class='label label-warning' style='float: right'>" + li1.getSize().getName() + "</label>";
                                a += "        </td>";
                                a += "    </tr>";
                                a += "    <tr>";
                                a += "        <td>";
                                a += "    <center>";
                                a += "<button onclick=\"bl('popUpDiv','" + li1.getIdProduct() + "');\" class=\"btn btn-default\">Add to Cart</button>";
                                a += "<button onclick=\"bl('popUpDiv2','" + li1.getIdProduct() + "');\" class=\"btn btn-default\">Add to WishList</button>";
                                a += "<button onclick=\"bl('popUpDiv3','" + li1.getIdProduct() + "');\" class=\"btn btn-info\">CheckOut</button>";
                                a += "    </center>";
                                a += "    </td>";
                                a += "    </tr>";
                                a += "</table>";

                                a += "</center>";

                                a += "</td>";

                                if (x == 6) {
                                    a += "</tr>";
                                }
                                x++;

                            } else if (6 < x && x <= 9) {
                                System.out.println("third" + x);
                                if (x == 7) {
                                    a += "<tr>";
                                }

                                a += "<td>";
                                a += "<center>";

                                a += "<table width='1350px' height='300px'  style='position: relative;top: 0px;' class='table table-bordered'>";
                                a += "    <tr>";
                                a += "        <td height='175px'>";
                                a += "    <center>";
                                a += "        <img src='" + pi.getUrl1() + "' width='150px' height='150px' id='11' class='img-responsive' onclick='lordinfor(" + li1.getIdProduct() + ");'>";
                                a += "    </center>";
                                a += "    </td>";
                                a += "    </tr>";
                                a += "    <tr>";
                                a += "        <td>";
                                a += "            <label id='' style='float: left' class='label label-danger'>Rs:" + li1.getAmount() + "(LKR)</label>";
                                a += "            <label id='' style='float: right' class='label label-warning'>" + li1.getProductstates().getName() + "</label>";
                                a += "        </td>";
                                a += "    </tr>";
                                a += "    <tr>";
                                a += "        <td>";
                                a += "            <label id='' style='text-align: center;' class='label label-default'>" + li1.getDiscription() + "</label>";
                                a += "<label class='label label-warning' style='float: right'>" + li1.getSize().getName() + "</label>";
                                a += "        </td>";
                                a += "    </tr>";
                                a += "    <tr>";
                                a += "        <td>";
                                a += "    <center>";
                                a += "<button onclick=\"bl('popUpDiv','" + li1.getIdProduct() + "');\" class=\"btn btn-default\">Add to Cart</button>";
                                a += "<button onclick=\"bl('popUpDiv2','" + li1.getIdProduct() + "');\" class=\"btn btn-default\">Add to WishList</button>";
                                a += "<button onclick=\"bl('popUpDiv3','" + li1.getIdProduct() + "');\" class=\"btn btn-info\">CheckOut</button>";
                                a += "    </center>";
                                a += "    </td>";
                                a += "    </tr>";
                                a += "</table>";

                                a += "</center>";

                                a += "</td>";

                                if (x == 9) {
                                    a += "<tr>";
                                }
                                x++;
                            }
                        }

                    }

//                    }
                    //}
                } catch (Exception e) {
                    e.printStackTrace();
                }

                String b = "";
                String c = "";
                String d = "";

                int v = 0;

                d += "<center>";
                for (int i = 0; i <= pag; ++i) {

                    d += "<a onclick='lordTable(" + Integer.valueOf(i) + ");' > Page : " + Integer.valueOf(i + 1) + "</a>";
                    v += i;
                }
                d += "</center>";

                System.out.println("V is =  " + v);

                if (v + 1 >= 2) {
                    b = d;
                }

                ses.close();

                HashMap hm = new HashMap();
                hm.put("tab1", a);
                hm.put("pi", b);

                JSONObject jo = new JSONObject();
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
