<%-- 
    Document   : userregistation_login
    Created on : Nov 10, 2015, 11:33:55 AM
    Author     : Lochana
--%>

<%@page import="Databasefile.Product"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="Databasefile.HibernateConnection"%>
<%@page import="org.hibernate.Session"%>
<%@page import="Class.SessionCartItems"%>
<%@page import="java.util.List"%>
<%@page import="Class.SessionCart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart</title>
        <link href="css/mysty.css" rel="stylesheet" type="text/css">
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css" />

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

        

        <script type="text/javascript">
            var obj;

            function checkBrowser() {
                if (window.XMLHttpRequest) {
                    obj = new XMLHttpRequest();
                } else {
                    obj = new ActiveXobject("Microfoft.ActiveXobject"
                            );
                }
            }
            function lordCartTable() {
                checkBrowser();
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {

                        var r = JSON.parse(obj.responseText);
//                        alert(r.data.table);
                        document.getElementById('ct').innerHTML = r.data.table;
                        document.getElementById('tot').innerHTML = r.data.tot;
                        document.getElementById('msg').innerHTML = r.data.msg;

                        lad();

                    }
                };
                obj.open("POST", "lordCartItemsDinamic", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send();
            }
            function removeItem(a, b) {

                checkBrowser();
//                alert(a);
//                alert(b);
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {
//                        alert(obj.responseText);

                        lordCartTable();
                    }
                };
                obj.open("POST", "removeSessionCartItem", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("pid=" + a + "&col=" + b);
            }
            function lordinfor(a) {
                window.location = '_ItemInfo.jsp?msg=' + a + "&showbtn=" + 'ok';
            }
            function addToWL(a, b, c, d) {

                var uid = document.getElementById('uhid').innerHTML;
                var col = b;

                if (col === null || col === "") {
                    alert('Color is Empty Cant add this');
                } else {
                    if (uid === null || uid === "") {

                        alert('Fist Login to System and try again');

                    } else {
                        if (Number(d) >= Number(c)) {

                            checkBrowser();

                            obj.onreadystatechange = function () {
                                if (obj.readyState === 4 && obj.status === 200) {
                                    alert(obj.responseText);
                                    removeItem(a, col);
                                }
                            };

                            obj.open("POST", "addToWishList", true);
                            obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                            obj.send("iid=" + a + "&uid=" + uid + "&color=" + col + "&qty=" + c);

                        } else {
                            alert('Bad QTY Select');
                        }
                    }
                }

            }

            function Checkout(iid, col, qty) {
                var uid = document.getElementById('uhid').innerHTML;


                if (col == null || col == "") {
                    ;
                    alert('Fist select color and try again');
                } else {
                    if (uid == null || uid == "") {

                        alert('Fist Login to System and try again');

                    } else {
                        checkBrowser();

                        var res;

                        obj.onreadystatechange = function () {
                            if (obj.readyState === 4 && obj.status === 200) {

                                var come = JSON.parse(obj.responseText);

                                window.location = come.data.rwi;
                            }
                        };

                        obj.open("POST", "ReviewItem", true);
                        obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                        obj.send("iid=" + iid + "&uid=" + uid + "&color=" + col + "&qty=" + qty + "&rt=cart");

                    }
                }
            }


            function checkallofcart() {
                window.location = '_ReviewItem_cartall.jsp?uid=' + document.getElementById('uhid').innerHTML;
            }

            function lad() {
                document.getElementById('gpl').click();
            }

        </script>

    </head>
    <body onload="lordCartTable()" style="background: url(img/Backimage1.jpg) repeat top left;">
        <div Class="maintable_w" style="margin-left: 10px;">
            <%@include file="hedder_withoutimageslider.jsp" %>

            <div class="container">
                <!-- Trigger the modal with a button -->
                <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal" style="display: none;" id="gpl"></button>

                <!-- Modal -->
                <div class="modal fade" id="myModal" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div >
                                <div class="modal-header" >
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                </div>
                                <marquee direction="right" behavior="alternate" scrollamount="5" style="width: auto;height: auto;">
                                    <%                                        Criteria cai4 = ses.createCriteria(Databasefile.Addreg.class);
                                        cai4.add(Restrictions.eq("plan", "Platinum"));
                                        cai4.add(Restrictions.eq("states", "Active"));
                                        List<Databasefile.Addreg> cal4 = cai4.list();
                                        for (Databasefile.Addreg ar : cal4) {

                                            Criteria cim4 = ses.createCriteria(Databasefile.Image.class);
                                            cim4.add(Restrictions.eq("addreg", ar));
                                            Databasefile.Image imu = (Databasefile.Image) cim4.uniqueResult();

                                            //                                    System.out.println(ar.getReason());
                                            if (cal4.size() % 2 == 0) {
                                    %>
                                    <img style="width: 500px;height: 300px" src="<%= imu.getIm1()%>" onclick="tn('<%= imu.getAddreg().getReason()%>')">
                                    <img style="width: 500px;height: 300px" src="<%= imu.getIm2()%>" onclick="tn('<%= imu.getAddreg().getReason()%>')">
                                    <img style="width: 500px;height: 300px" src="<%= imu.getIm3()%>" onclick="tn('<%= imu.getAddreg().getReason()%>')">
                                    <img style="width: 500px;height: 300px" src="<%= imu.getIm4()%>" onclick="tn('<%= imu.getAddreg().getReason()%>')">
                                    <%} else {%>
                                    <img style="width: 500px;height: 300px" src="<%= imu.getIm1()%>" onclick="tn('<%= imu.getAddreg().getReason()%>')">
                                    <img style="width: 500px;height: 300px" src="<%= imu.getIm2()%>" onclick="tn('<%= imu.getAddreg().getReason()%>')">
                                    <img style="width: 500px;height: 300px" src="<%= imu.getIm3()%>" onclick="tn('<%= imu.getAddreg().getReason()%>')">
                                    <img style="width: 500px;height: 300px" src="<%= imu.getIm4()%>" onclick="tn('<%= imu.getAddreg().getReason()%>')">
                                    <%
                                            }
                                        }
                                    %>
                                </marquee>
                            </div>
                        </div>

                    </div>
                </div>

            </div>


            <center>

                <div style=" height: 360px; padding-top: 20px;">
                    <table class="table table-hover" style="width: 1200px;overflow-y: auto;" id="ct">

                    </table>
                </div>
                <div style="height: 80px;">
                    <h3 id="tot" style="color: red;"></h3>
                    <h5 id="msg" style="color: orange;"></h5>
                </div>
            </center>
            <%@include file="fotter.jsp" %>
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
