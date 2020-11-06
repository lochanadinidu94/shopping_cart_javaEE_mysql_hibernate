/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Databasefile.HibernateConnection;
import Databasefile.Productimage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Lochana
 */
public class Uplord extends HttpServlet {

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
                String imgTitle = null;
                String path = null;
                String p1 = null;

                Session ses = new HibernateConnection().getSessionFactory().openSession();
                Transaction t = ses.beginTransaction();

                Criteria cr = ses.createCriteria(Databasefile.Product.class);
                cr.add(Restrictions.eq("idProduct", Integer.valueOf(it.get(4).getString())));
                System.out.println(request.getParameter("pid"));
                Databasefile.Product pr1 = (Databasefile.Product) cr.uniqueResult();

                Databasefile.Productimage pi = new Productimage();
                pi.setProduct(pr1);

                String ip1 = "", ip2 = "", ip3 = "", ip4 = "";

                for (FileItem f : it) {
                    if (f.isFormField()) {

                        if (f.getFieldName().equals(request.getParameter("Img"))) {
                            imgTitle = f.getString();
                        }

                    } else {
                        
                        path = "up/" + System.currentTimeMillis() % 10 + "_" + f.getName();
                        
                        
                        File ff = new File(request.getServletContext().getRealPath("/") + path);
//                        p1 = "FWP_UP‍‍‍‍‍‍‍\\" + System.currentTimeMillis() % 10 + "_" + f.getName()
//                        path = "E:\\My Work Place\\Web\\FWP_UP‍‍‍‍‍‍‍\\" + System.currentTimeMillis() % 10 + "_" + f.getName();
//                        File ff = new File(path);
                        f.write(ff);
                        if (nof == 0) {
                            ip1 = path;
                            pi.setUrl1(ip1);
                        } else if (nof == 1) {
                            ip2 = path;
                            pi.setUrl2(ip2);
                        } else if (nof == 2) {
                            ip3 = path;
                            pi.setUrl3(ip3);
                        } else if (nof == 3) {
                            ip4 = path;
                            pi.setUrl4(ip4);

                        }
                        nof++;
                    }
                }
                ses.save(pi);
                t.commit();
                ses.close();
                response.sendRedirect("_Admin_ProductRegistration.jsp");
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

    private File myFile;
    private String myFileContentType;
    private String myFileFileName;
    private String destPath;

    /**
     * @return the myFile
     */
    public File getMyFile() {
        return myFile;
    }

    /**
     * @param myFile the myFile to set
     */
    public void setMyFile(File myFile) {
        this.myFile = myFile;
    }

    /**
     * @return the myFileContentType
     */
    public String getMyFileContentType() {
        return myFileContentType;
    }

    /**
     * @param myFileContentType the myFileContentType to set
     */
    public void setMyFileContentType(String myFileContentType) {
        this.myFileContentType = myFileContentType;
    }

    /**
     * @return the myFileFileName
     */
    public String getMyFileFileName() {
        return myFileFileName;
    }

    /**
     * @param myFileFileName the myFileFileName to set
     */
    public void setMyFileFileName(String myFileFileName) {
        this.myFileFileName = myFileFileName;
    }

    /**
     * @return the destPath
     */
    public String getDestPath() {
        return destPath;
    }

    /**
     * @param destPath the destPath to set
     */
    public void setDestPath(String destPath) {
        this.destPath = destPath;
    }
}
