<%-- 
    Document   : userregistation_login
    Created on : Nov 10, 2015, 11:33:55 AM
    Author     : Lochana
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="org.hibernate.criterion.Projections"%>
<%@page import="org.hibernate.criterion.Projection"%>
<%@page import="com.javapapers.java.security.Modulo26Crypto"%>
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
        <title>Review Item</title>
        <link href="css/mysty.css" rel="stylesheet" type="text/css">
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
        <!--<link media="all" rel="stylesheet" type="text/css" href="css/LordingAjax.css" />-->
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css" />
        <script src="https://maps.google.com/maps?file=api&v=2&key=ABQIAAAA7j_Q-rshuWkc8HyFI4V2HxQYPm-xtd00hTQOC0OXpAMO40FHAxT29dNBGfxqMPq5zwdeiDSHEPL89A" type="text/javascript"></script>


        <script type="text/javascript">
            var obj;
            var geocoder, location1, location2;
            var bool = false;
            function checkBrowser() {
                if (window.XMLHttpRequest) {
                    obj = new XMLHttpRequest();
                } else {
                    obj = new ActiveXobject("Microfoft.ActiveXobject");
                }
            }
            function max() {

                var no2 = Number(document.getElementById('n2').value);
                document.getElementById('n2').value = no2 + 1;
                document.getElementById('lab1').style.display = "none";
            }
            function min() {
                var no2 = Number(document.getElementById('n2').value);
                if (no2 != 1) {
                    document.getElementById('n2').value = no2 - 1;
                }
            }

            function lorddisco() {

                if (document.getElementById('hdt').innerHTML != 'Cash') {
                    var a = (Number(document.getElementById('am').innerHTML) - ((Number(document.getElementById('am').innerHTML) * Number(document.getElementById('hamount').innerHTML)) / 100));
                    document.getElementById('dis').innerHTML = a;
//                    alert(Number(document.getElementById('am').innerHTML));
//                    alert(a);
                } else {
                    var c = Number(document.getElementById('hamount').innerHTML) * Number(document.getElementById('n2').value);
                    document.getElementById('dis').innerHTML = c;
//                    alert(c);
                }

            }

            function initialize() {
                geocoder = new GClientGeocoder();
                lorddisco();
                sat();
            }
            function showLocation(a) {
//                alert('1');
                var x = false;
                if (document.getElementById('mxb').style.display != "none") {
                    x = window.confirm("Are you sure you right Shipping address?")
                } else {
                    x = true;
                }
                if (x) {

                    geocoder.getLocations('Mathale', function (response) {
//                    alert('2');
                        if (!response || response.Status.code != 200)
                        {
                            alert("Sorry, we were unable to geocode the first address");
                        }
                        else
                        {
//                        alert('3');
                            location1 = {lat: response.Placemark[0].Point.coordinates[1], lon: response.Placemark[0].Point.coordinates[0], address: response.Placemark[0].address};
                            geocoder.getLocations(document.getElementById('add3').value, function (response) {
                                if (!response || response.Status.code != 200)
                                {
                                    alert("Sorry, we were unable to geocode the second address");
                                }
                                else
                                {
                                    location2 = {lat: response.Placemark[0].Point.coordinates[1], lon: response.Placemark[0].Point.coordinates[0], address: response.Placemark[0].address};
                                    calculateDistance(a);
                                }
                            });
                        }
                    });
                } else {
                    alert('Check again');
                }
            }
            function caltoa() {
                var x = Number(document.getElementById('sc').innerHTML);
                var y = Number(document.getElementById('am').innerHTML);
                var z = Number(document.getElementById('dis').innerHTML);
                document.getElementById('total').innerHTML = Number(y - z) + Number(x);
                commit_1();
            }
            function calculateDistance(a)
            {
                try
                {
                    var glatlng1 = new GLatLng(location1.lat, location1.lon);
                    var glatlng2 = new GLatLng(location2.lat, location2.lon);
                    var miledistance = glatlng1.distanceFrom(glatlng2, 3959).toFixed(1);
                    var kmdistance = (miledistance * 1.609344).toFixed(1);
                    //alert(kmdistance);

                    if (kmdistance != null && kmdistance != "") {

                        if (Number(kmdistance) < 259) {
                            checkBrowser();
                            obj.onreadystatechange = function () {
                                if (obj.readyState === 4 && obj.status === 200) {

                                    document.getElementById('sc').innerHTML = obj.responseText;
                                    if (document.getElementById('mxb').style.display != "none") {


                                        document.getElementById('mxb').style.display = "none";
                                        document.getElementById('mib').style.display = "none";
                                        document.getElementById('add1').readOnly = true;
                                        document.getElementById('add2').readOnly = true;
                                        document.getElementById('add3').readOnly = true;
                                        document.getElementById('pc1').style.display = "none";
                                        document.getElementById('pc2').style.display = "none";
                                        document.getElementById('pc3').style.display = "none";
                                    }
                                    caltoa();
                                }
                            };
                            obj.open("POST", "dchargemaker", true);
                            obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                            obj.send('km=' + kmdistance + '&dp=' + a + '&qty=' + document.getElementById('n2').value);
                        } else {
                            alert('Your Shipping address in not in Srilanka,Fist add Srilankan address')
                        }

                    } else {
                        alert('Your have an Internal Error, Select Shipping plane again')
                    }

                }
                catch (error)
                {
                    alert(error);
                }

            }
            function check() {
//                alert('sasas');
                document.getElementById('find').click();
            }
            var jsh = '';
            function commit(a) {

                jsh = a;
                showLocation(dpn.value);
            }
            function commit_1() {
                checkBrowser();
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {
                        if (obj.responseText != 'This Qty is Not Avalable') {
                            //alert('sasasas');
                            if (jsh != null && jsh != "") {
                                document.getElementById('f1').style.display = "none";
                                document.getElementById('f2').style.display = "block";
                            }
                            var t = JSON.parse(obj.responseText);
//                            alert(obj.responseText);

                            document.getElementById('ba').innerHTML = t.data.amo;
                            document.getElementById('bq').innerHTML = t.data.qty;
                            document.getElementById('bd').innerHTML = t.data.dis;
                            document.getElementById('bs').innerHTML = t.data.sc;
                            document.getElementById('bt').innerHTML = t.data.tot;
                            document.getElementById('dasti').innerHTML = 'Deilvery Estimate: (before to)' + t.data.da;
                        } else {
                            alert(obj.responseText);
                        }
                    }
                };
                document.getElementById('dasti').innerHTML = "";
                var iid = document.getElementById('itemid').innerHTML;
                var uid = document.getElementById('userid').innerHTML;
                var col = document.getElementById('color').innerHTML;
                var qty = document.getElementById('n2').value;
                var sc = document.getElementById('sc').innerHTML;
                obj.open("POST", "CheckFinalpay", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send('iid=' + iid + '&uid=' + uid + '&col=' + col + '&qty=' + qty + '&sc=' + sc);
            }
            function sat() {
                document.getElementById('sa1').innerHTML = document.getElementById('add1').value;
                document.getElementById('sa2').innerHTML = document.getElementById('add2').value;
                document.getElementById('sa3').innerHTML = document.getElementById('add3').value;
            }
            function adddonate() {
                document.getElementById('bdonate').innerHTML = document.getElementById('dv').value;
                document.getElementById('bt').innerHTML = Number(document.getElementById('bt').innerHTML) + Number(document.getElementById('dv').value);
            }

            function buy() {
                checkBrowser();
                obj.onreadystatechange = function () {


                    if (obj.readyState === 4 && obj.status === 200) {

                        if (obj.responseText == 'a') {

                            document.getElementById('pf').submit();
                            window.location = '_ThankYouForCheckout.jsp';

                        } else {
                            alert(obj.responseText);
                        }
                    }
                };

                var iid = document.getElementById('itemid').innerHTML;
                var uid = document.getElementById('userid').innerHTML;
                var col = document.getElementById('color').innerHTML;
                var qty = document.getElementById('bq').innerHTML;
                var sihiping = document.getElementById('bs').innerHTML;
                var sihipingplane = document.getElementById('dpn').value;
                var donate = document.getElementById('dv').value;
                var donateplane = document.getElementById('dplane').innerHTML;

                var x = document.getElementById('sa1').innerHTML;
                var y = document.getElementById('sa2').innerHTML;
                var z = document.getElementById('sa3').innerHTML;

                obj.open("POST", "Payto", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send('iid=' + iid + '&uid=' + uid + '&col=' + col + '&qty=' + qty + '&sh=' + sihiping + '&shp=' + sihipingplane + '&do=' + donate + '&dop=' + donateplane + '&x=' + x + '&y=' + y + '&z=' + z);
            }
        </script>

    </head>
    <body onload="initialize()" style="background: url(img/Backimage1.jpg) repeat top left;">
        <div Class="maintable_w" style="margin-left: 10px; ">
            <%@include file="hedder_withoutimageslider.jsp" %>

            <%                Session sr = new HibernateConnection().getSessionFactory().openSession();
                Modulo26Crypto mo = new Modulo26Crypto();
                String itemid = ((Integer.valueOf(request.getParameter("iid")) / 525) + 525) + "";
                String userid = ((Integer.valueOf(request.getParameter("uid")) / 527) + 725) + "";;
                String color = request.getParameter("col");
                String qty = ((Integer.valueOf(request.getParameter("qty")) / 529) + 925) + "";
                String msg = "";

                double dis = 00.0;

                System.out.print(itemid);
                System.out.print(userid);
                System.out.print(color);
                System.out.print(qty);
                System.out.print(msg);

                Criteria ck = sr.createCriteria(Databasefile.Product.class);
                ck.add(Restrictions.eq("idProduct", Integer.valueOf(itemid)));
                Databasefile.Product product = (Databasefile.Product) ck.uniqueResult();

                Criteria cc = sr.createCriteria(Databasefile.Color.class);
                cc.add(Restrictions.eq("name", color));
                Databasefile.Color col = (Databasefile.Color) cc.uniqueResult();

                Criteria cp = sr.createCriteria(Databasefile.ProductHasColor.class);
                cp.add(Restrictions.eq("product", product));
                cp.add(Restrictions.eq("color", col));
                Databasefile.ProductHasColor phc = (Databasefile.ProductHasColor) cp.uniqueResult();

                Criteria cu = sr.createCriteria(Databasefile.User.class);
                cu.add(Restrictions.eq("idUser", Integer.valueOf(userid)));
                Databasefile.User usr = (Databasefile.User) cu.uniqueResult();

                Criteria ci = sr.createCriteria(Databasefile.Productimage.class);
                ci.add(Restrictions.eq("product", product));
                Databasefile.Productimage pi = (Databasefile.Productimage) ci.uniqueResult();

                if (Integer.valueOf(qty) <= phc.getQty()) {
                    msg = "Avalable QTY";
                } else {
                    msg = "Unavalable QTY";
                }

                Criteria cdd = sr.createCriteria(Databasefile.Discount.class);
                cdd.add(Restrictions.eq("product", product));
                Databasefile.Discount disc = (Databasefile.Discount) cdd.uniqueResult();


            %>

            <center>

                <div style=" height: 390px; width: 1200px; padding-top: 30px;margin-top: 5px; display: none;" id="f2">
                    <table style="height: 350px; width: 1200px;">
                        <tr>
                            <td>
                                <div>
                                    <table  style="width:900px;height: 350px;">
                                        <tr>
                                            <td>
                                                <div style="width: 700px; float: top; margin-top: 35px;">
                                                    <h3 class="label-info">Ship to</h3>
                                                    <label id="sa1" ></label><br>
                                                    <label id="sa2" ></label><br>
                                                    <label id="sa3" ></label><br>
                                                    <label class="label label-danger">Only Ship to Sri Lanka</label><br>
                                                    <label id="dasti" class="label label-warning"></label><br>
                                                </div>
                                            </td>
                                            <td>
                                                <div style="width: 200px; float: top; ">
                                                    <h3 class="label-info">Pay With</h3>
                                                    <img src="img/paypal-logo.png" width="200px" height="100px">
                                                </div>
                                            </td>
                                        </tr> 
                                        <tr>
                                            <td colspan="2">
                                                <div style="height: 150px;">

                                                    <%                                                        Criteria dc = ses.createCriteria(Databasefile.Donateresion.class);
                                                        dc.add(Restrictions.eq("states", "1"));
                                                        Databasefile.Donateresion dr = (Databasefile.Donateresion) dc.uniqueResult();

                                                    %>

                                                    <h3 class="label-primary" style="color: #ffffff;">Add Donate to:</h3><h4 style="color: #ffffff;" id="dplane"><%= dr.getName()%></h4>
                                                    Rs(LKR):<input type="number" id="dv" pattern="^[0-9]" title='Only Number' min="0" step="100" class="form-control" style="width: 200px" onkeypress='return event.charCode >= 48 && event.charCode <= 57' value="0">

                                                    <button class="btn btn-group" onclick="adddonate()">Add to Donate</button>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div> 
                            </td>
                            <td>
                                <div style="margin-top: -140px;">
                                    <table>
                                        <tr>
                                            <td>Amount</td>
                                            <td><h4 id="ba" style="text-align: right;"></h4></td>
                                        </tr>
                                        <tr>
                                            <td>QTY</td>
                                            <td><h4 id="bq" style="text-align: right;"></h4></td>
                                        </tr>
                                        <tr>
                                            <td>Discount</td>
                                            <td><h4 id="bd" style="text-align: right;"></h4></td>
                                        </tr>
                                        <tr>
                                            <td>Shipping Charge</td>
                                            <td><h4 id="bs" style="text-align: right;"></h4></td>
                                        </tr>
                                        <tr>
                                            <td>Donate</td>
                                            <td><h4 id="bdonate" style="text-align: right;">00.00</h4></td>
                                        </tr>
                                        <tr>
                                            <td>Total</td>
                                            <td><h4 id="bt" style="text-align: right;"></h4</td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td><button class="btn btn-danger" onclick="buy()">Pay Now</button></td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

                <form target="paypal" action="https://www.paypal.com/cgi-bin/webscr" method="post" name="pf" id="pf">
                    <input type="hidden" name="cmd" value="_s-xclick">
                    <input type="hidden" name="hosted_button_id" value="JGPNM5E634B42">
                    <input type="image" src="" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!" style="display: none;">
                    <img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
                </form>


                <div style=" height: 390px; padding-top: 30px;margin-top: 5px;" id="f1">
                    <label id="hdt" style="display: none;"><%= disc.getDistype().getType()%></label>
                    <label id="hamount" style="display: none;"><%= disc.getDiscount()%></label>

                    <label id="itemid" style="display: none;"><%= itemid%></label>
                    <label id="userid" style="display: none;"><%= userid%></label>
                    <label id="color" style="display: none;"><%= color%></label>


                    <table style="width: 1200px;overflow-y: auto;" id="ct">
                        <tr>
                            <td style="width: 900px">
                                <table>
                                    <tr>
                                        <td style="width: 300px">
                                            <img src="<%= pi.getUrl1()%>" class="img img-responsive" width="200px" height="200px">

                                        </td>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td style="text-align: right"><h4>Product</h4></td>
                                                    <td><h5 style="text-align: center"><%= product.getName()%></h5></td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: right"><h4>Product Description</h4></td>
                                                    <td><h5 style="text-align: center"><%= product.getDiscription()%></h5></td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: right"><h4>Color</h4></td>
                                                    <td><h5 style="text-align: center"><%= color%></h5></td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: right"><h4>Size</h4></td>
                                                    <td><h5 style="text-align: center"><%= product.getSize().getName()%></h5></td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: right"><h4>QTY</h4></td>
                                                    <td >
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <button onclick="min()" class="btn btn-default" id="mib">-</button>
                                                                </td>
                                                                <td>  
                                                                    <input type="text"  id="n2" class="form-control" value="<%= Integer.valueOf(qty)%>" style="width: 70px; text-align: center;" readonly>
                                                                </td>
                                                                <td> 
                                                                    <button class="btn btn-default"  onclick="max()" id="mxb">+</button>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td>
                                                        <label id="lab1" class="label label-danger"><%= msg%></label>
                                                    </td>
                                                </tr>
                                                <tr >
                                                    <td style="text-align: right; top: -50px;"><h4 style="margin-top: -45px;">Shipping Address</h4></td>
                                                    <td>
                                                        <table>
                                                            <tr><td><input type="text" id="add1" placeholder="Address" class="form-control" value="<%= usr.getAddress1()%>"></td><td><img src="img/pencil.png" id="pc1" width="20px" height="20px"></td></tr>
                                                            <tr><td><input type="text" id="add2" placeholder="Address" class="form-control" value="<%= usr.getAddress2()%>"></td><td><img src="img/pencil.png" id="pc2" width="20px" height="20px"></td></tr>
                                                            <tr><td>
                                                                    <form action="#" >
                                                                        <input type="text" name="address1" value="Kurunegala" class="address_input" style="display: none;" />
                                                                        <input type="text" name="address2" id="add3" placeholder="City" class="form-control" value="<%= usr.getCity()%>">

                                                                    </form>
                                                                </td>
                                                                <td><img src="img/pencil.png" id="pc3" width="20px" height="20px"></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: right"><h4>Shipping Plane</h4></td>
                                                    <td>
                                                        <select id="dpn" class="form-control" onchange="showLocation(this.value, 'dsdsd');
                                                                return false;">
                                                            <%
                                                                DecimalFormat dcf = new DecimalFormat("#.00");

                                                                Criteria cd = sr.createCriteria(Databasefile.Delavary.class);
                                                                List<Databasefile.Delavary> dl = cd.list();
                                                                for (Databasefile.Delavary di : dl) {

                                                            %>
                                                            <option id="dp" ><%= di.getName()%></option>
                                                            <%}%>
                                                        </select>
                                                    </td>
                                                    <td></td>
                                                </tr>


                                            </table> 
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <div>
                                    <img src="img/MoneyBack.png" width="300px"  class="img img-responsive " >
                                </div>
                                <table>
                                    <tr>
                                        <td style="text-align: right"><h4>Shipping Charge</h4></td>
                                        <td><h4 id="sc" style="color: red; margin-left: 60px; text-align: right;">00.00</h4></td>
                                        <td></td>
                                    </tr>

                                    <tr>
                                        <td style="text-align: right"><h4>Amount</h4></td>
                                        <td><h4 id="am" style="color: red; margin-left: 60px;text-align: right;"><%= dcf.format(product.getAmount() * Integer.valueOf(qty))%></h4></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right"><h4>Discount</h4></td>
                                        <td><h4 id="dis" style="color: red; margin-left: 60px;text-align: right;">00.00</h4></td>
                                        <td></td>
                                    </tr>

                                    <tr>
                                        <td style="text-align: right"><h4>Total</h4></td>
                                        <td><h4 id="total" style="color: red; margin-left: 60px;text-align: right;">00.00</h4></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td style="text-align: right;text-align: right;"><button class="btn btn-info" onclick="commit('abc')">Commit to Buy</button></td>
                                        <td></td>
                                    </tr>
                                </table>
                            </td>

                        </tr>
                    </table>
                </div>
            </center>
            <%

            %>
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
