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
        <title>My MSG</title>
        <link href="css/mysty.css" rel="stylesheet" type="text/css">
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css.css" />


    </head>
    <body style="background: url(img/Backimage1.jpg) repeat top left;">
        <div Class="maintable_w" style="margin-left: 10px;">
            <%@include file="hedder_withoutimageslider.jsp" %>
            <center>
                <table width="1200px" height="350px">
                    <tr>
                        <%                            String userid = "";

                            try {

                                Cookie[] cook = request.getCookies();

                                HttpSession ss = request.getSession();

                                if (cook != null) {
                                    boolean bool = false;
                                    for (int i = 0; i < cook.length; i++) {

                                        if (cook[i].getName().compareTo("loginUserId") == 0) {
                                            System.out.println("*1");
                                            userid = cook[i].getValue();
                                            bool = true;
                                        }
                                        System.out.println(i);
                                        System.out.println(cook.length);

                                        if (i + 1 == cook.length) {
                                            System.out.println("*rrrrrrrrrrrrrrrrrrrrrrrrr");
                                            if (bool != true) {
                                                userid = ss.getAttribute("loginUserId").toString();
                                            }
                                        }
                                    }

                                } else {
                                    userid = ss.getAttribute("loginUserId").toString();
                                }

                            } catch (Exception e) {
                                //e.printStackTrace();
                                response.sendRedirect("_index.jsp");
                            }

                            if (userid.equals("")) {
//                                response.sendRedirect("_index.jsp");
                            } else {
                                Criteria cm = ses.createCriteria(Databasefile.User.class);
                                cm.add(Restrictions.eq("idUser", Integer.valueOf(userid)));
                                Databasefile.User um = (Databasefile.User) cm.uniqueResult();

                                Criteria ulm = ses.createCriteria(Databasefile.Login.class);
                                ulm.add(Restrictions.eq("user", um));
                                Databasefile.Login lou = (Databasefile.Login) ulm.uniqueResult();

                        %>
                        <td style="width:1200px; height: 400px;">
                            <div style="width:1200px; height: 400px;overflow-y: auto;">
                                <h3>Messages</h3>
                                <center>
                                    <table class="table table-condensed" style="width:950px ;">
                                        <tr>
                                            <td style="width: 100px">Date</td>
                                            <td style="width: 700px">Massage</td>
                                            <td>Remove</td>
                                        </tr>
                                        <%                                        Criteria cu = ses.createCriteria(Databasefile.Msg.class);
                                            cu.add(Restrictions.eq("user", um));

                                            if (um != null) {

                                                List<Databasefile.Msg> msg = cu.list();
                                                for (Databasefile.Msg mv : msg) {
                                        %>
                                        <tr>
                                            <td style="width: 800px"><%= mv.getDate()%></td>
                                            <td style="width: 800px"><%= mv.getMsg()%></td>
                                            <td><button class="btn btn-danger" onclick="rmv(<%= mv.getIdMsg()%>)">Remove</button></td>
                                        </tr>
                                        <%}
                                                }
                                            }%>
                                    </table>
                                </center>
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

        var obj;

        function checkBrowser() {
            if (window.XMLHttpRequest) {
                obj = new XMLHttpRequest();
            } else {
                obj = new ActiveXobject("Microfoft.ActiveXobject");
            }
        }

        function Ii(al) {
            checkBrowser();


            obj.onreadystatechange = function () {
                if (obj.readyState === 4 && obj.status === 200) {

                    var a = JSON.parse(obj.responseText);
//                   
                    alert(a.data.pn + "  ,  " + a.data.pd + "  ,  " + a.data.pc1 + "  ,  " + a.data.pc2 + "  ,  " + a.data.pco);
                }
            };
            obj.open("POST", "checkinvoice", true);
            obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            obj.send('invoice=' + al);

        }

        function rate(al) {

            var form = document.createElement("form");
            input = document.createElement("input");

            form.action = "_RateForItem.jsp";
            form.method = "post"

            input.name = "iid";
            input.value = al;


            form.appendChild(input);

            document.body.appendChild(form);
            form.submit();

        }
        function rmv(v) {
            checkBrowser();
            obj.onreadystatechange = function () {
                if (obj.readyState === 4 && obj.status === 200) {
                    alert(obj.responseText);
                    location.reload();
                }
            };

            obj.open("POST", "removemsg", true);
            obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            obj.send('msg=' + v);
        }
    </script>
</html>
