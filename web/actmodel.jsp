<%-- 
    Document   : actmodel
    Created on : Nov 10, 2015, 7:22:04 PM
    Author     : Lochana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="bootstrap/css/bootstrap-theme.css" rel="stylesheet" type="text/css">
        <link href="bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css">
        <script src="js/ur.js" type="text/javascript"></script>

       

    </head>
    <body style="background: url(img/Backimage1.jpg) repeat top left;">
        <table  width ="1100px" height ="400px" style=" position: relative; left:110px ">
            <tr>
                <td>
                    <form action="validation" role="form" method="post">
                        <center>
                            <h2>Verify Code</h2>
                            <input type="text" name="email" class="form-control" placeholder="Email" style="width: 400px"/>
                            <input type="text" name="activation" class="form-control" placeholder="Verifi Code" style="width: 400px"/>
                            <input type="submit" value="Activation" class="btn btn-default"/>
                        </center>
                    </form>
                </td>
            </tr>
        </table>
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
