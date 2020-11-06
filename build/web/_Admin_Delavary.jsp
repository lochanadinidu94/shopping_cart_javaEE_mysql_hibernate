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
        <title>Delivery</title>


        <link media="all" rel="stylesheet" type="text/css" href="css/all.css" />

        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
        <script type="text/javascript">window.jQuery || document.write('<script type="text/javascript" src="js/jquery-1.7.2.min.js"><\/script>');</script>
        <script type="text/javascript" src="js/jquery.main.js"></script>

        <link media="all" rel="stylesheet" type="text/css" href="css/all.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css.css" />

        <script>
            var obj;
            var id;

            function checkBrowser() {
                if (window.XMLHttpRequest) {
                    obj = new XMLHttpRequest();
                } else {
                    obj = new ActiveXobject("Microfoft.ActiveXobject");
                }
            }

            function save() {

                checkBrowser();
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {
                        alert(obj.responseText);
                        location.reload();
                        document.getElementById('PName').value = "";
                        document.getElementById('SAmount').value = "";
                        document.getElementById('km').value = "";
                        document.getElementById('ma').value = "";
                    }
                };

                var a = document.getElementById('PName').value;
                var b = document.getElementById('SAmount').value;
                var c = document.getElementById('km').value;
                var d = document.getElementById('ma').value;

                if (a != "" && b != "" && c != "" && d != "") {

                    obj.open("POST", "savedeveloveryprofile", true);
                    obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    obj.send("pn=" + a + "&sa=" + b + "&km=" + c + "&ma=" + d);

                } else {
                    alert('Try Again');
                }

            }

            function bl(a, b) {

                document.getElementById(a).style.display = "block";
                document.getElementById('wrapper').style.display = "none";

                document.getElementById('pidu').innerHTML = b;

            }
            function bk(a) {

                document.getElementById(a).style.display = "none";
                document.getElementById('wrapper').style.display = "block";
            }

            function update(a) {
                checkBrowser();
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {
                        alert(obj.responseText);
                        location.reload();
                    }
                };

                var b = document.getElementById('sau').value;
                var c = document.getElementById('kmu').value;
                var d = document.getElementById('mau').value;

                if (b != "" && c != "" && d != "") {

                    obj.open("POST", "updatedeveloveryprofile", true);
                    obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    obj.send("id=" + document.getElementById('pidu').innerHTML + "&sa=" + document.getElementById('sau').value + "&km=" + document.getElementById('kmu').value + "&ma=" + document.getElementById('mau').value);
                } else {
                    alert('Try Again');
                }

            }
        </script>


    </head>
    <body>

        <div id="popUpDiv2" style="display:none;" >
            <center>
                <table border="0" width="350px" height = "250px">
                    <tr><td><h3><center>Update</center></h3></td></tr>
                    <tr>
                        <td><h4>Start Amount</h4></td>
                        <td><input type="text" id="sau" class="form-control" placeholder="00.00" style="text-align: right;"/></td>
                    </tr>
                    <tr>
                        <td><h4>Pay For 1km</h4></td>
                        <td><input type="text" id="kmu" class="form-control" placeholder="00.00" style="text-align: right;"/></td>
                    </tr>
                    <tr>
                        <td><h4>Max Amount</h4></td>
                        <td><input type="text" id="mau" class="form-control" placeholder="00.00" style="text-align: right;"/></td>
                    </tr>
                    <tr>
                        <td><p id="pidu" style="display: none"></p></td>
                    </tr>
                    <tr><td><button class="btn btn-info" style="position: relative;left: 20px;top: 20px;" onclick="update()">Update</button></td><td><button class="btn btn-danger" style="position: relative;left: 20px;top: 20px;" onclick="bk('popUpDiv2')">Close</button></td></tr>

                </table>
            </center>
        </div>

        <div id="wrapper">
            <%@include file="adminhedder.jsp" %>

            <div style="position: absolute;left: 100px;top: 180px;width: 1250px;height: 470px">

                <table>
                    <tr>
                        <td>
                            <div style="width: 600px; height:500; ">
                                <center>
                                    <table>
                                        <tr>
                                            <td><h4>Profile Name</h4></td>
                                            <td><input type="text" id="PName" class="form-control"/></td>
                                        </tr>
                                        <tr>
                                            <td><h4>Start Amount</h4></td>
                                            <td><input type="text" id="SAmount" class="form-control" placeholder="00.00" style="text-align: right;"/></td>
                                        </tr>
                                        <tr>
                                            <td><h4>Pay For 1km</h4></td>
                                            <td><input type="text" id="km" class="form-control" placeholder="00.00" style="text-align: right;"/></td>
                                        </tr>
                                        <tr>
                                            <td><h4>Max Amount</h4></td>
                                            <td><input type="text" id="ma" class="form-control" placeholder="00.00" style="text-align: right;"/></td>
                                        </tr>
                                        <tr>
                                            <td><input type="submit" value="Save" class="btn btn-default" style="position: relative;left: 225px;" onclick="save()"></td>
                                        </tr>
                                    </table>
                                </center>
                            </div>
                        </td>
                        <td>
                            <div style="width: 600px; height:500; ">
                                <center>
                                    <table class="table table-hover" style="overflow-y: auto;height: auto;">
                                        <tr>
                                            <th>Profile Name</th>
                                            <th>Start Amount</th>
                                            <th>Pay For 1km</th>
                                            <th>Max Amount</th>
                                            <th>Update</th>
                                        </tr>
                                        <%
                                            try {

                                                Session ses = new HibernateConnection().getSessionFactory().openSession();
                                                Criteria cr = ses.createCriteria(Databasefile.Delavary.class);
                                                List<Databasefile.Delavary> li = cr.list();
                                                for (Databasefile.Delavary de : li) {
                                        %>
                                        <tr>
                                            <td><%= de.getName()%></td>
                                            <td><%= de.getStartAmount()%></td>
                                            <td><%= de.getPayForKm()%></td>
                                            <td><%= de.getMaxAmount()%></td>
                                            <td><button class="btn btn-info" onclick="bl('popUpDiv2',<%= de.getIdDelavary()%>);">Click</button></td>
                                        </tr>
                                        <%
                                                }
                                            } catch (Exception e) {
                                            }
                                        %>
                                    </table>
                                </center>
                            </div>
                        </td>
                    </tr>
                </table>
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