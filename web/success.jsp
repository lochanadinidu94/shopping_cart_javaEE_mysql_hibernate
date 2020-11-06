<%-- 
    Document   : success
    Created on : Nov 10, 2015, 8:56:33 PM
    Author     : Lochana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>


    </head>
    <body style="background: url(img/Backimage1.jpg) repeat top left;">
        <table  width ="1100px" height ="400px" style=" position: relative; left:110px ">
            <tr>
                <td>
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
