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
        <title>Advertisement</title>
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


            var key = "SXGWLZPDOKFIVUHJYTQBNMACERxswgzldpkoifuvjhtybqmncare";
            function decodeStr(coded) {
                coded = decodeURIComponent(coded);
                var uncoded = "";
                var chr;
                for (var i = coded.length - 1; i >= 0; i--) {
                    chr = coded.charAt(i);
                    uncoded += (chr >= "a" && chr <= "z" || chr >= "A" && chr <= "Z") ?
                            String.fromCharCode(65 + key.indexOf(chr) % 26) :
                            chr;
                }
                return uncoded;
            }

            function setplane() {

                alert(decodeStr(document.getElementById('hpl').innerHTML));
            }

            function next() {
                if (document.getElementById('t1').value == 'null' || document.getElementById('t1').value === "") {

                    document.getElementById('s1').style.color = "red";
                    document.getElementById('st1').style.display = "none";
                    document.getElementById('st2').style.display = "block";
                } else {

                    document.getElementById('s1').style.color = "#009F00";
                    document.getElementById('st1').style.display = "none";
                    document.getElementById('st2').style.display = "block";
                }

            }

            function backto() {

                if (document.getElementById('im1').value === "" || document.getElementById('im2').value === "" || document.getElementById('im3').value === "" || document.getElementById('im4').value === "") {

                    document.getElementById('s2').style.color = "red";
                    document.getElementById('st2').style.display = "none";
                    document.getElementById('st1').style.display = "block";
                } else {

                    document.getElementById('s2').style.color = "#009F00";
                    document.getElementById('st2').style.display = "none";
                    document.getElementById('st1').style.display = "block";
                }

            }

            function save() {

                var uid = document.getElementById('uhid').innerHTML;
                var pla = document.getElementById('t1').value;
                var rea = document.getElementById('t2').value;

//                alert(uid);
//                alert(uid);

                if (uid !== '' || document.getElementById('t1').value !== 'null' || document.getElementById('t1').value !== "") {

                    if (document.getElementById('im1').value != '' && document.getElementById('im2').value != '' && document.getElementById('im3').value != '' && document.getElementById('im4').value != '') {

//                        alert('sssssssssssssssssssss')
                        checkBrowser();

                        obj.onreadystatechange = function () {
                            if (obj.readyState === 4 && obj.status === 200) {
//                                alert('vvvvvvvvvvvvvvvvvvvvvvv')
                                document.getElementById('aid').value = obj.responseText;
//                                alert(document.getElementById('aid').value);
//                                alert(obj.responseText);

                                document.getElementById('imagesub').click();
                                document.getElementById('pf').submit();

                            }
                        };

//                        alert('ppppppppppppppppppppppppp')
                        obj.open("POST", "regaddver", true);
                        obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                        obj.send('uid=' + uid + '&pla=' + pla + '&rea=' + rea);
//                        alert('lllllllllllllllllll')
                    } else {
                        alert("Please Choose Image File");
                    }

                } else {

                    alert('Fill all information and try agin!');

                }

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

    <body onload="" style="background: url(img/Backimage1.jpg) repeat top left;">


        <div Class="maintable_w" style="margin-left: 10px;" id="maintable_wid">
            <%@include file="hedder_withoutimageslider.jsp" %>

            <form target="paypal" action="https://www.paypal.com/cgi-bin/webscr" method="post" name="pf" id="pf">
                <input type="hidden" name="cmd" value="_s-xclick">
                <input type="hidden" name="hosted_button_id" value="JGPNM5E634B42">
                <input type="image" src="" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!" style="display: none;">
                <img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
            </form>

            <center>
                <div style=" height: 450px; width: 1200px; padding-top: 20px;">
                    <center>
                        <table style="width: 1200px;height: 400px;margin-top: 20px;" >
                            <tr>
                                <td style="width: 800px;">
                                    <div id="st1" style="width: 800px;height: 400px;" class="abc">
                                        <center>
                                            <table style="width: 600px;height: 300px;">
                                                <tr>
                                                    <td colspan="2">
                                                        <h3 style="color: #009F00;">Step 1</h3>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; font-size: 15px;" >Your Plan</td>
                                                    <td style="width: 400px;"><input type="text" style="width: 400px;" id="t1" disabled="true" class="form-control" value="<%= request.getParameter("p")%>"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; font-size: 15px;">Advertisement Domain</td>
                                                    <td style="width: 400px;"><input type="text" style="width: 400px;" id="t2" class="form-control"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px;"><button class="btn btn-success" style="width: 100px;" onclick="next()">Next</button></td>
                                                    <td style="width: 400px;"></td>
                                                </tr>
                                            </table>
                                        </center>
                                    </div>
                                    <div id="st2" style="width: 800px;height: 400px; display: none;" class="abc">
                                        <center>
                                            <form method="post" enctype="multipart/form-data" action="UplordAddImg" name="imgup">
                                                <table style="width: 600px;height: 300px;">


                                                    <tr><td><h3 style="color: #009F00;">Step 2</h3></td></tr>
                                                    <tr>
                                                        <td width="300px"><input type="file" class="btn btn-info" name="Img1" id="im1"/></td>
                                                        <td width="300px"><input type="file" class="btn btn-info" name="Img2" id="im2"/></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="300px"><input type="file" class="btn btn-info" name="Img3" id="im3"/></td>
                                                        <td width="300px"><input type="file" class="btn btn-info" name="Img4" id="im4"/></td>
                                                    </tr>

                                                    <tr><td><input type="text" id="aid" style="display: none;" name="p_i" /></td><td><input type="submit" value="Uplord" class="btn btn-default" style="position: relative;left: 110px;display: none;" id="imagesub"></td></tr>

                                                    <!--                                                    <tr>
                                                                                                            <td>
                                                                                                            </td>
                                                                                                        </tr>-->
                                                </table>
                                            </form>
                                            <button class="btn btn-success" onclick="backto()">Back</button>
                                        </center>
                                    </div>
                                </td>
                                <td style="width: 400px;">
                                    <div class="abc">
                                        <center>

                                            <%

                                                double amo = 00.00;

                                                if (request.getParameter("p").equals("Silver")) {
                                                    amo = 750.00;
                                                } else if (request.getParameter("p").equals("Gold")) {
                                                    amo = 2000.00;
                                                } else if (request.getParameter("p").equals("Platinum")) {
                                                    amo = 4000.00;
                                                }

                                            %>

                                            <h2 style="color: red;" id="amo">Rs: <%= amo%></h2>
                                            <h4 style="color:#009F00; " id="s1">Step 1</h4><br>
                                            <h4 style="color:#009F00; " id="s2">Step 1</h4><br>
                                            <button class="btn btn-danger" onclick="save();">Commit to Pay</button>
                                        </center>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </center>
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
