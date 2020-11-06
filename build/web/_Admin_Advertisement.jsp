<%-- 
    Document   : _Admin_Stock
    Created on : Nov 27, 2015, 6:31:51 AM
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

        <link media="all" rel="stylesheet" type="text/css" href="css/all.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css.css" />
        <link href="css/popup_styles_admin.css" rel="stylesheet" type="text/css" />

        <script type="text/javascript">

            var obj;

            function checkBrowser() {
                if (window.XMLHttpRequest) {
                    obj = new XMLHttpRequest();
                } else {
                    obj = new ActiveXobject("Microfoft.ActiveXobject");
                }
            }

            function update(a) {

                checkBrowser();

                obj.onreadystatechange = function () {

                    if (obj.readyState === 4 && obj.status === 200) {

                        alert(obj.responseText);
                        window.location.reload();

                    }

                };
                obj.open('POST', 'updateadminaddstates', true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send('addid=' + a + '&sta=' + document.getElementById(a).value);
            }

            function oi(a) {

                checkBrowser();

                obj.onreadystatechange = function () {

                    if (obj.readyState === 4 && obj.status === 200) {

                        var a = JSON.parse(obj.responseText);
                        document.getElementById('i1').src = a.data.im1;
                        document.getElementById('i2').src = a.data.im2;
                        document.getElementById('i3').src = a.data.im3;
                        document.getElementById('i4').src = a.data.im4;

                    }

                };

                obj.open('POST', 'imagesearchadd', true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send('addid=' + a);

            }

        </script>

        <title>Advertisement</title>
    </head>
    <body onload="av1('_No')">



        <div id="wrapper">
            <%@include file="adminhedder.jsp" %>

            <div style="position: absolute;left: 100px;top: 180px;width: 1250px;height: 470px;">

                <div style="width: 1000px; height: 470px; ; overflow-y: auto; overflow-x: none;">
                    <table style="width: 1000px;height: auto;" class="table table-hover" id="stt">
                        <tr>
                            <th>Date</th>
                            <th>Plan</th>
                            <th>Domain</th>
                            <th>EXP Date</th>
                            <th>States</th>
                            <th>Amount</th>
                            <th>Change States</th>
                            <th>Update</th>
                        </tr>

                        <%                            try {
                                Session ses = new HibernateConnection().getSessionFactory().openSession();
                                Criteria cai4 = ses.createCriteria(Databasefile.Addreg.class);
                                List<Databasefile.Addreg> cal4 = cai4.list();
                                for (Databasefile.Addreg ar : cal4) {

                                    Criteria cim4 = ses.createCriteria(Databasefile.Addinvoice.class);
                                    cim4.add(Restrictions.eq("addreg", ar));
                                    Databasefile.Addinvoice imu = (Databasefile.Addinvoice) cim4.uniqueResult();
                        %>

                        <tr onmouseover="oi('<%= imu.getAddreg().getIdAddreg()%>');">
                            <td><%= imu.getDate()%></td>
                            <td><%= imu.getAddreg().getPlan()%></td>
                            <td><%= imu.getAddreg().getReason()%></td>
                            <td><%= imu.getAddreg().getExpdate()%></td>
                            <td><%= imu.getAddreg().getStates()%></td>
                            <td><%= imu.getAmount()%></td>
                            <td><select id="<%= imu.getAddreg().getIdAddreg()%>"><option>Active</option><option>De-Active</option></select></td>
                            <td><button class="btn btn-default" onclick="update('<%= imu.getAddreg().getIdAddreg()%>')">Update</button></td>
                        </tr>

                        <%
                                }
                                ses.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>

                    </table>
                </div>

                <div style="width: 200px;height: 469px; float: left;background-color: wheat; position: absolute; top: 1px; left: 1020px;">
                    <img src="img/defaultimage.png" class="img-circle" width="100px" height="100px" id="i1" style="position: relative; top: 20px;left: 50px">
                    <img src="img/defaultimage.png" class="img-circle" width="100px" height="100px" id="i2" style="position: relative; top: 20px;left: 50px">
                    <img src="img/defaultimage.png" class="img-circle" width="100px" height="100px" id="i3" style="position: relative; top: 20px;left: 50px">
                    <img src="img/defaultimage.png" class="img-circle" width="100px" height="100px" id="i4" style="position: relative; top: 20px;left: 50px">
                </div>

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
