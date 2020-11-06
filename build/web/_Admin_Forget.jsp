<%-- 
    Document   : _Admin_Login
    Created on : Nov 21, 2015, 8:13:35 PM
    Author     : Lochana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link media="all" rel="stylesheet" type="text/css" href="css/all.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css.css" />
        <title>Forget Password</title>

        <style type="text/css">
            .div_cp{
                position: absolute;
                width: 400px;
                height: 300px;
                top: 250px;
                left: 500px;
                border-bottom-left-radius: 2px;
                border-bottom-right-radius: 2px;
            }
        </style>

        <script type="text/javascript">

            var obj;
            function checkBrowser() {
                if (window.XMLHttpRequest) {
                    obj = new XMLHttpRequest();
                } else {
                    obj = new ActiveXobject("Microfoft.ActiveXobject");
                }
            }
            function login() {
                checkBrowser();
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {
                        var a = obj.responseText;
                        alert(a);
                        window.location = '_Admin_Login.jsp';
                    }
                };
                obj.open("POST", "adminforgetpassword", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("email=" + document.getElementById('un').value);
            }

        </script>

    </head>
    <body>
        <div class="div_cp">

            <h3>Login to Admin Panel</h3>

            <center>
                <!--<form method="post" action="adminlogin">-->
                <input type="text" class="form-control" placeholder="User Name" id="un">


                <input type="submit" value="Login" class="btn btn-default" style="position: relative;float: right" onclick="login()">
                <!--</form>-->
            </center>
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
