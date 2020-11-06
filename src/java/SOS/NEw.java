/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Databasefile.HibernateConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Lochana
 */
public class NEw extends HttpServlet {

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

                String msg = request.getParameter("msg");

                String a = "";
                Session ses = new HibernateConnection().getSessionFactory().openSession();

                a += "<tr>";

                //a +=    "<!--<th style='text-align: left'><h4>ID</h4></th>-->";
                a += "<th style='text-align: center'><h4>Name</h4></th>";
                a += "<th style='text-align: center'><h4>Description</h4></th>";
                a += "<th style='text-align: right'><h4>QTY</h4></th>";
                a += "<th style='text-align: right'><h4>Amount</h4></th>";
                a += "<th style='text-align: center'><h4>Status</h4></th>";
                a += "<th style='text-align: center'><h4>Discount</h4></th>";
                a += "<th style='text-align: center'><h4>Information</h4></th>";
                a += "<th style='text-align: center'><h4>Update</h4></th>";
                a += "<th style='text-align: center'><h4>Add Home</h4></th>";
                a += "</tr>";
                Criteria c1 = ses.createCriteria(Databasefile.Product.class);
                if (msg.equals("_No") || msg.isEmpty() || msg == null) {
                } else {
                    c1.add(Restrictions.like("name", "%" + msg + "%"));
                }
                List<Databasefile.Product> li = c1.list();
                for (Databasefile.Product p : li) {

                    a += "<tr>";
                    //a +=   "<!-- <td style='text-align: left'>"+p.getIdProduct()+"</td>-->";
                    a += "<td style='text-align: center'>" + p.getName() + "</td>";
                    a += "<td style='text-align: center'>" + p.getDiscription() + "</td>";
                    a += "<td style='text-align: right'>" + p.getQty() + "</td>";
                    a += "<td style='text-align: right'>" + p.getAmount() + "</td>";

                    if (p.getQty() <= 5) {

                        a += "<td style='text-align: center'><h5 style='color: tomato' id='s1111'>Low Qty</h5></td>";

                    } else {

                        a += "<td style='text-align: center'><h5 style='color: tomato' id='s1111'>" + p.getProductstates().getName() + "</h5></td>";

                    }

                    a += "<td style=\"text-align: center\"><button class=\"btn btn-info\" onclick=\"bl('popUpDiv2','" + p.getIdProduct() + "', 'Disco')\">Click</button></td>";
                    a += "<td style=\"text-align: center\"><button class=\"btn btn-info\" onclick=\"bl('popUpDiv','" + p.getIdProduct() + "', 'Infor')\">Click</button></td>";
                    a += " <td style=\"text-align: center\"><button class=\"btn btn-info\" onclick=\"bl('popUpDiv3','" + p.getIdProduct() + "', 'Update')\">Update</button></td>";
                    a += " <td style='text-align: center'><button class='btn btn-info' onclick='FistPage(" + p.getIdProduct() + ")'>Add Home</button></td>";
                    a += "</tr>";

                }
                out.write(a);
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
