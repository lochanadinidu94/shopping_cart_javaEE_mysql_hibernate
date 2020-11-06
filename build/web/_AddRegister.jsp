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
        <title>Choose Advertisement</title>
        <link href="css/mysty.css" rel="stylesheet" type="text/css">
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css" />

        <link href="css/popup_styles.css" rel="stylesheet" type="text/css" />

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

        <script type="text/javascript">
            var obj;

            function checkBrowser() {
                if (window.XMLHttpRequest) {
                    obj = new XMLHttpRequest();
                } else {
                    obj = new ActiveXobject("Microfoft.ActiveXobject");
                }
            }

            function addr(type) {
                if (document.getElementById('uhid').innerHTML != null && document.getElementById('uhid').innerHTML != "") {


                    var form = document.createElement("form");
                    input = document.createElement("input");

                    form.action = "_AddRegister_1.jsp";
                    form.method = "post"

                    input.name = "p";
                    input.value = type;


                    form.appendChild(input);

                    document.body.appendChild(form);
                    form.submit();

                } else {

                    alert('Fist Login to System and try again');

                }

            }

            var key = "SXGWLZPDOKFIVUHJYTQBNMACERxswgzldpkoifuvjhtybqmncare";

            function encodeStr(uncoded) {
                uncoded = uncoded.toUpperCase().replace(/^\s+|\s+$/g, "");
                var coded = "";
                var chr;
                for (var i = uncoded.length - 1; i >= 0; i--) {
                    chr = uncoded.charCodeAt(i);
                    coded += (chr >= 65 && chr <= 90) ?
                            key.charAt(chr - 65 + 26 * Math.floor(Math.random() * 2)) :
                            String.fromCharCode(chr);
                }
                return encodeURIComponent(coded);
            }

            function lad() {
                document.getElementById('gpl').click();
            }

        </script>

        <style type="text/css">
            .abc {
                border: 1px #e4e4e4 solid;
                padding: 20px;
                border-radius: 4px;
                box-shadow: 0 0 6px #ccc;
            }
        </style>

    </head>
    <body onload="lad()" style="background: url(img/Backimage1.jpg) repeat top left;">


        <div Class="maintable_w" style="margin-left: 10px;" id="maintable_wid">
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
                <div style=" height: 450px; width: 1200px; padding-top: 20px;">

                    <table style="width: 1200px; margin-top: 30px;">
                        <tr>
                            <td style="width: 400px; height: 380px;">

                                <table style="width: 350px; height: 350px;" class="abc">
                                    <tr style="height: 50px; ">
                                        <td>
                                            <h2 style="text-align: center; color: slategrey;">Silver Plan</h2>
                                        </td>
                                    </tr>
                                    <tr style="height: 250px;">
                                        <td>
                                            <h4 style="color: orange;text-align: center;">You Can add 200x100 4 Images</h4>
                                            <h4 style="color: orange;text-align: center;">Add is Avaliable 7 days</h4>
                                            <h4 style="color: orange;text-align: center;">Only Show home page</h4>
                                            <h4 style="color: orange;text-align: center;">Show in Banner</h4>
                                            <h3 style="color: red;text-align: center;">Rs:750.00 <small>only</small></h3>
                                        </td>
                                    </tr>
                                    <tr style="height: 50px;">
                                        <td>
                                    <center>
                                        <button class="btn btn-info" style="width: 200px;" onclick="addr('Silver')">Apply</button>
                                    </center>
                            </td>
                        </tr>
                    </table>

                    </td>
                    <td style="width: 400px; height: 380px;">
                        <table style="width: 350px; height: 350px;" class="abc">
                            <tr style="height: 50px; ">
                                <td>
                                    <h2 style="text-align: center; color: slategrey;">Gold Plan</h2>
                                </td>
                            </tr>
                            <tr style="height: 250px;">
                                <td>
                                     <h4 style="color: orange;text-align: center;">You Can add 500x300 4 Images</h4>
                                    <h4 style="color: orange;text-align: center;">Add is Avaliable 14 days</h4>
                                    <h4 style="color: orange;text-align: center;">Only Show home page</h4>
                                    <h4 style="color: orange;text-align: center;">Show in Pop up</h4>
                                    <h3 style="color: red;text-align: center;">Rs:2000.00 <small>only</small></h3>
                                </td>
                            </tr>
                            <tr style="height: 50px;">
                                <td>
                            <center>
                                <button class="btn btn-info" style="width: 200px;" onclick="addr('Gold')">Apply</button>
                            </center>
                    </td>
                    </tr>
                    </table>
                    </td>
                    <td style="width: 400px; height: 380px;">
                        <table style="width: 350px; height: 350px;" class="abc">
                            <tr style="height: 50px; ">
                                <td>
                                    <h2 style="text-align: center; color: slategrey;">Platinum Plan</h2>
                                </td>
                            </tr>
                            <tr style="height: 250px;">
                                <td>
                                    <h4 style="color: orange;text-align: center;">You Can add 1000x500 4 Images</h4>
                                    <h4 style="color: orange;text-align: center;">Add is Avaliable 30 days</h4>
                                    <h4 style="color: orange;text-align: center;">Show many pages</h4>
                                    <h4 style="color: orange;text-align: center;">Show in Pop up</h4>
                                    <h3 style="color: red;text-align: center;">Rs:4000.00 <small>only</small></h3>
                                </td>
                            </tr>
                            <tr style="height: 50px;">
                                <td>
                            <center>
                                <button class="btn btn-info" style="width: 200px;" onclick="addr('Platinum')">Apply</button>
                            </center>
                    </td>
                    </tr>
                    </table>
                    </td>
                    </tr>
                    </table>

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
