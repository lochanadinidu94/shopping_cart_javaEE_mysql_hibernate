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
        <title>User Management</title>


        <link media="all" rel="stylesheet" type="text/css" href="css/all.css" />

        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
        <script type="text/javascript">window.jQuery || document.write('<script type="text/javascript" src="js/jquery-1.7.2.min.js"><\/script>');</script>
        <script type="text/javascript" src="js/jquery.main.js"></script>

        <link media="all" rel="stylesheet" type="text/css" href="css/all.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css.css" />

        <link href="css/popup_styles_admin.css" rel="stylesheet" type="text/css" />

        <style type="text/css">
            body{
                background: url(img/Backimage1.jpg) repeat top left;
            }
        </style>

        <script type="text/javascript">
            var obj = "";
            function checkBrowser() {
                if (window.XMLHttpRequest) {
                    obj = new XMLHttpRequest();
                } else {
                    obj = new ActiveXobject("Microfoft.ActiveXobject");
                }
            }

            function bl(a, b, c) {

                if (c == 'Info') {
                    info(b);

                    document.getElementById('sp').innerHTML = "";
                } else {
                    update(b);
                }

                document.getElementById(a).style.display = "block";
                document.getElementById('wrapper').style.display = "none";
            }
            function bk(a) {

                document.getElementById(a).style.display = "none";
                document.getElementById('wrapper').style.display = "block";
            }


            function info(id) {
                checkBrowser();
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {

                        document.getElementById('Gen').innerHTML = JSON.parse(obj.responseText).Gen;
                        document.getElementById('Pas').innerHTML = JSON.parse(obj.responseText).Pas;

                    }
                };
                obj.open("POST", "lorduserinfo", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("uid=" + id);
            }
            function update(id) {
                checkBrowser();
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {
                        alert(obj.responseText);
                        location.reload();
                    }
                };
                obj.open("POST", "changestatus", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("uid=" + id);

            }
            function showpass() {
                checkBrowser();
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {
                        var t = obj.responseText;
                        document.getElementById('sp').innerHTML = t;
                    }
                };
                var a = document.getElementById('Pas').innerHTML;
                obj.open("POST", "checkpass", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("pass=" + a);
            }
            function av1(a, b) {

                checkBrowser();

                obj.onreadystatechange = function () {

                    if (obj.readyState === 4 && obj.status === 200) {
                        document.getElementById('ultr').innerHTML = obj.responseText;
                    }

                };
                obj.open("POST", "LordAdminUserTable", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("msg=" + a + "&b=" + b);
            }
        </script>
    </head>
    <body onload="av1('_No', '')">

        <div id="popUpDiv" style="display:none;" >
            <center>
                <table border="0" style="position: relative; top: 50px;">
                    <tr>
                        <td><h3><center>Information</center></h3></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td width="275px">Gender</td>
                        <td width="275px"><h5 style="color: tomato;"><label id="Gen"></label></h5></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td width="275px">Password</td>
                        <td width="275px"><h5 style="color: tomato;"><label id="Pas"></label></h5></td>
                        <td><button class="btn btn-default" onclick="showpass();">Show</button></td>
                    </tr>
                    <tr>
                        <td><h5 style="color: tomato;"><label id="sp"></label></h5></td>
                    </tr>
                </table>
                <button class="btn btn-danger" style="position: relative;" onclick="bk('popUpDiv')">Close</button>
            </center>
        </div>




        <div id="wrapper">
            <%@include file="adminhedder.jsp" %>
            <div style="position: absolute;left: 100px;top: 180px;width: 1250px;height: 470px">
                <table>
                    <tr>
                        <td>Fist Name</td>
                        <td><input type="text" id="fn" class="form-control" onkeypress="av1(this.value, 'co')"></td>

                        <!--                        <td style="padding-left: 20px;">NIC</td>
                                                <td><input type="text" id="nic" class="form-control"></td>-->

                        <td style="padding-left: 20px;"></td>
                        <td>
                            <!--                            <select id="us1" class="form-control" onselect="av1(this.value)">
                            
                            <%
                                Session s = new HibernateConnection().getSessionFactory().openSession();
                                Criteria co = s.createCriteria(Databasefile.UserStatus.class);
                                List<Databasefile.UserStatus> usl = co.list();
                                for (Databasefile.UserStatus us1 : usl) {

                            %>
                            <option><%= us1.getName()%></option>
                            <%}%>
                        </select>-->
                        </td>
                    </tr>
                    <tr>
                    <div>
                        <table class="table table-hover" style="height: auto;" style="overflow-y: scroll;" id="ultr">

                        </table>
                    </div>
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
