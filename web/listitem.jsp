<%-- 
    Document   : listitem
    Created on : Nov 10, 2015, 11:23:05 AM
    Author     : Lochana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css.css" />

        <link href="css/popup_styles.css" rel="stylesheet" type="text/css" />

        <script type="text/javascript">

            var obj;
            var j = 1;

            function checkBrowser() {
                if (window.XMLHttpRequest) {
                    obj = new XMLHttpRequest();
                } else {
                    obj = new ActiveXobject("Microfoft.ActiveXobject");
                }
            }

            function lordTable() {
                checkBrowser();
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {
                        document.getElementById('tab1').innerHTML = obj.responseText;
                    }
                };
                obj.open("POST", "FistPageItemHtml", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send();
            }

            function bl(a, b) {
//                alert(b);
                document.getElementById(a).style.display = "block";
                document.getElementById('wap').style.display = "none";
//                window.open("#"+a, "Add to Cart", "height=350,width=400")
//                addCart(b);
            }
            function bk(a) {

                document.getElementById(a).style.display = "none";
                document.getElementById('wap').style.display = "block";
            }



            function addCart(a) {
                alert(a);
            }
            function addWishList(a) {
                alert(a);
            }
            function Checkout(a) {
                alert(a);
            }
        </script>

    </head>
    <body onload="lordTable()">

        <div id="popUpDiv" style="display:none; top: 800px;" >

            <center>
                <table border="0" width="350px" height = "250px">
                    <tr><td><h3><center>Add To Cart</center></h3></td></tr>
                    <tr>
                        <td width="150px">Color</td>
                        <td width="200px">

                            <select class="form-control" id="ac_1">
                            </select>

                        </td>
                    </tr>
                    <tr>
                        <td width="150px">QTY</td>
                        <td width="200px">

                            <button onclick="" class="btn btn-default">-</button>
                            <input type="text"  id="n1">
                            <button onclick="" class="btn btn-default">+</button>

                        </td>
                    </tr>
                    <label style="display: none;" id="hid"></label>
                    <tr><td></td><td><input type="submit" value="Add" class="btn btn-default" onclick="addCart(hid.value)"><button class="btn btn-danger" style="position: relative;left: 20px" onclick="bk('popUpDiv')">Close</button></td></tr>

                </table>
            </center>
        </div>


        <div class="imageitem" id="wap">
            <h1 style=" position: relative;left: -860px;">Popular Items</h1>

            <table  width = "1200px" height = "1050px" style=" position: relative; left:70px ;" id="tab1">

            </table>

        </div> 
        <div class="pageinnertion">

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
