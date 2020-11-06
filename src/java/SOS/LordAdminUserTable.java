/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Databasefile.HibernateConnection;
import Databasefile.User;
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
public class LordAdminUserTable extends HttpServlet {

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

                String msg = request.getParameter("msg");

                a += "<tr>";
                a += "<th>Fist Name</th>";
                a += "<th>Last Name</th>";
                a += "<th>NIC</th>";
                a += "<th>Address</th>";
                a += "<th>City</th>";
                a += "<th>District</th>";
                a += "<th>Mobile</th>";
                a += "<th>E-Mail</th>";
                a += "<th>Status</th>";
                a += "<th>Information</th>";
                a += "<th>Update</th>";
                a += "</tr>";
                Session s = new HibernateConnection().getSessionFactory().openSession();
                Criteria cr = s.createCriteria(Databasefile.User.class);
                if (msg.equals("_No") || msg.isEmpty() || msg == null) {
                } else {
                    cr.add(Restrictions.like("fistName", "%" + msg + "%"));

                }
                List<Databasefile.User> ui = cr.list();
                for (Databasefile.User u : ui) {
                    if (u.getUserType().equals("Super Admin")||u.getUserType().equals("Admin")) {

                    } else {
                        a += "<tr id='alldata'>";
                        a += "    <td>" + u.getFistName() + "</td>";
                        a += "    <td>" + u.getLastName() + "</td>";
                        a += "    <td>" + u.getNic() + "</td>";
                        a += "    <td>" + u.getAddress1() + "" + u.getAddress2() + "</td>";
                        a += "    <td>" + u.getCity() + "</td>";
                        a += "    <td>" + u.getDistrict() + "</td>";
                        a += "    <td>" + u.getMobileNo() + "</td>";
                        a += "    <td>" + u.getEmail() + "</td>";
                        a += "    <td>" + u.getUserStatus().getName() + "</td>";
                        a += "<td><button onclick=\"bl('popUpDiv','" + u.getIdUser() + "', 'Info');\" class=\"btn btn-info\">Click</button></td>";
                        a += "<td><button onclick=\"update('" + u.getIdUser() + "');\" class=\"btn btn-info\">Change Status</button></td>";
                        a += "</tr>";
                    }
                }
                s.close();
                out.write(a);
            } catch (Exception e) {
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
