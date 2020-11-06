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
        
        <style type="text/css">
            body{
                background: url(img/Backimage1.jpg) repeat top left;
            }
        </style>

        <script type="text/javascript">

            var obj;
            function bl(a, b, c) {
                if (c == 'Infor') {
                    lordInformation(b);
                } else if (c == 'Disco') {
                    lorddis(b);
                } else if (c == 'Update') {
                    lordAmount(b);
                } else if (c == 'Ser') {
                    SearchPID(b);
                } else if (c == 'hi') {

                }

                document.getElementById(a).style.display = "block";
                document.getElementById('wrapper').style.display = "none";
            }
            function bk(a) {

                document.getElementById(a).style.display = "none";
                document.getElementById('wrapper').style.display = "block";
            }

            function checkBrowser() {
                if (window.XMLHttpRequest) {
                    obj = new XMLHttpRequest();
                } else {
                    obj = new ActiveXobject("Microfoft.ActiveXobject");
                }
            }

            function cl() {

                document.getElementById('cat').innerHTML = "";
                document.getElementById('scat').innerHTML = "";
                document.getElementById('bra').innerHTML = "";
                document.getElementById('mode').innerHTML = "";
                document.getElementById('size').innerHTML = "";
                document.getElementById('i1').src = "";
                document.getElementById('i2').src = "";
                document.getElementById('i3').src = "";
                document.getElementById('i4').src = "";
                document.getElementById('c1').innerHTML = "";
                document.getElementById('cq1').innerHTML = "";
                document.getElementById('c2').innerHTML = "";
                document.getElementById('cq2').innerHTML = "";
                document.getElementById('c3').innerHTML = "";
                document.getElementById('cq3').innerHTML = "";
                document.getElementById('c4').innerHTML = "";
                document.getElementById('cq4').innerHTML = "";
                document.getElementById('c5').innerHTML = "";
                document.getElementById('cq5').innerHTML = "";
            }

            function lordInformation(b) {
                checkBrowser();
                obj.onreadystatechange = function () {

                    if (obj.readyState === 4 && obj.status === 200) {

                        cl();
                        var A = JSON.parse(obj.responseText);
                        var col = A.data;
                        document.getElementById('cat').innerHTML = A.cate;
                        document.getElementById('scat').innerHTML = A.scate;
                        document.getElementById('bra').innerHTML = A.brand;
                        document.getElementById('mode').innerHTML = A.model;
                        document.getElementById('size').innerHTML = A.size;
                        document.getElementById('i1').src = A.img1;
                        document.getElementById('i2').src = A.img2;
                        document.getElementById('i3').src = A.img3;
                        document.getElementById('i4').src = A.img4;
                        for (i = 0; i < col.length; i++) {
                            if (i == 0) {
                                document.getElementById('c1').innerHTML = col[i].color;
                                document.getElementById('cq1').innerHTML = col[i].qty;
                            } else if (i == 1) {
                                document.getElementById('c2').innerHTML = col[i].color;
                                document.getElementById('cq2').innerHTML = col[i].qty;
                            } else if (i == 2) {
                                document.getElementById('c3').innerHTML = col[i].color;
                                document.getElementById('cq3').innerHTML = col[i].qty;
                            } else if (i == 3) {
                                document.getElementById('c4').innerHTML = col[i].color;
                                document.getElementById('cq4').innerHTML = col[i].qty;
                            } else if (i == 4) {
                                document.getElementById('c5').innerHTML = col[i].color;
                                document.getElementById('cq5').innerHTML = col[i].qty;
                            }
                        }

                    }
                    ;
                };
                obj.open("POST", "lordinformation", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("pid=" + b);
            }
            function lorddis(b) {
                checkBrowser();
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {

                        var a = JSON.parse(obj.responseText);
                        document.getElementById('dis').innerHTML = a.Dis;
                        document.getElementById('dist').innerHTML = a.DisTy;
                        document.getElementById('fa').innerHTML = a.Amo;
                    }
                };
                obj.open("POST", "lorddiscount", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("pid=" + b);
            }
            function lordAmount(b) {

                checkBrowser();
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {

                        var a = JSON.parse(obj.responseText);
                        document.getElementById('Ai1').placeholder = a.am;
                    }
                };
                document.getElementById('hid').innerHTML = b;
                obj.open("POST", "lordam", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("pid=" + b);
            }

            function cahangetstates() {

                checkBrowser();
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {

                        location.reload();
                        bk('popUpDiv3');
                    }
                };
                var b = document.getElementById('hid').innerHTML;
                var na = document.getElementById('Ai1').value;
                var ns = document.getElementById('pslc').value;
                obj.open("POST", "cahagestatus", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("pid=" + b + "&na=" + na + "&ns=" + ns);
            }

            function FistPage(b) {

                checkBrowser();
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {

                        var a = JSON.parse(obj.responseText);
                        alert(a.msg);
                    }
                };
                obj.open("POST", "fistp", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("pid=" + b);
            }
            function SearchPID(b) {

                checkBrowser();
                obj.onreadystatechange = function () {

                    document.getElementById('a1').innerHTML = "";
                    document.getElementById('a2').innerHTML = "";
                    document.getElementById('a3').innerHTML = "";
                    document.getElementById('a4').innerHTML = "";
                    document.getElementById('a5').innerHTML = "";

                    if (obj.readyState === 4 && obj.status === 200) {

                        if (obj.responseText == 'No Item Found') {
                            alert('No Item Found');
                        } else {

                            var a = JSON.parse(obj.responseText);
                            document.getElementById('a1').innerHTML = a.Name;
                            document.getElementById('a2').innerHTML = a.Des;
                            document.getElementById('a3').innerHTML = a.Qty;
                            document.getElementById('a4').innerHTML = a.Amo;
                            document.getElementById('a5').innerHTML = a.Sta;
                        }
                    }
                };
                obj.open("POST", "searchpid", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("pname=" + b);
            }
            function Removefpi(b) {
                checkBrowser();
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {
                        alert(obj.responseText);
                        location.reload();
                    }
                };
                obj.open("POST", "removehi", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("pid=" + b);
            }
            function av1(a) {

                checkBrowser();

                obj.onreadystatechange = function () {

                    if (obj.readyState === 4 && obj.status === 200) {
                        document.getElementById('stt').innerHTML = obj.responseText;
                    }

                };
                obj.open("POST", "NEw", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("msg=" + a);
            }

        </script>

        <title>Stock Management</title>
    </head>
    <body onload="av1('_No')">

        <div id="popUpDiv" style="display:none;" >
            <center>
                <table border="0" width="350px" height = "250px">
                    <tr><td><h3><center>Information</center></h3></td></tr>
                    <tr>
                        <td width="150px">Category</td>
                        <td width="200px">
                            <label id="cat"></label>
                        </td>
                    </tr>
                    <tr>
                        <td width="150px">Sub category</td>
                        <td width="200px">
                            <label id="scat"></label>
                        </td>
                    </tr>
                    <tr>
                        <td width="150px">Brand</td>
                        <td width="200px">
                            <label id="bra"></label>
                        </td>
                    </tr>
                    <tr>
                        <td width="150px">Model</td>
                        <td width="200px">
                            <label id="mode"></label>
                        </td>
                    </tr>
                    <tr>
                        <td width="150px">Size</td>
                        <td width="200px">
                            <label id="size"></label>
                        </td>
                    </tr>
                    <tr>
                        <td width="150px">Color</td>
                        <td width="200px">
                            <label id="c1"></label>
                        </td>
                        <td width="200px">
                            <label id="cq1"></label>
                        </td>
                    </tr>
                    <tr>
                        <td width="150px">Color</td>
                        <td width="200px">
                            <label id="c2"></label>
                        </td>
                        <td width="200px">
                            <label id="cq2"></label>
                        </td>
                    </tr>
                    <tr>
                        <td width="150px">Color</td>
                        <td width="200px">
                            <label id="c3"></label>
                        </td>
                        <td width="200px">
                            <label id="cq3"></label>
                        </td>
                    </tr>
                    <tr>
                        <td width="150px">Color</td>
                        <td width="200px">
                            <label id="c4"></label>
                        </td>
                        <td width="200px">
                            <label id="cq4"></label>
                        </td>
                    </tr>
                    <tr>
                        <td width="150px">Color</td>
                        <td width="200px">
                            <label id="c5"></label>
                        </td>
                        <td width="200px">
                            <label id="cq5"></label>
                        </td>
                    </tr>
                    <tr><td></td><td><button class="btn btn-danger" style="position: relative;left: 20px;top: 20px;" onclick="bk('popUpDiv')">Close</button></td></tr>

                </table>
            </center>
        </div>

        <div id="popUpDiv2" style="display:none;" >
            <center>
                <table border="0" width="350px" height = "250px">
                    <tr><td><h3><center>Discount</center></h3></td></tr>
                    <tr>
                        <td width="150px">Discount</td>
                        <td width="200px">
                            <label id="dis"></label>
                        </td>
                        <td width="200px">
                            <label id="dist"></label>
                        </td>
                    </tr>
                    <tr>
                        <td width="150px">Final Amount</td>
                        <td width="200px">
                            <h3><label id="fa" style="color: tomato"></label></h3>
                        </td>
                    </tr>
                    <tr><td></td><td><button class="btn btn-danger" style="position: relative;left: 20px;top: 20px;" onclick="bk('popUpDiv2')">Close</button></td></tr>

                </table>
            </center>
        </div>

        <div id="popUpDiv3" style="display:none;" >
            <center>
                <table border="0" width="350px" height = "250px">
                    <tr><td><h3><center>Update</center></h3></td></tr>
                    <tr>
                        <td width="150px">Amount</td>
                        <td width="200px">
                            <input type="text" id="Ai1" class="form-control" >
                        </td>
                    </tr>
                    <tr>
                        <td width="150px">Status</td>
                        <td width="200px">
                            <p id="hid" style="display: none"></p>
                            <select id="pslc" class="form-control">
                                <%
                                    Session ses = new HibernateConnection().getSessionFactory().openSession();
                                    Criteria cps = ses.createCriteria(Databasefile.Productstates.class);
                                    List<Databasefile.Productstates> pli = cps.list();
                                    for (Databasefile.Productstates psi : pli) {
                                %>
                                <option><%= psi.getName()%></option>
                                <%}%>
                            </select>
                        </td>
                    </tr>
                    <tr><td></td><td><button class="btn btn-info" style="position: relative;left: 20px;top: 20px;" onclick="cahangetstates()">Update</button><button class="btn btn-danger" style="position: relative;left: 20px;top: 20px;" onclick="bk('popUpDiv3')">Close</button></td></tr>

                </table>
            </center>
        </div>

        <div id="popUpDiv7" style="display:none;" >
            <center>
                <table border="0" width="350px" height = "250px">
                    <tr><td><h3><center>Search</center></h3></td></tr>
                    <tr>
                        <td><h5>Name</h5></td>
                        <td><h5>Description</h5></td>
                        <td><h5>QTY</h5></td>
                        <td><h5>Amount</h5></td>
                        <td><h5>Status</h5></td>
                    </tr>
                    <td id="a1"></td>
                    <td id="a2"></td>
                    <td id="a3"></td>
                    <td id="a4"></td>
                    <td id="a5"></td>
                    <tr><td></td><td><button class="btn btn-danger" style="position: relative;left: 20px;top: 20px;" onclick="bk('popUpDiv7')">Close</button></td></tr>

                </table>
            </center>
        </div>

        <div id="popUpDiv8" style="display:none;" >
            <center>
                <table border="0" width="350px" height = "50px">
                    <tr><td><h3><center>Search</center></h3></td></tr>
                    <tr>
                        <td><h5>ID</h5></td>
                        <td><h5>Name</h5></td>
                        <td><h5>QTY</h5></td>
                        <td><h5>Remove</h5></td>
                    </tr>

                    <%
                        Criteria crr = ses.createCriteria(Databasefile.Fistpage.class);
                        List<Databasefile.Fistpage> lif = crr.list();
                        for (Databasefile.Fistpage fi : lif) {
                    %>
                    <tr>
                        <td ><%= fi.getProduct().getIdProduct()%></td>
                        <td ><%= fi.getProduct().getName()%></td>
                        <td ><%= fi.getProduct().getQty()%></td>
                        <td ><button class="btn btn-danger" onclick="Removefpi(<%= fi.getIdFistPage()%>)">Remove</button></td>
                    </tr>
                    <%}%>
                    <tr><td></td><td><button class="btn btn-danger" style="position: relative;left: 20px;top: 20px;" onclick="bk('popUpDiv8')">Close</button></td></tr>

                </table>
            </center>
        </div>

        <div id="wrapper">
            <%@include file="adminhedder.jsp" %>

            <input type="text" id="searn" placeholder="SEARCH :Product Name" onkeypress="av1(this.value)" class="form-control" style="position: absolute;left:100px;top: 140px;width: 200px;">
<!--            <button class="btn btn-info" style="position: absolute;left:305px;top: 140px;" onclick="bl('popUpDiv7', searn.value, 'Ser')">Search</button>-->

            <button class="btn btn-info" style="position: absolute; top: 140px;left: 960px" onclick="bl('popUpDiv8', 'asd', 'hi')">Home Page Items</button>

            <div style="position: absolute;left: 100px;top: 180px;width: 1250px;height: 470px;">

                <div style="width: 1000px; height: 470px; ; overflow-y: auto; overflow-x: none;">
                    <table style="width: 1000px;height: auto;" class="table table-hover" id="stt">

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
