/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Databasefile.HibernateConnection;
import Databasefile.Ratting;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.derby.vti.Restriction;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Lochana pakaya
 */
public class applyrating extends HttpServlet {

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
                int iid = Integer.valueOf(request.getParameter("iid"));
                String sta = request.getParameter("sta");
                
                Session ses = new HibernateConnection().getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();

                Criteria cr = ses.createCriteria(Databasefile.Invoice.class);
                cr.add(Restrictions.eq("idInvoice", Integer.valueOf(iid)));
                Databasefile.Invoice inv = (Databasefile.Invoice) cr.uniqueResult();

                Criteria cr1 = ses.createCriteria(Databasefile.Invoiceinformation.class);
                cr1.add(Restrictions.eq("invoice", inv));
                Databasefile.Invoiceinformation ii = (Databasefile.Invoiceinformation) cr1.uniqueResult();

                Criteria cre = ses.createCriteria(Databasefile.Ratting.class);
                cre.add(Restrictions.eq("invoiceinformation", ii));
                Databasefile.Ratting rat= (Databasefile.Ratting) cre.uniqueResult();
                

                if (rat != null) {
                    
                    rat.setStates(sta);
                    ses.update(rat);
                    
                } else {
                    Databasefile.Ratting rat1 = new Ratting();
                    rat1.setInvoiceinformation(ii);
                    rat1.setStates(sta);
                    rat1.setProduct(ii.getProduct());
                    ses.save(rat1);
                }
                
                tr.commit();
                ses.close();
                
                out.write("Successfully Update");
                
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
