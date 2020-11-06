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
        <title>FAQ</title>


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
                <center>
                    <table width="1200px" height="400px" >
                        <tr>
                            <td style="width:600px; height: 400px;">
                                <div style="width:600px; height: 400px;overflow-y: auto;">
                                    <center>
                                        <form action="../savefaq" method="">
                                            <table width="600px">
                                                <tr>
                                                    <td>
                                                        <h4>FAQ</h4>
                                                        <h5 style="color: orange">Question</h5>
                                                        <textarea style="width: 500px;height: 100px" class="form-control" name="q">
                                                        
                                                        </textarea>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <h5 style="color: orange">Answer</h5>
                                                        <textarea style="width: 500px;height: 100px" class="form-control" name="a">
                                                        
                                                        </textarea>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><input type="submit" class="btn btn-default" value="Save"></td>
                                                </tr>
                                            </table>
                                        </form>
                                    </center>
                                </div>
                            </td>
                            <td>

                                <div style="width:600px; height: 450px;overflow-y: auto;">

                                    <h3 style="color: orange;margin-left: 10px;" >Other</h3>
                                    <form action="saveq" method="POST">
                                        <textarea style="width: 500px;height: 150px; margin-left: 10px;" class="form-control" name="a">
                                    
                                        </textarea>
                                        <input type="submit" class="btn btn-default" style="margin-left: 10px;" value="Send">
                                    </form>

                                    <table width="600px"  style=" height: auto;overflow-y: auto;">
                                        <%                                            Session ses = new HibernateConnection().getSessionFactory().openSession();
                                            Criteria ces1 = ses.createCriteria(Databasefile.Quackanswer.class);
                                            List<Databasefile.Quackanswer> cl1 = ces1.list();
                                            for (Databasefile.Quackanswer b1 : cl1) {

                                                if (b1 != null) {
                                        %>
                                        <tr>
                                            <td>
                                                <h4 style="color: orange;margin-left: 10px;"><%= b1.getName()%></h4>
                                                <h5 style="margin-left: 10px;"><%= b1.getData()%></h5>
                                            </td>
                                        </tr>
                                        <%}
                                            }%>
                                    </table>
                                </div>

                            </td>
                        </tr>
                    </table>
                </center>
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
