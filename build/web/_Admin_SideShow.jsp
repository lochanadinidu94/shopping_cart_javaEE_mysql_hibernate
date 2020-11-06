<%-- 
    Document   : Admin_DashBord
    Created on : Oct 29, 2015, 4:44:45 PM
    Author     : Lochana
--%>

<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="Databasefile.HibernateConnection"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Slide Show</title>


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

        <script type="text/javascript">
            var obj;
            function checkBrowser() {
                if (window.XMLHttpRequest) {
                    obj = new XMLHttpRequest();
                } else {
                    obj = new ActiveXobject("Microfoft.ActiveXobject");
                }
            }

            function removeimg(a) {
                checkBrowser();

                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {
                        alert(obj.responseText);
                        location.reload();
                    }
                };

                obj.open("POST", "imageremove", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("iid=" + a);
            }

            function abc(v) {
                checkBrowser();

                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {
                        document.getElementById("im").src = obj.responseText;
                    }
                };

                obj.open("POST", "imagelord", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("iid=" + v);
            }
        </script>


    </head>
    <body>
        <div id="wrapper">
            <%@include file="adminhedder.jsp" %>
            <div style="position: absolute;left: 100px;top: 180px;width: 1250px;height: 470px">
                <table>
                    <tr>
                        <td>
                            <div style="width: 1230px;height: 100px;background-color: seashell;">
                                <form action="UPSSI" method="post" enctype="multipart/form-data" name="imgup">
                                    <input type="file" name="Img1" id="im1" class="btn btn-lg">
                                    <input type="submit" name="up" value="Uplord" class="btn btn-info" style="margin-left: 20px;">
                                </form>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <div  style="width:1000px ; height: 300px;overflow-y: auto;">
                                <table style="width:1000px ;height: auto;overflow-y: auto;">
                                    <tr>
                                        <th>Image ID</th>
                                        <th>Path</th>
                                        <th>Image</th>
                                        <th>Remove</th>
                                    </tr>
                                    <%                                        Session ses = new HibernateConnection().getSessionFactory().openSession();
                                        org.hibernate.Criteria cr = ses.createCriteria(Databasefile.Sliderimage.class);
                                        List<Databasefile.Sliderimage> sli = cr.list();
                                        for (Databasefile.Sliderimage s : sli) {
                                    %>
                                    <tr>
                                        <td ><%= s.getIdSliderImage()%></td>
                                        <td ><%= s.getImage()%></td>

                                        <td><button class="btn btn-default" onclick="abc(<%= s.getIdSliderImage()%>)">Click</button></td>

                                        <td><button class="btn btn-danger" onclick="removeimg(<%= s.getIdSliderImage()%>)">Click</button></td>
                                    </tr>
                                    <%}%>
                                </table>
                            </div>
                        </td>
                        <td>
                            <img style="margin-left: -500px;" width="300px"  height="150" class="img-circle" id="im">
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
