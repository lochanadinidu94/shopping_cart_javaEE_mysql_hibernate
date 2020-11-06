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
        <title>My Account</title>
        <link href="css/mysty.css" rel="stylesheet" type="text/css">
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css.css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>


        <script type="text/javascript">

            function bl(a, b, c) {
                document.getElementById(a).style.display = "block";
                document.getElementById(b).style.display = "none";
                document.getElementById(c).style.display = "none";

            }
            function bk(a) {

                document.getElementById(a).style.display = "none";
                document.getElementById('ma1').style.display = "block";
            }

            function pi(a) {

            }

        </script>
    </head>
    <body style="background: url(img/Backimage1.jpg) repeat top left;">
        <div Class="maintable_w" style="margin-left: 10px;">
            <%@include file="hedder_withoutimageslider.jsp" %>
            <center>
                <div  style="width:1000px ; height: 400px;overflow-y: auto;">
                    <table style="width:1000px ;height: 400px;overflow-y: auto;">


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
                                response.sendRedirect("_index.jsp");
                            }

//                            Session sm = new HibernateConnection().getSessionFactory().openSession();
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


                        <tr>
                            <td>
                                <h3>My Profile</h3>
                                <table class="table table-hover" style="width:950px ;">
                                    <tr>
                                        <td>Fist Name</td>
                                        <td><%= um.getFistName()%></td>
                                        <td>Address 1</td>
                                        <td><input type="text" class="form-control" id="add1" value="<%= um.getAddress1()%>"></td>

                                    </tr>
                                    <tr>
                                        <td>Last Name</td>
                                        <td><%= um.getLastName()%></td>
                                        <td>Address 2</td>
                                        <td><input type="text" class="form-control" id="add2" value="<%= um.getAddress2()%>"></td>
                                    </tr>
                                    <tr>
                                        <td>NIC</td>
                                        <td><%= um.getNic()%></td>
                                        <td>City</td>
                                        <td><input type="text" class="form-control" id="cty" value="<%= um.getCity()%>"></td>
                                    </tr>
                                    <tr>
                                        <td>Password</td>
                                        <td>
                                            <input type="password" class="form-control" id="pass" onkeyup="checkpassword(this.value);" value="" placeholder="Enter new password">
                                            <p class="label-danger" id="passcheck"></p>
                                        </td>
                                        <td>Email</td>
                                        <td>
                                            <input type="text" class="form-control" id="email" onkeyup="checkemail(this.value);" value="<%= um.getEmail()%>">
                                            <p class="label-danger" id="emcheck"></p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Re Password</td>
                                        <td>
                                            <input type="password" class="form-control" id="repass" onkeyup="checkconpass(pass.value, this.value)" value="" placeholder="Enter new password">
                                            <p class="label-danger" id="conpasscheck"></p>
                                        </td>
                                        <td>Mobile</td>
                                        <td>
                                            <input type="text" class="form-control" id="mob" onkeyup="checkmobileno(this.value)" value="<%= um.getMobileNo()%>" number>
                                            <p class="label-danger" id="mobcheck"></p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td><button class="btn btn-info" id="sid" onclick="update(<%= um.getIdUser()%>);">Update</button></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>


                        <tr>
                            <td>
                                <h3>Purchases</h3>
                                <table class="table table-hover" style="width:950px ;">
                                    <tr>
                                        <td>Date</td>
                                        <td>Shipping</td>
                                        <td>Donate</td>
                                        <td>Amount</td>
                                        <td>Product Information</td>
                                        <td>Rate for Item</td>
                                    </tr>
                                    <%
                                        Criteria ci = ses.createCriteria(Databasefile.Invoice.class);
                                        ci.add(Restrictions.eq("user", um));
                                        List<Databasefile.Invoice> il = ci.list();
                                        for (Databasefile.Invoice ino : il) {
                                    %>
                                    <tr>
                                        <td><%= ino.getDate()%></td>
                                        <td><%= ino.getShAmount()%></td>
                                        <td><%= ino.getDonateamount().getAmount()%></td>
                                        <td><%= ino.getAmount()%></td>
                                        <td><button onclick="Ii(<%= ino.getIdInvoice()%>);" class="btn btn-info">Product Information</button></td>
                                        <td><button onclick="rate(<%= ino.getIdInvoice()%>);" class="btn btn-info">Rate</button></td>
                                    </tr> 
                                    <%
                                        }
                                    %>
                                </table>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <h3>Messages</h3>
                                <table class="table table-condensed" style="width:950px ;">
                                    <tr>
                                        <td style="width: 100px">Date</td>
                                        <td style="width: 700px">Massage</td>
                                        <td>Remove</td>
                                    </tr>
                                    <%
                                        Criteria cu = ses.createCriteria(Databasefile.Msg.class);
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
                            </td>
                        </tr>



                    </table>
                </div>
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
        function checkmobileno(no) {
            var error = "";
            var no = no
            no = no.replace(/[\(\)\.\-\ ]/g, '')

            if (no == "") {
                error = "You didn't enter a phone number.";
                document.getElementById('sid').disabled = true
            } else if (isNaN(parseInt(no))) {
                error = "The phone number contains illegal characters.";
                document.getElementById('sid').disabled = true
            } else if (!(no.length == 10)) {
                error = "The phone number is the wrong length. Make sure you included an area code.\n";
                document.getElementById('sid').disabled = true
            } else {
                error = "Valied Mobile No"
                document.getElementById('sid').disabled = false
            }
            document.getElementById('mobcheck').innerHTML = error

        }
        function checkemail(email) {
            var error = ""
            var email = email
            if (email == "") {
                error = "You didn't enter a email address."
            }
            else if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email))
            {
                error = "Valied Email Address"
                document.getElementById('sid').disabled = false
            } else {
                error = "You have entered an invalid email address!"
                document.getElementById('sid').disabled = true
            }
            document.getElementById('emcheck').innerHTML = error
        }
        function checkpassword(password) {
            var pass = password
            var error = ""
            var x = pass.length;
            re1 = /^\w+$/
            re2 = /[0-6]/
            re3 = /[a-z]/

            document.getElementById('repass').value = "";
            if (pass == "") {
                error = "You didn't enter a Password"
                document.getElementById('sid').disabled = true
            } else if (x <= 6) {
                error = "Password least one number (0-6)"
                document.getElementById('sid').disabled = true
            } else {
                error = "Valied Password"
                document.getElementById('sid').disabled = false
            }
            document.getElementById('passcheck').innerHTML = error
        }
        function checkconpass(pass, conf) {
            var pass = pass
            var conf = conf
            var error = ""

            if (pass == conf) {
                error = "Valied Password"
                document.getElementById('sid').disabled = false
            } else if (conf == "" || conf == null) {
                error = "You didn't enter a Confrim Password"
                document.getElementById('sid').disabled = true
            } else if (pass != conf) {
                error = "Confim Password is not match"
                document.getElementById('sid').disabled = true
            }
            document.getElementById('conpasscheck').innerHTML = error
        }

        var obj;

        function checkBrowser() {
            if (window.XMLHttpRequest) {
                obj = new XMLHttpRequest();
            } else {
                obj = new ActiveXobject("Microfoft.ActiveXobject");
            }
        }

        function update(a) {
            checkBrowser();

            var uid = a;
            var add1 = document.getElementById('add1').value;
            var add2 = document.getElementById('add2').value;
            var cty = document.getElementById('cty').value;
            var pass = document.getElementById('pass').value;
            var email = document.getElementById('email').value;
            var mob = document.getElementById('mob').value;
            var regex = /^[0-9]+$/;



            if (mob.match(regex)) {
                if (pass === document.getElementById('repass').value) {
                    if (add1 != "" && add2 != "" && cty != "" && pass != "" && email != "") {
                        obj.onreadystatechange = function () {
                            if (obj.readyState === 4 && obj.status === 200) {

                                alert(obj.responseText);
                                location.reload();

                            }
                        };
                        obj.open("POST", "updateUser", true);
                        obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                        obj.send('uid=' + uid + '&add1=' + add1 + '&add2=' + add2 + '&cty=' + cty + '&pass=' + pass + '&email=' + email + '&mob=' + mob);
                    } else {
                        alert('Please Enter correct all data fist');
                    }
                } else {
                    alert('Second Password is not matached');
                }
            } else {
                alert('Please Enter correct Mobile');
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
