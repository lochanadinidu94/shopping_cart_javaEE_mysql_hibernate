<%-- 
    Document   : test
    Created on : Nov 21, 2015, 10:12:43 PM
    Author     : Lochana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <form method="post" enctype="multipart/form-data" action="up">
            Image Name:
            <input  type="text" name="imgName"/><br><br>
            Select IMG:
            <input type="file" name="img"/><br><br>
            <input type="submit" value="Uplord"/>
        </form>
    </body>
</html>
