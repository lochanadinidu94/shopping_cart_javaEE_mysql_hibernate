/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Databasefile.HibernateConnection;
import Databasefile.Model;
import java.io.IOException;
import java.io.PrintWriter;
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
 * @author Lochana
 */
public class savemodel extends HttpServlet {

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
                String cat,scat,brd,value;
                
                cat = request.getParameter("cat");
                scat = request.getParameter("scat");
                brd = request.getParameter("brd");
                value = request.getParameter("value");
                
                Session ses = new HibernateConnection().getSessionFactory().openSession();
                Transaction t = ses.beginTransaction();
                
                Criteria c1 = ses.createCriteria(Databasefile.Catagory1.class);
                c1.add(Restrictions.eq("name", cat));
                Databasefile.Catagory1 cat1 =  (Databasefile.Catagory1) c1.uniqueResult();
                
                Criteria c2 = ses.createCriteria(Databasefile.Catagory2.class);
                c2.add(Restrictions.eq("name", scat));
                c2.add(Restrictions.eq("catagory1", cat1));
                Databasefile.Catagory2 cat2 =  (Databasefile.Catagory2) c2.uniqueResult();
                        
                Criteria c3 = ses.createCriteria(Databasefile.Brand.class);
                c3.add(Restrictions.eq("name", brd));
                c3.add(Restrictions.eq("catagory1", cat1));
                c3.add(Restrictions.eq("catagory2", cat2));
                Databasefile.Brand br1 = (Databasefile.Brand) c3.uniqueResult();
                        
                Databasefile.Model mo = new Model();
                mo.setCatagory1(cat1);
                mo.setCatagory2(cat2);
                mo.setBrand(br1);
                mo.setName(value);
                
                ses.save(mo);
                t.commit();
                
                ses.close();
                out.write("Successful Model Registation");
                
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
