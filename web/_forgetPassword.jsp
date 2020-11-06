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
        <title>Forget Password</title>
        <link href="css/mysty.css" rel="stylesheet" type="text/css">
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css.css" />


    </head>
    <body style="background: url(img/Backimage1.jpg) repeat top left;">
        <div Class="maintable_w" style="margin-left: 10px;">
            <%@include file="hedder_withoutimageslider.jsp" %>
            <center>
                <table width="549px" height="150px">

                    <input type="text" placeholder="Enter Email Address" class="form-control" id="t1" style="width: 400px; margin-top: 150px">
                    <button onclick="check(t1.value);" class="btn btn-info">Submit</button>


                </table>
            </center>
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
    </script>
</html>
