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
        <title>Wish List</title>
        <link href="css/mysty.css" rel="stylesheet" type="text/css">
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css" />


        <script type="text/javascript">
            var obj;

            function checkBrowser() {
                if (window.XMLHttpRequest) {
                    obj = new XMLHttpRequest();
                } else {
                    obj = new ActiveXobject("Microfoft.ActiveXobject");
                }
            }
            function lordWishTable() {
//                alert("1")
//                alert(document.getElementById('uhid').innerHTML)
                if (document.getElementById('uhid').innerHTML == null || document.getElementById('uhid').innerHTML == "") {
//                    alert('3');
                    alert('Fist login and try this again');
                } else {
//                    alert('2');
                    checkBrowser();
                    obj.onreadystatechange = function () {
                        if (obj.readyState === 4 && obj.status === 200) {

                            var r = JSON.parse(obj.responseText);
//                        alert(r.data.table);
                            document.getElementById('ct').innerHTML = r.data.table;
                            document.getElementById('tot').innerHTML = r.data.tot;
                            document.getElementById('msg').innerHTML = r.data.msg;

                        }
                    };
                    obj.open("POST", "lordWishListtItemsDinamic", true);
                    obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    obj.send('Uid=' + document.getElementById('uhid').innerHTML);
                }
            }
            function lordinfor(a) {
                window.location = '_ItemInfo.jsp?msg=' + a + "&showbtn=" + 'ok';
            }

            function removeItem(a, b) {

                checkBrowser();
//                alert(a);
//                alert(b);
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {
//                        alert(obj.responseText);

                        alert(obj.responseText);
                        lordWishTable();

                    }
                };
                obj.open("POST", "removewishlistItem", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("pid=" + a + "&col=" + b + "&uid=" + document.getElementById('uhid').innerHTML);
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

                        obj.onreadystatechange = function () {
                            if (obj.readyState === 4 && obj.status === 200) {
                                var come = JSON.parse(obj.responseText);

                                //removeItem(come.data.pid, come.data.col);
                                window.location = come.data.rwi;
//                                    alert(obj.responseText);
                            }
                        };

                        obj.open("POST", "ReviewItem", true);
                        obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                        obj.send("iid=" + iid + "&uid=" + uid + "&color=" + col + "&qty=" + qty + "&rt=wl");

                    }
                }
            }

        </script>

    </head>
    <body onload="lordWishTable()" style="background: url(img/Backimage1.jpg) repeat top left;">
        <div Class="maintable_w" style="margin-left: 10px;">
            <%@include file="hedder_withoutimageslider.jsp" %>
            <center>

                <div style=" height: 380px; padding-top: 20px;">
                    <table class="table table-hover" style="width: 1200px;overflow-y: auto;" id="ct">

                    </table>
                </div>
                <div style="height: 60px;">
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
