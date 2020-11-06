<%-- 
    Document   : Admin_DashBord
    Created on : Oct 29, 2015, 4:44:45 PM
    Author     : Lochana
--%>

<%@page import="org.hibernate.Criteria"%>
<%@page import="Databasefile.HibernateConnection"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Latest Status</title>


        <link media="all" rel="stylesheet" type="text/css" href="css/all.css" />

        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
        <script type="text/javascript">window.jQuery || document.write('<script type="text/javascript" src="js/jquery-1.7.2.min.js"><\/script>');</script>
        <script type="text/javascript" src="js/jquery.main.js"></script>

        <link media="all" rel="stylesheet" type="text/css" href="css/all.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css.css" />

       

    </head>
    <body>
        <div id="wrapper">
            <%@include file="adminhedder.jsp" %>
            <div style="position: absolute;left: 100px;top: 180px;width: 1250px;height: 470px">
                <center>
                    <table height="150px" width="1200px">
                        <%
                            try {

                                Session ses = new HibernateConnection().getSessionFactory().openSession();
                                Criteria c1 = ses.createCriteria(Databasefile.User.class);
                                int i1 = c1.list().size();
                                Criteria c2 = ses.createCriteria(Databasefile.Product.class);
                                int i2 = c2.list().size();
                                Criteria c3 = ses.createCriteria(Databasefile.Invoice.class);
                                int i3 = c3.list().size();
                                Criteria c4 = ses.createCriteria(Databasefile.WishList.class);
                                int i4 = c4.list().size();
                        %>
                        <tr>
                            <td>
                        <center>
                            <table>
                                <tr><h2>USERS</h2></tr>

                                <tr  style="background-color: #dff905;"><h3 style="color: #FFBF00;"><%= i1%></h3></tr>
                            </table>
                        </center>
                        </td>
                        <td>
                        <center>
                            <table>
                                <tr><h2>PRODUCTS</h2></tr>
                                <tr style="background-color: #dff905;"><h3 style="color: #FFBF00;"><%= i2%></h3></tr>
                            </table>
                        </center>
                        </td>
                        <td>
                        <center>
                            <table>
                                <tr><h2>INVOICES</h2></tr>
                                <tr style="background-color: #dff905;"><h3 style="color: #FFBF00;"><%= i3%></h3></tr>
                            </table> 
                        </center>
                        </td>
                        <td>
                        <center>
                            <table>
                                <tr><h2>Wish List</h2></tr>
                                <tr style="background-color: #dff905;"><h3 style="color: #FFBF00;"><%= i4%></h3></tr>
                            </table> 
                        </center>
                        </td>
                        </tr>
                        <%} catch (Exception e) {
                            }%>
                    </table>
                </center>
            </div>
        </div>

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
    </script>
</html>
