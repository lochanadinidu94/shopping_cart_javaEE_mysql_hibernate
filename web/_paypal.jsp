<%-- 
    Document   : _paypal
    Created on : Dec 13, 2015, 10:38:15 PM
    Author     : Lochana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <style type="text/css">

            .paypal_btn{
                display: inline-block;
                font-family: inherit;
                font-size: 14px;
                font-weight: bold;
                color: #fff;
                text-align: center;
                padding: 10px 14px;
                margin: 0;
                background: #ff6600;
                border: 0;
                cursor: pointer;
                outline: none;
            }
            .paypal_btn:hover{ background: #e05c04; }

        </style>

    </head>
    <body>

        <form target="paypal" action="https://www.paypal.com/cgi-bin/webscr" method="post">
            <input type="hidden" name="cmd" value="_s-xclick">
            <input type="hidden" name="hosted_button_id" value="JGPNM5E634B42">
            <input type="image" src="" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
            <img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
        </form>

<!--        <input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_cart_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">

        <input type="submit" value="Add to Cart" name="submit" title="PayPal - The safer, easier way to pay online!" class="paypal_btn">-->

<!--https://www.paypalobjects.com/en_US/i/btn/btn_cart_LG.gif-->

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
