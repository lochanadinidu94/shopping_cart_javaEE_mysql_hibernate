<%-- 
    Document   : _Admin_Login
    Created on : Nov 21, 2015, 8:13:35 PM
    Author     : Lochana
--%>
`
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link media="all" rel="stylesheet" type="text/css" href="css/all.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css.css" />
        
        
        <title>C Panel</title>

        <style type="text/css">
            .div_cp{
                position: absolute;
                width: 400px;
                height: 300px;
                top: 200px;
                left: 500px;
               
                border-bottom-left-radius: 2px;
                border-bottom-right-radius: 2px;
            }
             .abc {
                border: 1px #e4e4e4 solid;
                padding: 20px;
                border-radius: 4px;
                box-shadow: 0 0 6px #ccc;
            }
        </style>

        <script type="text/javascript">

            function ClearHistory()
            {
//            alert(navigator.appName);
                window.history.forward(1);
//            $(document).ready(function () {
//                window.history.forward(1);
//            });
            }

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

                        if (a == 'ok') {
//                            alert('aaaaaa');
                            window.location = 'http://localhost:8080/Final_AJD_Project/_Admin_DashBord.jsp';
                        } else {
                            alert(a);
                        }
                    }
                };
                obj.open("POST", "adminlogin", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("un=" + document.getElementById('un').value + "&pw=" + document.getElementById('pw').value);
            }

        </script>

    </head>
    <body onload="ClearHistory()">
        <div class="div_cp abc">

            <h3>Login to Admin Panel</h3>

            <center>
                <!--<form method="post" action="adminlogin">-->
                <input type="text" class="form-control" placeholder="User Name" id="un">
                <input type="password" class="form-control" placeholder="Password" id="pw"><br>

                <h5><a href="_Admin_Forget.jsp" class="links" style="position: relative;float: left;">Forget Password?</a></h5>

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
