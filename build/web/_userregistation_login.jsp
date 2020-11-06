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
        <title>Sign up and Login</title>
        <link href="css/mysty.css" rel="stylesheet" type="text/css">
        <style type="text/css">
            body{
                background: url(img/Backimage1.jpg) repeat top left;
            }
        </style>
    </head>
    <body onload="ClearHistory()" style="background: url(img/Backimage1.jpg) repeat top left;">
        <div Class="maintable_w" style="margin-left: 10px;">
            <%@include file="hedder_withoutimageslider.jsp" %>
            <%@include file="registation.jsp" %>
            <%@include file="fotter.jsp" %>
        </div>
        <%//        response.setHeader("Cache-Control", "no-cache");
//            response.setHeader("Cache-Control", "no-store");
//            response.setHeader("Pragma", "no-cache");
//            response.setDateHeader("Expires", 0);
//            if (session.getAttribute("token") == null) {
//                response.sendRedirect(request.getContextPath() + "/_index.jsp");
//
//            }
%>
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

        function chechkuser() {


//            if (document.getElementById('uhid').innerHTML != "") {
////                window.location = '_index.jsp';
//            $(document).ready(function () {
//                window.history.forward(1);
//            });
//            }

        }

        function ClearHistory()
        {
//            alert(navigator.appName);
            window.history.forward(1);
//            $(document).ready(function () {
//                window.history.forward(1);
//            });
        }

    </script>
</html>
