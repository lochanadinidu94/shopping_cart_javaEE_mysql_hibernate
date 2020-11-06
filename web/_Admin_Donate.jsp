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
        <title>Donates</title>


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
                    <div style="width:1200px ; height: 450px;overflow-y: auto;" >
                        <table style="width:1200px ;height: 450px;overflow-y: auto;">
                            <tr>
                                <td>
                                    <h3>Add Donate Plane</h3>
                                    <h4>Donate Reason</h4>
                                    <input type="text" id="dr" class="form-control" width="1000px">
                                    <button class="btn btn-info" onclick="adddonateresion(dr.value);">Add</button>
                                    <h4>Donate Reason List</h4>
                                    <table class="table table-hover">
                                        <tr>
                                            <th style="width: 900px">Reason</th>
                                            <th>Active</th>
                                        </tr>

                                        <%

                                            Session svs = new HibernateConnection().getSessionFactory().openSession();
                                            Criteria cro = svs.createCriteria(Databasefile.Donateresion.class);
                                            java.util.List<Databasefile.Donateresion> dr = cro.list();
                                            for (Databasefile.Donateresion dm : dr) {

                                        %>

                                        <tr>
                                            <td><%= dm.getName()%></td>
                                            <td><button onclick="cs(<%= dm.getIdDonateResion()%>);" class="btn btn-danger">Click</button></td>
                                        </tr>
                                        <%}%>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <h4>Current Donates</h4>
                                    <table class="table table-hover">
                                        <tr>
                                            <th style="width: 700px;">Donate Reason</th>
                                            <th>Amount</th>
                                            <th>User</th>
                                        </tr>

                                        <%

                                            Criteria crq = svs.createCriteria(Databasefile.Donateamount.class);
                                            java.util.List<Databasefile.Donateamount> dk = crq.list();
                                            for (Databasefile.Donateamount dp : dk) {

                                        %>

                                        <tr>
                                            <td><%= dp.getDonateresion().getName()%></td>
                                            <td><%= dp.getAmount()%></td>
                                            <td><%= dp.getUser().getEmail()%></td>
                                        </tr>

                                        <%}%>
                                    </table>
                                </td>
                            </tr>
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

        var obj;

        function checkBrowser() {
            if (window.XMLHttpRequest) {
                obj = new XMLHttpRequest();
            } else {
                obj = new ActiveXobject("Microfoft.ActiveXobject");
            }
        }

        function adddonateresion(a) {

            checkBrowser();
            obj.onreadystatechange = function () {
                if (obj.readyState === 4 && obj.status === 200) {
//                     
                    alert(obj.responseText);
                    location.reload();
                
                }
            };
            obj.open("POST", "adddonate", true);
            obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            obj.send("dr=" + a);
        }

         function cs(a) {

            checkBrowser();
            obj.onreadystatechange = function () {
                if (obj.readyState === 4 && obj.status === 200) {
//                     
                    alert(obj.responseText);
                    location.reload();
                
                }
            };
            obj.open("POST", "changecs", true);
            obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            obj.send("dr=" + a);
        }

    </script>
</html>
