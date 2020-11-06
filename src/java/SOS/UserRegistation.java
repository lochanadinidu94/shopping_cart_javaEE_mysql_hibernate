/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import Class.EmailHtml;
import Class.emailvalidate;
import Databasefile.Gender;
import Databasefile.Login;
import Databasefile.Loginreport;
import Databasefile.User;
import Databasefile.UserStatus;
import Databasefile.Userfeedback;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Lochana
 */
@WebServlet(name = "UserRegistation", urlPatterns = {"/UserRegistation"})
public class UserRegistation extends HttpServlet {

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
                RequestDispatcher rd = request.getRequestDispatcher("/_userregistation_login.jsp");

                String fname = request.getParameter("fname");
                String lname = request.getParameter("lname");
                String nic = request.getParameter("nic");
                String gender = request.getParameter("gender");
                String homeaddress = request.getParameter("homeaddress");
                String street = request.getParameter("street");
                String city = request.getParameter("city");
                String district = request.getParameter("district");
                String mobile = request.getParameter("mobile");
                String email = request.getParameter("email");
                String password = request.getParameter("password1");
                String vlidationcode = String.valueOf(System.nanoTime()).substring(3, 7);
                
                EncryptDecrypt ed = new EncryptDecrypt();
                String password1 = ed.encrypttwo(password);

                HashMap hs_login = new HashMap();
                HttpSession ses_login = request.getSession();

                if (fname.isEmpty() || lname.isEmpty() || nic.isEmpty() || gender.isEmpty() || homeaddress.isEmpty() || street.isEmpty() || city.isEmpty() || district.isEmpty() || mobile.isEmpty() || email.isEmpty() || password1.isEmpty()) {

                    hs_login.put("login_msg", "Enter all information and submit later");
                    ses_login.setAttribute("login_msg", hs_login);
                    rd.forward(request, response);
                } else {
                    if (emailvalidate.validateEmailID(email)) {

                        if (mobile.length() < 10) {
                            hs_login.put("login_msg", "Invalied Mobile No");
                            ses_login.setAttribute("login_msg", hs_login);
                            rd.forward(request, response);
                        } else {
                            Session s = new Databasefile.HibernateConnection().getSessionFactory().openSession();
                            Transaction tr = s.beginTransaction();
                            Databasefile.User u = new User();
                            u.setFistName(fname);
                            u.setLastName(lname);
                            u.setNic(nic);
                            u.setAddress1(homeaddress);
                            u.setAddress2(street);
                            u.setCity(city);
                            u.setDistrict(district);
                            u.setMobileNo(mobile);
                            u.setEmail(email);
                            u.setUserType("User");

                            Criteria c = s.createCriteria(Databasefile.Gender.class);
                            c.add(Restrictions.eq("name", gender));
                            Gender g = (Gender) c.uniqueResult();

                            u.setGender(g);//Inactive

                            Criteria c1 = s.createCriteria(Databasefile.UserStatus.class);
                            c1.add(Restrictions.eq("name", "Inactive"));
                            UserStatus us = (UserStatus) c1.uniqueResult();

                            u.setUserStatus(us);

                            Databasefile.Login l = new Login();
                            l.setEmail(email);
                            l.setPassword(password1);
                            l.setValidation(vlidationcode);
                            l.setUser(u);

                            Databasefile.Userfeedback uf = new Userfeedback();
                            uf.setName("50%");
                            uf.setUser(u);

                            s.save(u);
                            s.save(l);
                            s.save(uf);
                            tr.commit();
                            //http://localhost:8080/Final_AJD_Project/_activation.jsp
                            String html = "<table width=\"750px\" height=\"500\">\n"
                                    + "            <tr height=\"150px\" style=\"background-color: #A0A0A4\">\n"
                                    + "            <td><center><h1>Activation Key</h1></center></td>\n"
                                    + "        </tr>\n"
                                    + "        <tr height=\"250px\" style=\"background-color: #FFBF00\">\n"
                                    + "            <td><center><h3 style=\"font-size: 25px\" >'" + vlidationcode + "'</h3></center></td>\n"
                                    + "        </tr>\n"
                                    + "        <tr height=\"100\" style=\"background-color: #A0A0A4\">\n"
                                    + "        <td><center><a href=\"http://localhost:8080/Final_AJD_Project/_activation.jsp\">Click & Activate Account</a></center></td> \n"
                                    + "    </tr>\n"
                                    + "</table>";

                            EmailHtml.htmlcontent(email, "drpcsoftwaresolution@gmail.com", "dinidu066", html, "Activation Key - (E-Market (pvt) ltd.)");

                            hs_login.put("login_msg", "Successfull Registation !! Log your email and get your activation code");
                            ses_login.setAttribute("login_msg", hs_login);
                            s.close();
                            rd.forward(request, response);
                        }

                    } else {
                        hs_login.put("login_msg", "Invalied Email Address");
                        ses_login.setAttribute("login_msg", hs_login);
                        
                        rd.forward(request, response);
                    }
                }

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
        //processRequest(request, response);
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
