<%-- 
    Document   : userregistation_login
    Created on : Nov 10, 2015, 11:33:55 AM
    Author     : Lochana
--%>

<%@page import="Databasefile.Catagory1"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Denims</title>
        <link href="css/mysty.css" rel="stylesheet" type="text/css">
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css.css" />
        
        <link href="css/popup_styles.css" rel="stylesheet" type="text/css" />

    

    </head>
    <body onload="lordTable(0, 'a', 'a', 'a');" style="background: url(img/Backimage1.jpg) repeat top left;">


        <div id="popUpDiv" style="display:none;" >

            <center>
                <table border="0" style="width:350px; height:250px;">
                    <tr><td><center><h3>Add To Cart</h3></center></td></tr>
                    <tr>
                        <td width="150px">Color</td>
                        <td width="200px">

                            <select class="form-control" id="ac_1" onchange="lordColorsToQty(this.value);">
                            </select>

                        </td>
                    </tr>
                    <tr>
                        <td width="150px">QTY</td>
                        <td width="200px">

                            <table>
                                <tr>
                                    <td>
                                        <button onclick="min()" class="btn btn-default">-</button>
                                    </td>
                                    <td>  
                                        <input type="text"  id="n1" class="form-control" value="1" style="width: 70px; text-align: center;" readonly>
                                    </td>
                                    <td> 
                                        <button class="btn btn-default"  onclick="max()">+</button>
                                    </td>
                                </tr>
                            </table>

                        </td>
                    </tr>
                    <label style="display: none;" id="hid"></label>
                    <tr><td></td><td><input type="submit" value="Add" class="btn btn-default" onclick="addCart()"><button class="btn btn-danger" style="position: relative;left: 20px" onclick="bk('popUpDiv')">Close</button></td></tr>

                </table>
                <h3 style="text-align: center;color: red;">Max QTY:</h3><h4 style="text-align: center;color: red;" id="qid"></h4>
            </center>
        </div>

        <div id="popUpDiv2" style="display:none;" >

            <center>
                <table border="0" width="350px" height = "250px">
                    <tr><td><h3><center>Add To WishList</center></h3></td></tr>
                    <tr>
                        <td width="150px">Color</td>
                        <td width="200px">

                            <select class="form-control" id="aw_1" onchange="lordColorsToQtyWishList(this.value);">
                            </select>

                        </td>
                    </tr>
                    <tr>
                        <td width="150px">QTY</td>
                        <td width="200px">

                            <table>
                                <tr>
                                    <td>
                                        <button onclick="min()" class="btn btn-default">-</button>
                                    </td>
                                    <td>  
                                        <input type="text"  id="n2" class="form-control" value="1" style="width: 70px; text-align: center;" readonly>
                                    </td>
                                    <td> 
                                        <button class="btn btn-default"  onclick="max()">+</button>
                                    </td>
                                </tr>
                            </table>

                        </td>
                    </tr>
                    <label style="display: none;" id="hid2"></label>
                    <tr><td></td><td><input type="submit" value="Add" class="btn btn-default" onclick="addWishList()"><button class="btn btn-danger" style="position: relative;left: 20px" onclick="bk('popUpDiv2')">Close</button></td></tr>

                </table>
                <h3 style="text-align: center;color: red;">Max QTY:</h3><h4 style="text-align: center;color: red;" id="qid2"></h4>
            </center>
        </div>

        <div id="popUpDiv3" style="display:none;" >

            <center>
                <table border="0" width="350px" height = "250px">
                    <tr><td><h3><center>Check Out</center></h3></td></tr>
                    <tr>
                        <td width="150px">Color</td>
                        <td width="200px">

                            <select class="form-control" id="cc_1" onchange="lordColorsQtyCheckout(this.value);">
                            </select>

                        </td>
                    </tr>
                    <tr>
                        <td width="150px">QTY</td>
                        <td width="200px">

                            <table>
                                <tr>
                                    <td>
                                        <button onclick="min()" class="btn btn-default">-</button>
                                    </td>
                                    <td>  
                                        <input type="text"  id="n3" class="form-control" value="1" style="width: 70px; text-align: center;" readonly>
                                    </td>
                                    <td> 
                                        <button class="btn btn-default"  onclick="max()">+</button>
                                    </td>
                                </tr>
                            </table>

                        </td>
                    </tr>
                    <label style="display: none;" id="hid3"></label>
                    <tr><td></td><td><input type="submit" value="Add" class="btn btn-default" onclick="Checkout()"><button class="btn btn-danger" style="position: relative;left: 20px" onclick="bk('popUpDiv3')">Close</button></td></tr>

                </table>
                <h3 style="text-align: center;color: red;">Max QTY:</h3><h4 style="text-align: center;color: red;" id="qid3"></h4>
            </center>
        </div>


        <div Class="maintable_w" style="margin-left: 10px;" id="ma1">
            <%@include file="hedder_withoutimageslider.jsp" %>

            <div class="imageitem_w" id="wap">
                <h1 style=" position: relative;left: -860px;"></h1>


                <center>
                    SubCategory:
                    <select class="form-control" style="width:140px;display: inline;" id="scata5" onchange="brandAdvanSearch()">

                        <%                            Session sks = new HibernateConnection().getSessionFactory().openSession();
                            Criteria cr = sks.createCriteria(Databasefile.Catagory1.class);
                            cr.add(Restrictions.eq("name", "Denim"));
                            Databasefile.Catagory1 cw = (Catagory1) cr.uniqueResult();

                            Criteria ca = sks.createCriteria(Databasefile.Catagory2.class);
                            ca.add(Restrictions.eq("catagory1", cw));

                            List<Databasefile.Catagory2> xt2 = ca.list();
                        %>

                        <option>~Select~</option>
                        <%                            for (Databasefile.Catagory2 c2 : xt2) {
                        %>

                        <option><%= c2.getName()%></option>

                        <%}%>

                    </select>

                    Brand:<select class="form-control" style="width:150px;display: inline;" onchange="modelAdvanSearch()" id="br1"></select>
                    Model:<select class="form-control" style="width:150px;display: inline;" id="mo1"></select>
                    <button class="btn btn-default" style="display: inline;" onclick="lordTable(0, scata5.value, br1.value, mo1.value);">Search</button>
                </center>
                <div style="height: 950px;">        
                    <table  width = "1200px" style=" position: relative; left:70px ; height: auto;" id="tab1">

                    </table>
                </div>

                <div class="pageinnertion" id="pi">

                </div>

            </div>

            <%@include file="fotter.jsp" %>
        </div>
    </body>
    <script type="text/javascript">

        var obj;

        function checkBrowser() {
            if (window.XMLHttpRequest) {
                obj = new XMLHttpRequest();
            } else {
                obj = new ActiveXobject("Microfoft.ActiveXobject");
            }
        }

        function brandAdvanSearch() {

            checkBrowser();
            document.getElementById('br1').innerHTML = "";

            document.getElementById('br1').innerHTML += '<option>~Select~</option>';
            obj.onreadystatechange = function () {

                if (obj.readyState === 4 && obj.status === 200) {

                    var c = JSON.parse(obj.responseText);
                    var m = c.data;
//                    alert(m);
                    for (i = 0; i < m.length; i++) {
                        var r = m[i].br;
                        document.getElementById('br1').innerHTML += '<option>' + r + '</option>';
                    }

                }
            };
            obj.open("POST", "advansearchbrandselect", true);
            obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            obj.send('cata=Denim&scata=' + document.getElementById('scata5').value);

        }


        function modelAdvanSearch() {

            checkBrowser();
            document.getElementById('mo1').innerHTML = "";

            document.getElementById('mo1').innerHTML += '<option>~Select~</option>';
            obj.onreadystatechange = function () {

                if (obj.readyState === 4 && obj.status === 200) {

                    var c = JSON.parse(obj.responseText);
                    var m = c.data;
//                    alert(m);
                    for (i = 0; i < m.length; i++) {
                        var r = m[i].br;
                        document.getElementById('mo1').innerHTML += '<option>' + r + '</option>';

                    }

                }
            };
            obj.open("POST", "advansearchmodelselect", true);
            obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            obj.send('cata=Denim&scata=' + document.getElementById('scata5').value + '&model=' + document.getElementById('br1').value);

        }


        function check(a) {

            checkBrowser();
            obj.onreadystatechange = function () {
                if (obj.readyState === 4 && obj.status === 200) {

                    alert(obj.responseText);
                    window.location = '_userregistation_login.jsp';

                }
            };
            obj.open("POST", "forgetpassword", true);
            obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            obj.send('email=' + a);

        }

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

        var j = 1;


        function lordTable(a, sub, brn, mod) {
            checkBrowser();
            obj.onreadystatechange = function () {
                if (obj.readyState === 4 && obj.status === 200) {

                    var s = JSON.parse(obj.responseText);

//                    alert(s.data.tab1);

                    document.getElementById('tab1').innerHTML = s.data.tab1;
                    document.getElementById('pi').innerHTML = s.data.pi;

                }
            };


            sub = document.getElementById('scata5').value;
            brn = document.getElementById('br1').value;
            mod = document.getElementById('mo1').value;

//            if (Number(a) <= 0) {
            if (sub.localeCompare('~Select~') == 0 || sub.localeCompare('') == 0) {
                sub = 'a';
//                alert(sub)
            }
            if (brn.localeCompare('~Select~') == 0 || brn.localeCompare('') == 0) {
                brn = 'a';
            }
            if (mod.localeCompare('~Select~') == 0 || mod.localeCompare('') == 0) {
                mod = 'a';
            }

            obj.open("POST", "DenimItemLord1", true);
            obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            obj.send('currentpage=' + a + '&sub=' + sub + '&brn=' + brn + '&mod=' + mod);
        }

        function bl(a, b) {
            //                alert(a);
            //                alert(b);
            document.getElementById(a).style.display = "block";
            document.getElementById('ma1').style.display = "none";

            //                window.open("#"+a, "Add to Cart", "height=350,width=400")
            if (a == 'popUpDiv') {
                document.getElementById('hid').innerHTML = b;
                lordColors(b);
            } else if (a == 'popUpDiv2') {
                document.getElementById('hid2').innerHTML = b;
                lordColorswishlist(b);
            } else if (a == 'popUpDiv3') {
                document.getElementById('hid3').innerHTML = b;
                lordColorscheckout(b);
            }

        }
        function bk(a) {

            document.getElementById(a).style.display = "none";
            document.getElementById('ma1').style.display = "block";
        }

        function lordColorscheckout(a) {
            checkBrowser();
            obj.onreadystatechange = function () {
                if (obj.readyState === 4 && obj.status === 200) {
                    var s = JSON.parse(obj.responseText);
                    var e = s.data;
                    document.getElementById('cc_1').innerHTML += '<option>' + '</option>';
                    for (ii = 0; ii < e.length; ii++) {
                        document.getElementById('cc_1').innerHTML += '<option>' + e[ii].Color;
                        +'</option>';
                    }
                }
            };
            document.getElementById('qid3').innerHTML = "";
            document.getElementById('cc_1').innerHTML = "";
            obj.open("POST", "lordColorByItemId", true);
            obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            obj.send("iid=" + a);

        }

        function lordColorswishlist(a) {
            checkBrowser();
            obj.onreadystatechange = function () {
                if (obj.readyState === 4 && obj.status === 200) {
                    var s = JSON.parse(obj.responseText);
                    var e = s.data;
                    document.getElementById('aw_1').innerHTML += '<option>' + '</option>';
                    for (ii = 0; ii < e.length; ii++) {
                        document.getElementById('aw_1').innerHTML += '<option>' + e[ii].Color;
                        +'</option>';
                    }
                }
            };
            document.getElementById('qid2').innerHTML = "";
            document.getElementById('aw_1').innerHTML = "";
            obj.open("POST", "lordColorByItemId", true);
            obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            obj.send("iid=" + a);

        }

        function lordColors(a) {
            checkBrowser();
            obj.onreadystatechange = function () {
                if (obj.readyState === 4 && obj.status === 200) {
                    var s = JSON.parse(obj.responseText);
                    var e = s.data;
                    document.getElementById('ac_1').innerHTML += '<option>' + '</option>';
                    for (ii = 0; ii < e.length; ii++) {
                        document.getElementById('ac_1').innerHTML += '<option>' + e[ii].Color;
                        +'</option>';
                    }
                }
            };
            document.getElementById('qid').innerHTML = "";
            document.getElementById('ac_1').innerHTML = "";
            obj.open("POST", "lordColorByItemId", true);
            obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            obj.send("iid=" + a);

        }
        function lordColorsToQty(b) {

            checkBrowser();
            obj.onreadystatechange = function () {
                if (obj.readyState === 4 && obj.status === 200) {

                    document.getElementById('qid').innerHTML = obj.responseText;
                }
            };
            var a = document.getElementById('hid').innerHTML;

            obj.open("POST", "lordColorByQty", true);
            obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            obj.send("iid=" + a + "&col=" + b);

        }
        function lordColorsToQtyWishList(b) {

            checkBrowser();
            obj.onreadystatechange = function () {
                if (obj.readyState === 4 && obj.status === 200) {

                    document.getElementById('qid2').innerHTML = obj.responseText;
                }
            };
            var a = document.getElementById('hid2').innerHTML;

            obj.open("POST", "lordColorByQty", true);
            obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            obj.send("iid=" + a + "&col=" + b);

        }
        function lordColorsQtyCheckout(b) {

            checkBrowser();
            obj.onreadystatechange = function () {
                if (obj.readyState === 4 && obj.status === 200) {

                    document.getElementById('qid3').innerHTML = obj.responseText;
                }
            };
            var a = document.getElementById('hid3').innerHTML;

            obj.open("POST", "lordColorByQty", true);
            obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            obj.send("iid=" + a + "&col=" + b);

        }
        function max() {
            var no = Number(document.getElementById('n1').value);
            document.getElementById('n1').value = no + 1;

            var no2 = Number(document.getElementById('n2').value);
            document.getElementById('n2').value = no2 + 1;

            var no3 = Number(document.getElementById('n3').value);
            document.getElementById('n3').value = no3 + 1;
        }
        function min() {
            var no = Number(document.getElementById('n1').value);
            var no2 = Number(document.getElementById('n2').value);
            var no3 = Number(document.getElementById('n3').value);
            if (no != 1) {
                document.getElementById('n1').value = no - 1;
            } else if (no2 != 1) {
                document.getElementById('n2').value = no2 - 1;
            } else if (no3 != 1) {
                document.getElementById('n3').value = no3 - 1;
            }
        }

        function addCart() {
            if (Number(document.getElementById("qid").innerHTML >= Number(document.getElementById('n1').value))) {

                checkBrowser();

                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {
                        alert(obj.responseText);
                        bk('popUpDiv');
                    }
                };

                obj.open("POST", "addToSessionCart", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("iid=" + document.getElementById('hid').innerHTML + "&col=" + document.getElementById('ac_1').value + "&qty=" + document.getElementById('n1').value);

            } else {
                alert('Bad QTY Select');
            }
        }
        function lordinfor(a) {
            window.method = 'Post';
            window.location = '_ItemInfo.jsp?msg=' + a + "&showbtn=" + 'no';
        }
        function addWishList() {

            var a = document.getElementById('hid2').innerHTML;
            var uid = document.getElementById('uhid').innerHTML;
            var col = document.getElementById('aw_1').value;

            //                alert('aaaaa')

            if (col == null || col == "") {
                alert('Fist select color and try again');
            } else {
                if (uid == null || uid == "") {

                    alert('Fist Login to System and try again');

                } else {
                    if (Number(document.getElementById("qid2").innerHTML) >= Number(document.getElementById('n2').value)) {

                        checkBrowser();

                        obj.onreadystatechange = function () {
                            if (obj.readyState === 4 && obj.status === 200) {
                                alert(obj.responseText);
                                bk('popUpDiv2');
                            }
                        };

                        obj.open("POST", "addToWishList", true);
                        obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                        obj.send("iid=" + a + "&uid=" + uid + "&color=" + col + "&qty=" + document.getElementById('n2').value);

                    } else {
                        alert('Bad QTY Select');
                    }
                }
            }

        }
        function Checkout() {
            var a = document.getElementById('hid3').innerHTML;
            var uid = document.getElementById('uhid').innerHTML;
            var col = document.getElementById('cc_1').value;


            if (col == null || col == "") {
                alert('Fist select color and try again');
            } else {
                if (uid == null || uid == "") {

                    alert('Fist Login to System and try again');

                } else {
                    if (Number(document.getElementById("qid3").innerHTML) >= Number(document.getElementById('n3').value)) {

                        checkBrowser();

                        obj.onreadystatechange = function () {
                            if (obj.readyState === 4 && obj.status === 200) {

                                var come = JSON.parse(obj.responseText);
                                window.location = come.data.rwi;
                                //                                    alert(obj.responseText);

                            }
                        };

                        obj.open("POST", "ReviewItem", true);
                        obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                        obj.send("iid=" + a + "&uid=" + uid + "&color=" + col + "&qty=" + document.getElementById('n2').value + "&rt=m");

                    } else {
                        alert('Bad QTY Select');
                    }
                }
            }
        }

    </script>
</html>
