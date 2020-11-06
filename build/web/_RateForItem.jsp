<%-- 
    Document   : userregistation_login
    Created on : Nov 10, 2015, 11:33:55 AM
    Author     : Lochana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ratting</title>
        <link href="css/mysty.css" rel="stylesheet" type="text/css">
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css.css" />

        <style type="text/javascript">
            .fake-input { position: relative; width:240px; }
            .fake-input input { border:none; background:#fff; display:block; width: 100%; box-sizing: border-box }
            .fake-input img { position: absolute; top: 2px; right: 5px }
        </style>

    </head>
    <body style="background: url(img/Backimage1.jpg) repeat top left;" onload="ratview()">
        <div Class="maintable_w" style="margin-left: 10px;">
            <%@include file="hedder_withoutimageslider.jsp" %>
            <center>
                <table width="1200px" height="350px" >
                    <tr>

                        <%                            String iid = request.getParameter("iid");

                            Criteria cr = ses.createCriteria(Databasefile.Invoice.class);
                            cr.add(Restrictions.eq("idInvoice", Integer.valueOf(iid)));
                            Databasefile.Invoice inv = (Databasefile.Invoice) cr.uniqueResult();

                            Criteria cr1 = ses.createCriteria(Databasefile.Invoiceinformation.class);
                            cr1.add(Restrictions.eq("invoice", inv));
                            Databasefile.Invoiceinformation ii = (Databasefile.Invoiceinformation) cr1.uniqueResult();

//                            Criteria prid = ses.createCriteria(Databasefile.Product.class);
//                            prid.add(Restrictions.eq("idProduct", ii.getProduct().getIdProduct()));
//                            Databasefile.Product pp = (Databasefile.Product) prid.uniqueResult();
                            Criteria img = ses.createCriteria(Databasefile.Productimage.class);
                            img.add(Restrictions.eq("product", ii.getProduct()));
                            Databasefile.Productimage pi = (Databasefile.Productimage) img.uniqueResult();
                        %>

                    <h6 style="display: none;" id="hpi"><%= ii.getProduct().getIdProduct()%></h6>

                    <td style="width: 400px; height: 400px;">
                        <div style="width: 400px;" >
                            <center>
                                <img src="<%= pi.getUrl1()%>" width="200px" height="200px">
                            </center>
                        </div>
                    </td>
                    <td style="width: 800px; height: 400px;">
                        <div style="width: 800px;">
                            <center>
                                <table>

                                    <tr>
                                        <td><h4 style="color: orange;">Product Name</h4></td>
                                        <td style="text-align: center;"><h5><%= ii.getProduct().getName()%></h5></td>
                                    </tr>
                                    <tr>
                                        <td><h4 style="color: orange;">Description</h4></td>
                                        <td style="text-align: center;"><h5><%= ii.getProduct().getDiscription()%></h5></td>
                                    </tr>
                                    <tr>
                                        <td><h4 style="color: orange;">Category</h4></td>
                                        <td style="text-align: center;"><h5><%= ii.getProduct().getCatagory1().getName()%></h5></td>
                                    </tr>
                                    <tr>
                                        <td><h4 style="color: orange;">Sub Category</h4></td>
                                        <td style="text-align: center;"><h5><%= ii.getProduct().getCatagory2().getName()%></h5></td>
                                    </tr>
                                    <tr>
                                        <td><h4 style="color: orange;">Color</h4></td>
                                        <td style="text-align: center;"><h5><%= ii.getColor().getName()%></h5></td>
                                    </tr>
                                    <tr>
                                        <td><h4 style="color: orange;">Rate</h4></td>
                                        <td style="text-align: center;">
                                            <div class="fake-input">
                                                <input type="text" class="form-control" id="i1" style="width: 50px;display: inline;text-align: center;" disabled="true"/>
                                                <button onclick="rate(<%= iid%>, 'Like');"><img src="img/_like_1.png" style="width: 100px; height: 36px;" /></button>
                                            </div>
                                            <div class="fake-input">
                                                <input type="text" class="form-control" id="i2" style="width: 50px; display: inline;text-align: center;" disabled="true"/>
                                                <button onclick="rate(<%= iid%>, 'UnLike');"><img src="img/_UnLike_1.png" style="width: 100px; height: 36px;" /></button>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                        </div>
                    </td>
                    </tr>
                </table>
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

        var obj;

        function checkBrowser() {
            if (window.XMLHttpRequest) {
                obj = new XMLHttpRequest();
            } else {
                obj = new ActiveXobject("Microfoft.ActiveXobject");
            }
        }

        function rate(a, b) {

            checkBrowser();

            obj.onreadystatechange = function () {
                if (obj.readyState === 4 && obj.status === 200) {
                    alert(obj.responseText);
                    ratview()
                }
            };

            obj.open('Post', 'applyrating', true);
            obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            obj.send('iid=' + a + '&sta=' + b);

        }
        function ratview() {

            checkBrowser();
            obj.onreadystatechange = function () {
                if (obj.readyState === 4 && obj.status === 200) {

                    var a = JSON.parse(obj.responseText);

                    document.getElementById('i1').value = a.data.like;
                    document.getElementById('i2').value = a.data.Unlike;

                }
            };

            obj.open('POST', 'ratingcount', true);
            obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            obj.send('pid=' + document.getElementById('hpi').innerHTML);
        }
    </script>
</html>
