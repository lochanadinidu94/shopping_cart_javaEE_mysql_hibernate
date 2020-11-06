<%-- 
    Document   : Admin_DashBord
    Created on : Oct 29, 2015, 4:44:45 PM
    Author     : Lochana
--%>

<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="Databasefile.HibernateConnection"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Message Box</title>


        <link media="all" rel="stylesheet" type="text/css" href="css/all.css" />

        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
        <script type="text/javascript">window.jQuery || document.write('<script type="text/javascript" src="js/jquery-1.7.2.min.js"><\/script>');</script>
        <script type="text/javascript" src="js/jquery.main.js"></script>

        <link media="all" rel="stylesheet" type="text/css" href="css/all.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css.css" />

        <style type="text/css">
            body{
                background: url(img/Backimage1.jpg) repeat top left;
            }
        </style>

    </head>
    <body>
        <div id="wrapper">
            <%@include file="adminhedder.jsp" %>
            <div style="position: absolute;left: 100px;top: 180px;width: 1250px;height: 470px">
                <table style="width: 1200px;height: 470px">
                    <tr style="height: 470px;">
                        <td style="width: 610px;">
                            <h3 style="margin-top: -250px;">Compose</h3>
                            <select class="form-control" style="width: 200px;" id="usr">
                                <%                                    Session ses = new HibernateConnection().getSessionFactory().openSession();
                                    Criteria cr = ses.createCriteria(Databasefile.User.class);
                                    List<Databasefile.User> ub = cr.list();
                                    for (Databasefile.User u : ub) {
                                        if (u.getUserType().equals("User")) {
                                %>
                                <option><%= u.getEmail()%></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                            <textarea style="width: 400px;height: 200px;" class="form-control" id="msg">
                            </textarea>
                            <button class="btn btn-info" onclick="save(usr.value, msg.value);">Send</button>
                        </td>
                        <td style="height: 470px;">
                            <div style="height: 470px; overflow-y: auto;">
                                <h3 style="margin-top: 0px;">In Box</h3>
                                <table class="table table-hover" style="overflow-y: auto;">
                                    <tr>
                                        <th>Date</th>
                                        <th style="width: 300px;">Message</th>
                                        <th>Remove</th>
                                    </tr>
                                    <%
                                        Criteria cb = ses.createCriteria(Databasefile.Msgadmin.class);
                                        List<Databasefile.Msgadmin> ma = cb.list();

                                        if (cb.list() != null) {
                                            for (Databasefile.Msgadmin madd : ma) {
                                    %>
                                    <tr>
                                        <td><%= madd.getDate()%></td>
                                        <td><%= madd.getMsg()%></td>
                                        <td><button class="btn btn-danger" onclick="rab(<%= madd.getIdMsgadmin()%>)">Remove</button></td>
                                    </tr>
                                    <%
                                            }
                                        }
                                    %>
                                </table>
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
        var obj;

        function checkBrowser() {
            if (window.XMLHttpRequest) {
                obj = new XMLHttpRequest();
            } else {
                obj = new ActiveXobject("Microfoft.ActiveXobject");
            }
        }
        function save(a, b) {
            checkBrowser();
            obj.onreadystatechange = function () {
                if (obj.readyState === 4 && obj.status === 200) {
//                     
                    alert(obj.responseText);
                    document.getElementById('msg').innerHTML = "";

                }
            };
            obj.open("POST", "savemsguser", true);
            obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            obj.send("email=" + a + '&msg=' + b);
        }
        function rab(a) {
            checkBrowser();
//            alert(a);
            obj.onreadystatechange = function () {
                if (obj.readyState === 4 && obj.status === 200) {
//                     
                    alert(obj.responseText);
                    location.reload();

                }
            };
            obj.open("POST", "removeadminsms", true);
            obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            obj.send("id=" + a);
        }
    </script>
</html>
