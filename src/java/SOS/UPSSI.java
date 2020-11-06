/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Databasefile.HibernateConnection;
import Databasefile.Sliderimage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Lochana
 */
public class UPSSI extends HttpServlet {

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

                System.out.println("Methanata awaaaa");

                int nof = 0;
                FileItemFactory fi = new DiskFileItemFactory();
                ServletFileUpload up = new ServletFileUpload(fi);
                List<FileItem> it = up.parseRequest(request);
                if (it.size() == 0) {
                    HttpSession ses_login = request.getSession();
                    ses_login.setAttribute("msg", "Try Again");
                } else {
                    String imgTitle = null;
                    String path = null;
                    String p1 = null;

                    Session ses = new HibernateConnection().getSessionFactory().openSession();
                    Transaction t = ses.beginTransaction();

                    String ip1 = "";

                    Databasefile.Sliderimage si = new Sliderimage();

                    for (FileItem f : it) {
                        if (f.isFormField()) {

                            if (f.getFieldName().equals(request.getParameter("Img"))) {
                                imgTitle = f.getString();
                            }

                        } else {

                            path = "up/" + System.currentTimeMillis() % 10 + "_" + f.getName();
                            File ff = new File(request.getServletContext().getRealPath("/") + path);

                            f.write(ff);
                            if (nof == 0) {
                                ip1 = path;
                                si.setImage(ip1);
                            }
                            nof++;
                        }
                    }
                    ses.save(si);
                    t.commit();
                    ses.close();
                }
                response.sendRedirect("_Admin_SideShow.jsp");
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
