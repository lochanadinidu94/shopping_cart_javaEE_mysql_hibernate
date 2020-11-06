/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Databasefile.HibernateConnection;
import Databasefile.Image;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.imageio.ImageIO;
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
 * @author Lochana pakaya
 */
public class UplordAddImg extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    int w, h = 0;

    private BufferedImage resizeImage(BufferedImage originalImage, int type) {
        BufferedImage resizedImage = new BufferedImage(w, h, type);
        Graphics2D g = resizedImage.createGraphics();
        g.drawImage(originalImage, 0, 0, w, h, null);
        g.dispose();

        return resizedImage;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            //Integer.valueOf(it.get(4).getString())
            try {
                System.out.println("Methanata awaaaa yko");

                int nof = 0;
                FileItemFactory fi = new DiskFileItemFactory();
                ServletFileUpload up = new ServletFileUpload(fi);

                List<FileItem> it = up.parseRequest(request);
                String imgTitle = null;
                String path = null;
                String p1 = null;

                Session ses = new HibernateConnection().getSessionFactory().openSession();
                Transaction t = ses.beginTransaction();

                Criteria cr = ses.createCriteria(Databasefile.Addreg.class);
                cr.add(Restrictions.eq("idAddreg", Integer.valueOf(it.get(4).getString())));
                Databasefile.Addreg ar = (Databasefile.Addreg) cr.uniqueResult();

                String palne = ar.getPlan();

                if (palne.equals("Silver")) {
                    w = 200;
                    h = 100;
                } else if (palne.equals("Gold")) {
                    w = 500;
                    h = 300;
                } else if (palne.equals("Platinum")) {
                    w = 1000;
                    h = 500;
                }

                Databasefile.Image pi = new Image();
                pi.setAddreg(ar);

                String ip1 = "", ip2 = "", ip3 = "", ip4 = "";

                for (FileItem f : it) {
                    if (f.isFormField()) {

                        if (f.getFieldName().equals(request.getParameter("Img"))) {
                            imgTitle = f.getString();
                        }

                    } else {

                        path = "up/" + System.currentTimeMillis() % 10 + "_" + f.getName();

//                        File fk = (File) f;

//                        BufferedImage originalImage = ImageIO.read(fk);
//                        int type = originalImage.getType() == 0 ? BufferedImage.TYPE_INT_ARGB : originalImage.getType();
                        File ff = new File(request.getServletContext().getRealPath("/") + path);

//                        BufferedImage resizeImageJpg = resizeImage(originalImage, type);
//                        ImageIO.write(resizeImageJpg, "jpg", ff);
                        f.write(ff);
                        
                        if (nof == 0) {
                            ip1 = path;
                            pi.setIm1(ip1);
                        } else if (nof == 1) {
                            ip2 = path;
                            pi.setIm2(ip2);
                        } else if (nof == 2) {
                            ip3 = path;
                            pi.setIm3(ip3);
                        } else if (nof == 3) {
                            ip4 = path;
                            pi.setIm4(ip4);

                        }
                        nof++;
                    }
                }
                ses.save(pi);
                t.commit();
                ses.close();
                response.sendRedirect("_ThankYouForCheckout.jsp");
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
