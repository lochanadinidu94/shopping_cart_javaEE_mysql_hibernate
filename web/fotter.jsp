<%-- 
    Document   : fotter
    Created on : Nov 10, 2015, 11:24:03 AM
    Author     : Lochana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/mysty.css" rel="stylesheet" type="text/css">
        <title>JSP Page</title>

        <!--Shair Head -->




    </head>
    <body>

        <div Class="s_fotter">

            <!-- Share -->
            <center>
                <p Class="s_fotter_text" style="padding-top: 30px;">All Right Reserved by Dinidu Lochana Dissanayake</p>
            </center>
            <!-- Share -->

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
