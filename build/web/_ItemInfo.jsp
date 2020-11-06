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
        <title>Item Information</title>
        <link href="css/mysty.css" rel="stylesheet" type="text/css">
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css" />

        <link href="css/popup_styles.css" rel="stylesheet" type="text/css" />



        <script type="text/javascript">
            var obj;

            function checkBrowser() {
                if (window.XMLHttpRequest) {
                    obj = new XMLHttpRequest();
                } else {
                    obj = new ActiveXobject("Microfoft.ActiveXobject");
                }
            }

            function changeBigImg(a) {
                document.getElementById('bi').src = a;
            }
            function bl(a, b) {
//                alert(a);
//                alert(b);
                document.getElementById(a).style.display = "block";
                document.getElementById('maintable_wid').style.display = "none";
                document.getElementById('hid').innerHTML = b;
//                window.open("#"+a, "Add to Cart", "height=350,width=400")
                if (a == 'popUpDiv') {
                    lordColors(b);
                }

            }
            function bk(a) {

                document.getElementById(a).style.display = "none";
                document.getElementById('maintable_wid').style.display = "block";
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
            function max() {
                var no = Number(document.getElementById('n1').value);
                document.getElementById('n1').value = no + 1;
            }
            function min() {
                var no = Number(document.getElementById('n1').value);
                if (no != 0) {
                    document.getElementById('n1').value = no - 1;
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
            function ratview() {

                checkBrowser();
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {

                        var a = JSON.parse(obj.responseText);

//                        alert(a.data.like);

                        document.getElementById('i10').value = a.data.like;
                        document.getElementById('i20').value = a.data.Unlike;

                    }
                };

                obj.open('POST', 'ratingcount', true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send('pid=' + document.getElementById('hpi').innerHTML);
            }

        </script>

    </head>
    <body onload="ratview()" style="background: url(img/Backimage1.jpg) repeat top left;" >


        <div id="popUpDiv" style="display:none;" >

            <center>
                <table border="0" width="350px" height = "250px">
                    <tr><td><h3><center>Add To Cart</center></h3></td></tr>
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

        <div Class="maintable_w" style="margin-left: 10px;" id="maintable_wid">
            <%@include file="hedder_withoutimageslider.jsp" %>
            <center>

                <div style=" height: 460px; width: 1200px; ">

                    <%                        Session sesm = new HibernateConnection().getSessionFactory().openSession();
                        Criteria cr = sesm.createCriteria(Databasefile.Product.class);
                        cr.add(Restrictions.eq("idProduct", Integer.valueOf(request.getParameter("msg"))));
                        Databasefile.Product pp = (Databasefile.Product) cr.uniqueResult();

                        Criteria c1 = sesm.createCriteria(Databasefile.Discount.class);
                        c1.add(Restrictions.eq("product", pp));
                        Databasefile.Discount dis = (Databasefile.Discount) c1.uniqueResult();

                        Criteria img = sesm.createCriteria(Databasefile.Productimage.class);
                        img.add(Restrictions.eq("product", pp));
                        Databasefile.Productimage pi = (Databasefile.Productimage) img.uniqueResult();

                        String dt = "";
                        String mk = "";
                        double tot = 0.0;
                        if (dis.getDistype().getType().equals("Cash")) {
                            tot = pp.getAmount() - dis.getDiscount();
                            dt = "- Rs. " + dis.getDiscount() + "";
                        } else {
                            double dk = (pp.getAmount() * dis.getDiscount()) / 100;
                            tot = pp.getAmount() - dk;
                            mk = "%";
                        }

                    %>

                    <div style="width: 410px; height: 360px; padding-top: 20px; float: left;">

                        <table>
                            <tr>
                            <div style="width: 450px">
                                <center>
                                    <img src="img/defaultimage.png" class="img-thumbnail" width="200px" height="200px" id="bi">
                                </center>
                            </div>
                            </tr>
                            <tr>
                            <div style="width: 450px">

                                <center>
                                    <img src="<%= pi.getUrl1()%>" class="img-thumbnail" width="100px" height="100px" id="i1" onclick="changeBigImg(this.src)">

                                    <img src="<%= pi.getUrl2()%>" class="img-thumbnail" width="100px" height="100px" id="i2" onclick="changeBigImg(this.src)">

                                    <img src="<%= pi.getUrl3()%>" class="img-thumbnail" width="100px" height="100px" id="i3" onclick="changeBigImg(this.src)">

                                    <img src="<%= pi.getUrl4()%>" class="img-thumbnail" width="100px" height="100px" id="i3" onclick="changeBigImg(this.src)">


                                    <div class="fake-input">
                                        <input type="text" class="form-control" id="i10" style="width: 50px;display: inline;text-align: center;" disabled="true"/>
                                        <img src="img/_like_1.png" style="width: 100px; height: 36px;"/>
                                    </div>
                                    <div class="fake-input">
                                        <input type="text" class="form-control" id="i20" style="width: 50px; display: inline;text-align: center;" disabled="true"/>
                                        <img src="img/_UnLike_1.png" style="width: 100px; height: 36px;"/>
                                    </div>

                                </center>

                            </div> 



                            </tr>
                        </table>

                    </div>
                    <div style="width: 750px; height: 360px; padding-top: 20px; float: left;">
                        <table>
                            <h6 style="display: none;" id="hpi"><%= pp.getIdProduct()%></h6>
                            <tr>
                                <td style="width: 200px;"><h4 style="color: orange;">Item Name:</h4></td>
                                <td><h5><%= pp.getName()%></h5></td>
                            </tr>
                            <tr>
                                <td style="width: 200px;"><h4 style="color: orange;">Item Description:</h4></td>
                                <td><h5><%= pp.getDiscription()%></h5></td>
                            </tr>
                            <tr>
                                <td style="width: 200px;"><h4 style="color: orange;">Category:</h4></td>
                                <td><h5><%= pp.getCatagory1().getName()%></h5></td>
                            </tr>
                            <tr>
                                <td style="width: 200px;"><h4 style="color: orange;">Sub Category:</h4></td>
                                <td><h5><%= pp.getCatagory2().getName()%></h5></td>
                            </tr>
                            <tr>
                                <td style="width: 200px;"><h4 style="color: orange;">Brand:</h4></td>
                                <td><h5><%= pp.getBrand().getName()%></h5></td>
                            </tr>
                            <tr>
                                <td style="width: 200px;"><h4 style="color: orange;">Model:</h4></td>
                                <td><h5><%= pp.getModel().getName()%></h5></td>
                            </tr>
                            <tr>
                                <td style="width: 200px;"><h4 style="color: orange;">Amount:</h4></td>
                                <td><h5><%= pp.getAmount()%></h5></td>
                            </tr>
                            <tr>
                                <td style="width: 200px;"><h4 style="color: orange;">Discount:</h4></td>
                                <td><h5><%= dis.getDiscount()%><%= mk%></h5></td>
                            </tr>
                            <tr>
                                <td style="width: 200px;"><h4 style="color: orange;">Total:</h4></td>
                                <td><h5><%= tot%> <%= dt%></h5></td>
                            </tr>
                            <tr>
                                <td style="width: 200px;"></td>
                                <td>
                                    <%
                                        if (request.getParameter("showbtn").equals("no")) {
                                    %>

                                    <button class="btn btn-default" onclick="bl('popUpDiv',<%= pp.getIdProduct()%>)">Add to Cart</button>
                                    <%
                                        }
                                    %>
                                </td>
                            </tr>
                        </table>
                    </div>
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
