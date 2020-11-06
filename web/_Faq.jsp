<%-- 
    Document   : userregistation_login
    Created on : Nov 10, 2015, 11:33:55 AM
    Author     : Lochana
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FAQ</title>
        <link href="css/mysty.css" rel="stylesheet" type="text/css">
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css.css" />


    </head>
    <body style="background: url(img/Backimage1.jpg) repeat top left;">
        <div Class="maintable_w" style="margin-left: 10px;">
            <%@include file="hedder_withoutimageslider.jsp" %>
            <center>
                <table width="1200px" height="400px" >
                    <tr>
                        <td style="width:600px; height: 400px;">
                            <div style="width:600px; height: 400px;overflow-y: auto;">
                                <center>
                                    <table width="600px" height="400px" style="overflow-y: auto;">
                                        <%                                            Criteria ces = ses.createCriteria(Databasefile.Faq.class);
                                            List<Databasefile.Faq> cl = ces.list();
                                            for (Databasefile.Faq b : cl) {
                                        %>
                                        <tr>
                                            <td>
                                                <h4 style="color: orange;"><%= b.getQuatation()%></h4>
                                                <h5><%= b.getAnswer()%></h5>
                                            </td>
                                        </tr>
                                        <%}%>
                                    </table>
                                </center>
                            </div>
                        </td>
                        <td>

                            <div style="width:600px; height: 400px;overflow-y: auto;">

                                <h3 style="color: orange;margin-left: 10px;" >Other</h3>
                                <form action="saveufaq" method="post">
                                    <input type="text" name="n" placeholder="Name(Optional)" class="form-control" style="width: 200px; margin-left: 10px;">
                                    <textarea style="width: 500px;height: 150px; margin-left: 10px;" class="form-control" name="q">
                                    
                                    </textarea>
                                    <input type="submit" class="btn btn-default" style="margin-left: 10px;" value="Send">
                                </form>
                                <table width="600px" style="overflow-y: auto;height: auto;">
                                    <%
                                        Criteria ces1 = ses.createCriteria(Databasefile.Quackanswer.class);
                                        List<Databasefile.Quackanswer> cl1 = ces1.list();
                                        for (Databasefile.Quackanswer b1 : cl1) {

                                            if (b1 != null) {
                                    %>
                                    <tr>
                                        <td>
                                            <h4 style="color: orange; margin-left: 10px;"><%= b1.getName()%></h4>
                                            <h5 style="margin-left: 10px;"><%= b1.getData()%></h5>
                                        </td>
                                    </tr>
                                    <%}
                                        }%>
                                </table>
                            </div>

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
