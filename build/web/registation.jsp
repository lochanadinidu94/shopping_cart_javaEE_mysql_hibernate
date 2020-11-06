<%-- 
    Document   : registation
    Created on : Nov 10, 2015, 11:27:22 AM
    Author     : Lochana
--%>

<%@page import="java.util.HashMap"%>
<%@page import="Databasefile.HibernateConnection"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <link href="css/mysty.css" rel="stylesheet" type="text/css">
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="bootstrap/css/bootstrap-theme.css" rel="stylesheet" type="text/css">
        <link href="bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css">
        <link href="imageslider/js-image-slider.css" rel="stylesheet" type="text/css"/>
        <!--<link href="css/megamenu.css" rel="stylesheet" type="text/css"/>-->
        <script src="imageslider/js-image-slider.js" type="text/javascript"></script>

        <script src="js/ur.js" type="text/javascript"></script>

        <style type="text/css">
            body{
                background: url(img/Backimage1.jpg) repeat top left;
            }
        </style>
        
    </head>
    <body>
        <%
            String msg = "";
        %>

        <div class="imageitem_w" >
              <!--<h2 style=" position: relative;left: -1100px; top: 5px; width: 400px;margin-top: -400px; " >aaa</h2>-->
            <table width = "1100px" style=" position: relative; left:110px;overflow-y: scroll;">
                <tr>
                    <td width="550px">

                <center>
                    <form  name="regform"  action="UserRegistation" role="form" method="post" >
                        <h2>Register for New Account</h2>

                        <input type="text" name="fname" class="form-control" placeholder="First Name" style="width: 400px"/><br>

                        <input type="text" name="lname" class="form-control" placeholder="Last Name" style="width: 400px"/><br>

                        <input type="text" name="nic" class="form-control" placeholder="NIC" style="width: 400px"/><br>

                        <select class="form-control" name="gender" style="width: 400px">
                            <option>Select</option>
                            <%
                                Session hs = new HibernateConnection().getSessionFactory().openSession();
                                Criteria cs = hs.createCriteria(Databasefile.Gender.class);
                                List<Databasefile.Gender> li = cs.list();
                                for (Databasefile.Gender g : li) {
                            %>
                            <option><%= g.getName()%></option>
                            <%}%>
                        </select><br>
                        <input type="text" name="homeaddress" class="form-control" placeholder="Home Address:" style="width: 400px"/><br>

                        <input type="text" name="street" class="form-control" placeholder="Street:" style="width: 400px"/><br>

                        <input type="text" name="city" class="form-control" placeholder="City" style="width: 400px"/><br>

                        <select class="form-control" name="district" style="width: 400px">
                            <option>Select</option>
                            <%
                                Criteria cr = hs.createCriteria(Databasefile.District.class);
                                List<Databasefile.District> lk = cr.list();
                                for (Databasefile.District di : lk) {
                            %>
                            <option><%= di.getName()%></option>
                            <%
                                }
                            %>
                        </select><br>

                        <input type="text" name="mobile" class="form-control" onkeyup="checkmobileno(this.value)" placeholder="Mobile No" style="width: 400px"/><br>
                        <p id="mobcheck" style="color: #F00 ; font-size: 12px ;position: relative; left: 25px;"></p>

                        <input type="text" name="email" class="form-control" onkeyup="checkemail(this.value)" placeholder="Email" style="width: 400px"/><br>
                        <p id="emcheck" style="color: #F00 ; font-size: 12px ;position: relative; left: 25px;"></p>

                        <input type="password" name="password1" class="form-control" placeholder="Password" onkeyup="checkpassword(this.value)" style="width: 400px"/><br>
                        <p id="passcheck" style="color: #F00 ; font-size: 12px ;position: relative; left: 25px;"></p>

                        <input type="password" name="password2" class="form-control" placeholder="Re Password" onkeyup="checkconpass(password1.value, this.value)" style="width: 400px"/><br>
                        <p id="conpasscheck" style="color: #F00 ; font-size: 12px ;position: relative; left: 25px;"></p>


                        <div class="checkbox-inline">	
                            <input type="checkbox"  id="check1" name="check1"  />
                            <label class="registelabel_Agree">Agree with Terms and Conditions</label>
                        </div><br>


                        <div class="checkbox-inline">	
                            <input type="checkbox" id="check2" value="yes" name="check2" />
                            <label class="registelabel_Agree">I'm not a Roobat</label>
                        </div><br>


                        <input type="submit" value="Signup" class="btn btn-default" onmousemove="checkboxchecker()"  id="sid" style="width: 100px"/><br>
                        <p >Already have account?<a href="#" > Login </a> here </p>

                    </form>
                </center>

                </td>
                <td width="550px" >
                <center>
                    <div style="position: relative;top: -270px">
                        <h2>Existing User</h2>
                        <form action="login" role="form" method="post">
                            <input type="text" name="email" class="form-control" placeholder="Email" style="width: 400px"/><br>
                            <input type="password" name="password" class="form-control" placeholder="Password" style="width: 400px"/><br>

                            <div class="checkbox-inline">	
                                <input type="checkbox"  id="check2" name="check2"  />
                                <label>Remember Password </label>
                            </div><br>


                            <input type="submit" value="Login" class="btn btn-default"/>
                            <p >Forgot Your Password?<a href="_forgetPassword.jsp" > Click </a> here </p>

                        </form>
                    </div>
                </center>

                </td>
                </tr>
            </table>




        </div> 
        <div class="pageinnertion">
            <%
                try {
                    //HttpSession hss = (HttpSession) request.getSession().getAttribute("login_msg");
                    HashMap hm = (HashMap) request.getSession().getAttribute("login_msg");
                    msg = hm.get("login_msg").toString();

            %>

            <cente>
                <p style="font-size: 18px;color: #009F00; text-align: center ;  font-family:Constantia  "><%=msg%></p>
            </cente>
            <%

                    hm.clear();
                } catch (Exception e) {
                }
            %>
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
