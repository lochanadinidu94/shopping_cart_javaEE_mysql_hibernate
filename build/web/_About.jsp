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
        <title>About</title>
        <link href="css/mysty.css" rel="stylesheet" type="text/css">
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css.css" />
       
        
    </head>
    <body style="background: url(img/Backimage1.jpg) repeat top left;">
        <div Class="maintable_w" style="margin-left: 10px;">
            <%@include file="hedder_withoutimageslider.jsp" %>
            <center>
                <table style="height: 350px;">
                    <tr>
                        <td style="width: 500px">
                            <h3>E Market (PVT) ltd.</h3>
                            <h4>Main Shop:-</h4>
                            <h5>No 175/5A</h5>
                            <h5>Wihara Para</h5>
                            <h5>Dewana haras vidiya</h5>
                            <h5>Mathale</h5>
                            <h4>Mobile:</h4>
                            <h5>071 1043828</h5>
                            <h4>E-Mail:</h4>
                            <h5>drpcsoftwaresolution@gmail.com</h5>
                        </td>
                        <td style="width: 500px;">
                            <form method="post" action="savemsg">
                                <textarea name="msg" style="width: 300px;height: 200px">
                                
                                </textarea>
                                <button class="btn btn-info">Send</button>
                            </form>
                        </td>
                    </tr>
                </table>
                
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
