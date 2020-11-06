<%-- 
    Document   : adminhedder
    Created on : Nov 14, 2015, 6:52:26 PM
    Author     : Lochana
--%>

<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="Databasefile.HibernateConnection"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <link media="all" rel="stylesheet" type="text/css" href="css/all.css" />

        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
        <script type="text/javascript">window.jQuery || document.write('<script type="text/javascript" src="js/jquery-1.7.2.min.js"><\/script>');</script>
        <script type="text/javascript" src="js/jquery.main.js"></script>

    </head>
    <body>

        <%

            try {
                Session adminpivilage = new HibernateConnection().getSessionFactory().openSession();

                HttpSession htt = request.getSession();

                Criteria crz = adminpivilage.createCriteria(Databasefile.Login.class);
                crz.add(Restrictions.eq("idLogin", Integer.valueOf(htt.getAttribute("adminid").toString())));
                Databasefile.Login lo = (Databasefile.Login) crz.uniqueResult();

                if (lo.getUser().getUserType().equals("User")) {
                    response.sendRedirect("_index.jsp");
                }
            } catch (Exception e) {
                response.sendRedirect("_Admin_Login.jsp");
            }

        %>

        <div id="content">
            <div class="c1">
                <div class="controls">

                    <div class="profile-box">

                        <a onclick="logout()" class="btn-on">On</a>
                    </div>
                </div>
                <div class="tabs">
                    <div id="" class="tab">
                        <article>
                            <div class="text-section">
                                <h1>Dashboard</h1>
                            </div>
                            <ul class="states">


                            </ul>
                        </article>
                    </div>

                </div>
            </div>
        </div>

        <aside id="sidebar">
            <strong class="logo"><a >lg</a></strong>
            <ul class="buttons">
                <li>
                    <a href="_Admin_DashBord.jsp" class="ico1"><h3 style="text-align: center; text-overflow: ellipsis-word; text-decoration: none; font-size: 17px;color: #ffffff; ">Status</h3></a>
                </li>
                <li>
                    <a href="_Admin_UserManagerment.jsp" class="ico2"><h3 style="text-align: center;text-decoration: none; font-size: 17px;color: #ffffff;">User</h3></a>
                </li>
                <li>
                    <a href="_Admin_Stock.jsp" class="ico3"><h3 style="text-align: center;text-decoration: none; font-size: 17px;color: #ffffff;">Stock</h3></a>
                </li>
                <li>
                    <a href="_Admin_ProductRegistration.jsp" class="ico4"><h3 style="text-align: center;  text-decoration: none; font-size: 17px;color: #ffffff;">P REG</h3></a>
                </li>
                <li>
                    <a href="_Admin_Account.jsp" class="ico5"><h3 style="text-align: center;text-decoration: none; font-size: 17px;color: #ffffff;">Invoice</h3></a>
                </li>
                <li>
                    <a href="_Admin_Delavary.jsp" class="ico8"><h3 style="text-align: center;text-decoration: none;font-size: 17px;color: #ffffff;">Delivery</h3></a>
                </li>
                <li>
                    <a href="_Admin_Advertisement.jsp" class="ico8"><h3 style="text-align: center;text-decoration: none;font-size: 17px;color: #ffffff;">Advert:</h3></a>
                </li>
                <li>
                    <a href="_Admin_Donate.jsp" class="ico8"><h3 style="text-align: center;text-decoration: none;font-size: 17px;color: #ffffff;">Donate</h3></a>
                </li>
                <li>
                    <a href="_Admin_SideShow.jsp" class="ico7"><h3 style="text-align: center;text-decoration: none; font-size: 17px;color: #ffffff;">Slider</h3></a>
                </li>
                <li>
                    <a href="_Admin_Msg.jsp" class="ico7"><h3 style="text-align: center;text-decoration: none; font-size: 17px;color: #ffffff;">Message</h3></a>
                </li>
                <li>
                    <a href="_Admin_FAQ.jsp" class="ico7"><h3 style="text-align: center;text-decoration: none; font-size: 17px;color: #ffffff;">FAQ</h3></a>
                </li>
                <!--                <li>
                                    <a href="_Admin_About.jsp" class="ico8"><h3 style="text-align: center;text-decoration: none; font-size: 12px">About:</h3></a>
                                </li>-->
            </ul>
            <span class="shadow"></span>
        </aside>

    </body>
    <script type="text/javascript">
        document.onmousedown = disableclick;
        status = "You Can't Right click in E-Market";
        function disableclick(event)
        {
            if (event.button == 2)
            {
                alert(status);
                return false;
            }
        }
        document.onkeydown = function (e) {
            if (e.which === 123) {
                ;
                return false;
            }
        };

        function logout() {
            checkBrowsera();
//            alert('sasasa');
            objm.onreadystatechange = function () {

                if (objm.readyState === 4 && objm.status === 200) {

                    window.location = '_Admin_Login.jsp';

                }
            };
            objm.open("POST", "adminlogout", true);
            objm.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            objm.send();
        }

        var objm;
        function checkBrowsera() {
            if (window.XMLHttpRequest) {
                objm = new XMLHttpRequest();
            } else {
                objm = new ActiveXobject("Microfoft.ActiveXobject");
            }
        }
    </script>
</html>
