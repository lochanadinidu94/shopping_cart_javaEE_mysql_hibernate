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
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Lochana
 */
public class lordUserList extends HttpServlet {

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

                String P = request.getParameter("pid");
                String T = request.getParameter("type");
                
                System.out.println(P);
                System.out.println(T);

                Session ses = new HibernateConnection().getSessionFactory().openSession();
                Criteria cr = ses.createCriteria(Databasefile.User.class);

                JSONObject job = new JSONObject();
                JSONArray joa = new JSONArray();

                if (P.equals("_No") && T.equals("_No")) {
                    List<Databasefile.User> liu = cr.list();
                    for (User liu1 : liu) {
                        HashMap hm = new HashMap();
                        hm.put("ID", liu1.getIdUser());
                        hm.put("Fist", liu1.getFistName());
                        hm.put("Last", liu1.getLastName());
                        hm.put("NIC", liu1.getNic());
                        hm.put("Address", liu1.getAddress1() + "" + liu1.getAddress2());
                        hm.put("City", liu1.getCity());
                        hm.put("Dis", liu1.getDistrict());
                        hm.put("Mobile", liu1.getMobileNo());
                        hm.put("Email", liu1.getEmail());
                        hm.put("Status", liu1.getUserStatus().getName());
                        joa.put(hm);
                        
                    }
                } else {
                }
                job.put("data", joa);
                ses.close();
                out.write(job.toString());
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
