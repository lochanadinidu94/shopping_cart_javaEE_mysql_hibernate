<%-- 
    Document   : Admin_DashBord
    Created on : Oct 29, 2015, 4:44:45 PM
    Author     : Lochana
--%>

<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="Databasefile.HibernateConnection"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Invoice</title>


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
                    <div  style="width:1000px ; height: 400px;overflow-y: auto;">
                        <table style="width:1000px ;height: 400px;overflow-y: auto;">
                            <tr>
                                <th>Date</th>
                                <th>Time</th>
                                <th>User</th>
                                <th>Shipping</th>
                                <th>Donate</th>
                                <th>Amount</th>
                            </tr>
                            <%                            Session ses = new HibernateConnection().getSessionFactory().openSession();
                                Criteria cr = ses.createCriteria(Databasefile.Invoice.class);
                                List<Databasefile.Invoice> inv = cr.list();
                                for (Databasefile.Invoice i : inv) {
                            %>
                            <tr>
                                <td><%= i.getDate()%></td>
                                <td><%= i.getTime()%></td>
                                <td><%= i.getUser().getEmail()%></td>
                                <td><%= i.getShAmount()%></td>
                                <td><%= i.getDonateamount().getAmount()%></td>
                                <td><%= i.getAmount()%></td>
                            </tr>
                            <%
                                }
                            %>
                        </table>
                    </div>
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
