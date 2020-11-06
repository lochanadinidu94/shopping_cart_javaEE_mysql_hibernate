/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Lochana
 */
public class _mainsearch extends HttpServlet {

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

            System.out.println(request.getParameter("st"));

            if (request.getParameter("st").equals("Trouser")) {
                response.sendRedirect("_Trouser.jsp");
            } else if (request.getParameter("st").equals("Denim")) {
                response.sendRedirect("_Denims.jsp");

            } else if (request.getParameter("st").equals("T-Shirt")) {
                response.sendRedirect("_T-Shirt.jsp");

            } else if (request.getParameter("st").equals("Shirt")) {
                response.sendRedirect("_Shirt.jsp");

            } else if (request.getParameter("st").equals("Short")) {
                response.sendRedirect("_Short.jsp");

            } else if (request.getParameter("st").equals("Underwear")) {
                response.sendRedirect("_Underware.jsp");

            } else if (request.getParameter("st").equals("Belt")) {
                response.sendRedirect("_Belt.jsp");

            } else if (request.getParameter("st").equals("Shoes")) {
                response.sendRedirect("_Shose.jsp");

            } else if (request.getParameter("st").equals("Tie")) {
                response.sendRedirect("_Tie.jsp");

            } else if (request.getParameter("st").equals("Watch")) {
                response.sendRedirect("_Watch.jsp");

            } else {
                response.sendRedirect("https://www.google.lk/#q='" + request.getParameter("st") + " Online Shopping");
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
