<%-- 
    Document   : hedder
    Created on : Nov 10, 2015, 11:13:40 AM
    Author     : Lochana
--%>

<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.List"%>
<%@page import="Databasefile.HibernateConnection"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Ek+Mukta">

        <link href="css/mysty.css" rel="stylesheet" type="text/css">
        <link href="bootstrap/css/bootstrap-theme.css" rel="stylesheet" type="text/css">
        <link href="bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css">
        <link href="imageslider/js-image-slider.css" rel="stylesheet" type="text/css"/>
        <!--<link href="css/megamenu.css" rel="stylesheet" type="text/css"/>-->
        <script src="imageslider/js-image-slider.js" type="text/javascript"></script>


        <script type="text/javascript">var switchTo5x = true;</script>
        <script type="text/javascript" src="https://ws.sharethis.com/button/buttons.js"></script>
        <script type="text/javascript">stLight.options({publisher: "b9d810e4-f87f-490f-a777-d39fded7d153", doNotHash: false, doNotCopy: false, hashAddressBar: false});</script>



        <script type="text/javascript">
            function ccolour() {

                document.getElementById('m1').color = #00405d;
            }

            function low() {

                if (document.getElementById('uhid').innerHTML != null || document.getElementById('uhid').innerHTML != "") {
                    document.getElementById('wl').href = "_WishList.jsp";
                } else {
                    alert('Fist login and try this again');
                }

            }

        </script>

        <style type="text/css">


            .clearfix:after {
                display:block;
                clear:both;
            }

            /*----- Menu Outline -----*/
            .menu-wrap {
                width:100%;
                box-shadow:0px 1px 3px rgba(0,0,0,0.2);
                background:#3e3436;
            }

            .menu {
                width:1300px;
                margin:0px auto;
                top: 20px;
            }

            .menu li {
                margin:0px;
                list-style:none;
                font-family:'Ek Mukta';
            }

            .menu a {
                transition:all linear 0.15s;
                color:#919191;
            }

            .menu li:hover > a, .menu .current-item > a {
                text-decoration:none;
                color:#be5b70;
            }

            .menu .arrow {
                font-size:11px;
                line-height:0%;
            }

            /*----- Top Level -----*/
            .menu > ul > li {
                float:left;
                display:inline-block;
                position:relative;
                font-size:19px;
            }

            .menu > ul > li > a {
                padding:10px 40px;
                display:inline-block;
                text-shadow:0px 1px 0px rgba(0,0,0,0.4);
            }

            .menu > ul > li:hover > a, .menu > ul > .current-item > a {
                background:#2e2728;
            }

            /*----- Bottom Level -----*/
            .menu li:hover .sub-menu {
                z-index:1;
                opacity:1;
            }

            .sub-menu {
                width:160%;
                padding:5px 0px;
                position:absolute;
                top:100%;
                left:0px;
                z-index:-1;
                opacity:0;
                transition:opacity linear 0.15s;
                box-shadow:0px 2px 3px rgba(0,0,0,0.2);
                background:#2e2728;
            }

            .sub-menu li {
                display:block;
                font-size:16px;
            }

            .sub-menu li a {
                padding:10px 30px;
                display:block;
            }

            .sub-menu li a:hover, .sub-menu .current-item a {
                background:#3e3436;
            }
        </style>

    </head>
    <body>

        <%
            String uid = "";
            String uname = "";
            String utype = "";
            String log = "Login/Register";
            String action = "_userregistation_login.jsp";
            Session ses = new HibernateConnection().getSessionFactory().openSession();

        %>


        <div Class="s_hedder">
            <%                try {

                    Cookie[] cook = request.getCookies();

                    HttpSession ss = request.getSession();

                    if (cook != null) {
                        boolean bool = false;
                        for (int i = 0; i < cook.length; i++) {

                            if (cook[i].getName().compareTo("loginUserId") == 0) {
                                System.out.println("*1");
                                uid = cook[i].getValue();
                                bool = true;
                            }
                            System.out.println(i);
                            System.out.println(cook.length);

                            if (i + 1 == cook.length) {
                                System.out.println("*rrrrrrrrrrrrrrrrrrrrrrrrr");
                                if (bool != true) {
                                    uid = ss.getAttribute("loginUserId").toString();
                                }
                            }
                        }

                        if (uid.equals("") || uid.equals(null)) {
                            log = "Login";
                            action = "_userregistation_login.jsp";
                        } else {
                            log = "Logout";
                            action = "clearsession";
                        }

                    } else {

                        uid = ss.getAttribute("loginUserId").toString();

                        if (uid.equals("") || uid.equals(null)) {
                            log = "Login";
                            action = "_userregistation_login.jsp";
                        } else {
                            log = "Logout";
                            action = "clearsession";
                        }

                        action = "clearsession";
                    }

                    Criteria cr = ses.createCriteria(Databasefile.User.class);
                    cr.add(Restrictions.eq("idUser", Integer.valueOf(uid)));
                    Databasefile.User u = (Databasefile.User) cr.uniqueResult();

                    uname = "Hi.." + u.getFistName();
                    utype = u.getUserType();

                } catch (Exception e) {
                }

            %>
            <h5 style="position: absolute;left: 25px;left: 20px;color: #ffffff"><%= uname%></h5>



            <a href="<%= action%>" Class="s_hedder_text"><%= log%>  |</a>
            <a href="_WishList.jsp" id="wl" Class="s_hedder_text">Wish List  |</a>
        </div>
        <div class="logodiv">
            <div class="logo">
                <img src="img/logo.png" >


            </div>
            <div class="logoother">
                <div style="position: relative;float: right">


                    <center>

                        <span class='st_sharethis'  displayText='ShareThis'></span>
                        <span class='st_facebook' displayText='Facebook'></span>
                        <span class='st_twitter' displayText='Tweet'></span>
                        <span class='st_linkedin' displayText='LinkedIn'></span>
                        <span class='st_pinterest' displayText='Pinterest'></span>
                        <span class='st_email' displayText='Email'></span>

                    </center>

                    <a href="_myAccount.jsp" ><img src="img/account_100_50.png" width="100" height="50" style="float: right;"></a>
                    <a href="_Cart.jsp" ><img src="img/cart_100_50.png" width="100" height="50" style="float: right;"></a>
                </div>
                <div style="position:absolute;top: 55px;left: 220px;">
                    <form action="_mainsearch" class="searchform" method="post">
                        <input type="text" class="searchtext" name="st" placeholder="Search ......"/>
                        <input type="submit" value="Search" class="searhbtn"/>
                    </form>
                </div>
            </div>
        </div>

        <div class="itemnamelist">
            <div class="menu-wrap">
                <nav class="menu">
                    <ul class="clearfix">
                        
                        <li><a href="_index.jsp" style="font-size: 18px">Home</a></li>
                        <li>
                            <a href="#">Products<span class="arrow">&#9660;</span></a>

                            <ul class="sub-menu">
                                <li><a href="_Trouser.jsp" style="font-size: 18px">Trouser</a></li>                               
                                <li><a href="_Denims.jsp" style="font-size: 18px">Denim</a></li>                               
                                <li><a href="_T-Shirt.jsp" style="font-size: 18px">T-Shirt</a></li>                                  
                                <li><a href="_Shirt.jsp" style="font-size: 18px">Shirt</a></li>                                  
                                <li><a href="_Short.jsp" style="font-size: 18px">Short</a></li>                                  
                                <li><a href="_Underware.jsp" style="font-size: 18px">Underwear</a></li>                                  
                                <li><a href="_Belt.jsp" style="font-size: 18px">Belt</a></li>                                 
                                <li><a href="_Shose.jsp" style="font-size: 18px">Shoes</a></li>                                  
                                <li><a href="_Tie.jsp" style="font-size: 18px">Tie</a></li>                                  
                                <li><a href="_Watch.jsp" style="font-size: 18px">Watch</a></li> 
                            </ul>
                        </li>
                        <li><a href="_AddRegister.jsp" style="font-size: 18px">Advertisement</a></li>
                        <li><a href="_Cart.jsp" style="font-size: 18px">My Cart</a></li>
                        <li><a href="_mypurchase.jsp" style="font-size: 18px">My Purchases</a></li>
                        <li><a href="_mymsg.jsp" style="font-size: 18px">Messages</a></li>
                        <li><a href="_Faq.jsp" style="font-size: 18px">FAQ s</a></li>
                        <li><a href="_About.jsp" style="font-size: 18px">About</a></li>
                    </ul>
                </nav>
            </div>
        </div>


        <!--style="background: url(img/Backimage1.jpg) repeat top left;"-->    

        <div class="imageslider" style="background: url(img/Backimage1.jpg) repeat top left; top: 50px;" id="sliderFrame"> 
            <label id="uhid" style="display: none"><%= uid%></label>
            <div class="ImageSlider_left">
                <a onclick="imageSlider.previous()" class="group1-Prev" style="left:60px ; top:140px"></a>
            </div>
            <div class="ImageSlider_center" id="slider" style="background-color: #005580;">
                <%

                    org.hibernate.Criteria cr = ses.createCriteria(Databasefile.Sliderimage.class);
                    List<Databasefile.Sliderimage> sli = cr.list();
                    for (Databasefile.Sliderimage s : sli) {
                %>
                <img src="<%= s.getImage()%>"/>
                <%}%>
            </div>
            <div class="ImageSlider_right">
                <a id='auto' onclick="switchAutoAdvance()"></a>
                <a onclick="imageSlider.next()" class="group1-Next" style="left:60px ; top:140px"></a>
            </div>

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
