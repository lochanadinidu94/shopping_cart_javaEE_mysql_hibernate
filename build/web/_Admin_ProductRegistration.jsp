<%-- 
    Document   : Admin_DashBord
    Created on : Oct 29, 2015, 4:44:45 PM
    Author     : Lochana
--%>

<%@page import="Databasefile.Distype"%>
<%@page import="Databasefile.Sizetype"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="Databasefile.HibernateConnection"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Registration</title>


        <link media="all" rel="stylesheet" type="text/css" href="css/all.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
        <link media="all" rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css.css" />

        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
        <script type="text/javascript">window.jQuery || document.write('<script type="text/javascript" src="js/jquery-1.7.2.min.js"><\/script>');</script>
        <script type="text/javascript" src="js/jquery.main.js"></script>

        <link href="css/popup_styles_admin.css" rel="stylesheet" type="text/css" />

        <script src="colourchoser/jquery-1.9.1.min.js"></script>
        <script src="colourchoser/tinycolor-0.9.15.min.js"></script>
        <script src="colourchoser/pick-a-color-1.2.3.min.js"></script>


        <style type="text/css">
            body{
                background: url(img/Backimage1.jpg) repeat top left;
            }
        </style>
        
        <style type="text/css">

            .pick-a-color-markup {
                margin:20px 0px;
            }

            .container {
                margin: 0px 5px;
                width: 50%;
            }

        </style>

        <script type="text/javascript">

            var obj;
            var currentQty = 0;
            var c_q1 = 0;
            var c_q2 = 0;
            var c_q3 = 0;
            var c_q4 = 0;
            var c_q5 = 0;



            function clearbtn() {
                document.getElementById('pname').value = "";
                document.getElementById('des').value = "";
                document.getElementById('dis').value = "";
                document.getElementById('der').value = "";
                document.getElementById('qty').value = "";
                document.getElementById('price').value = "";
            }
            function ic(a) {
                if (currentQty === null) {
                    alert('Fist Enter QTY');
                } else if (currentQty == 0) {
                    alert('Fist Enter QTY');
                } else {
                    bl(a);
                }
            }
            function bl(a) {

                document.getElementById(a).style.display = "block";
                document.getElementById('wrapper').style.display = "none";
                
                document.body.style.backgroundImage = "url('img/background.panel_.blue_.jpg')";   
                document.body.style.backgroundSize = "1366px 768px";
            }
            function bk(a) {

                document.getElementById(a).style.display = "none";
                document.getElementById('wrapper').style.display = "block";
                
                document.body.style.backgroundImage = "none"; 
            }


            function checkBrowser() {
                if (window.XMLHttpRequest) {
                    obj = new XMLHttpRequest();
                } else {
                    obj = new ActiveXobject("Microfoft.ActiveXobject");
                }
            }


            function lord_Category() {

                checkBrowser();
                //alert('AA')
                document.getElementById('sbid').disabled = true;
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {
                        //alert('AA in');
                        var a = JSON.parse(obj.responseText);
                        var b = a.Cata;
                        document.getElementById('Cat1').innerHTML = "<option>~Choose~</option>";
                        document.getElementById('SubCategory_cata').innerHTML = "<option>~Choose~</option>";
                        document.getElementById('brand_cata1').innerHTML = "<option>~Choose~</option>";
                        document.getElementById('brand_cata').innerHTML = "<option>~Choose~</option>";
                        for (i = 0; i < b.length; i++) {
                            var c = b[i].data;
                            document.getElementById('Cat1').innerHTML += "<option>" + c + "</option>";
                            document.getElementById('SubCategory_cata').innerHTML += "<option>" + c + "</option>";
                            document.getElementById('brand_cata1').innerHTML += "<option>" + c + "</option>";
                            document.getElementById('brand_cata').innerHTML += "<option>" + c + "</option>";
                        }
                        lord_Color();
                    }
                };
                obj.open("POST", "lordcatagory", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send();
            }

            function lord_SubCategory() {

                checkBrowser();
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {

                        alert(obj.responseText);
                        var a = JSON.parse(obj.responseText);
                        var b = a.Cata;
                        document.getElementById('Cat1').innerHTML = "<option>~Choose~</option>";
                        for (i = 0; i < b.length; i++) {
                            var c = b[i].data;
                            document.getElementById('Cat1').innerHTML += "<option>" + c + "</option>";
                        }

                    }
                };
                obj.open("POST", "lordsubcatagory", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send();
            }
            function lord_Color() {
                checkBrowser();
                //alert('BB')
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {
                        //alert('BB in');
                        var a = JSON.parse(obj.responseText);
                        var b = a.data;
                        document.getElementById('color1').innerHTML = "<option>~Choose~</option>";
                        document.getElementById('color2').innerHTML = "<option>~Choose~</option>";
                        document.getElementById('color3').innerHTML = "<option>~Choose~</option>";
                        document.getElementById('color4').innerHTML = "<option>~Choose~</option>";
                        document.getElementById('color5').innerHTML = "<option>~Choose~</option>";
                        for (i = 0; i < b.length; i++) {
                            var c = b[i].colourlist;
                            document.getElementById('color1').innerHTML += "<option>" + c + "</option>";
                            document.getElementById('color2').innerHTML += "<option>" + c + "</option>";
                            document.getElementById('color3').innerHTML += "<option>" + c + "</option>";
                            document.getElementById('color4').innerHTML += "<option>" + c + "</option>";
                            document.getElementById('color5').innerHTML += "<option>" + c + "</option>";
                        }
                    }
                };
                obj.open("POST", "lordcolor", true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send();
            }

            function runlord() {

                lord_Category();
            }

            function lordSubCata(cal, id) {
                checkBrowser();
                obj.onreadystatechange = function () {

                    if (obj.readyState === 4 && obj.status === 200) {
                        var scat = JSON.parse(obj.responseText);
                        var sdat = scat.data;
                        for (i = 0; i < sdat.length; i++) {
                            var d = sdat[i].subcat;
                            document.getElementById(id).innerHTML += "<option>" + d + "</option>";
                        }
                    }

                };
                document.getElementById(id).innerHTML = "<option>~Choose~</option>";
                obj.open('POST', 'lordsubcatagory', true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("cat=" + cal);
            }

            function lordBrand(cal, scal, id) {
                checkBrowser();
                obj.onreadystatechange = function () {


                    if (obj.readyState === 4 && obj.status === 200) {



                        var scat = JSON.parse(obj.responseText);
                        var sdat = scat.data;
                        document.getElementById(id).innerHTML = "<option>~Choose~</option>";
                        for (i = 0; i < sdat.length; i++) {
                            var d = sdat[i].br;
                            document.getElementById(id).innerHTML += "<option>" + d + "</option>";
                        }

                    }

                };
                obj.open('POST', 'lordbrand', true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("cat=" + cal + "&scat=" + scal);
            }
            function lordmodel(cal, scal, brand, id) {
                checkBrowser();
                obj.onreadystatechange = function () {


                    if (obj.readyState === 4 && obj.status === 200) {


                        var scat = JSON.parse(obj.responseText);
                        var sdat = scat.data;
                        document.getElementById(id).innerHTML = "<option>~Choose~</option>";
                        for (i = 0; i < sdat.length; i++) {
                            var d = sdat[i].model;
                            document.getElementById(id).innerHTML += "<option>" + d + "</option>";
                        }

                    }

                };
                obj.open('POST', 'lordmodel', true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("cat=" + cal + "&scat=" + scal + "&br=" + brand);
            }

            function saveSubcate(cat, value) {

                checkBrowser();
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {
                        alert(obj.responseText);
                        lordSubCata(Cat1.value, 'Cat2');
                        bk('popUpDiv');
                    }
                };
                obj.open('POST', 'savesubcata', true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("cat=" + cat + "&value=" + value);
            }

            function saveBrand(cat, scat, value) {
                checkBrowser();
                obj.onreadystatechange = function () {
                    if (obj.readyState === 4 && obj.status === 200) {
                        alert(obj.responseText);
                        lordBrand(Cat1.value, Cat2.value, 'Br1')
                        bk('popUpDiv2');
                    }
                };
                obj.open('POST', 'savebrand', true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("cat=" + cat + "&scat=" + scat + "&value=" + value);
            }

            function saveModel(cat, scat, brd, value) {
                checkBrowser();
                obj.onreadystatechange = function () {

                    if (obj.readyState === 4 && obj.status === 200) {
                        alert(obj.responseText);
                        lordmodel(Cat1.value, Cat2.value, Br1.value, 'Model1');
                        bk('popUpDiv3');
                    }

                };
                obj.open('POST', 'savemodel', true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("cat=" + cat + "&scat=" + scat + "&brd=" + brd + "&value=" + value);
            }

            function lordsize(st, id) {


                checkBrowser();
                obj.onreadystatechange = function () {

                    if (obj.readyState === 4 && obj.status === 200) {
                        var rt = JSON.parse(obj.responseText);
                        var rt1 = rt.data;
                        document.getElementById(id).innerHTML = "";
                        document.getElementById(id).innerHTML += "<option>~Chooser~</option>";
                        for (i = 0; i < rt1.length; i++) {
                            var a = rt1[i].size;
                            document.getElementById(id).innerHTML += "<option>" + a + "</option>";
                        }
                    }
                    ;
                };
                obj.open('POST', 'lordsize', true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("st=" + st);
            }

            function saveSize(st, value) {

                checkBrowser();
                obj.onreadystatechange = function () {

                    if (obj.readyState === 4 && obj.status === 200) {
                        alert(obj.responseText);
                        lordsize(SizeType.value, 'Size');
                        bk('popUpDiv4');
                    }
                    ;
                };
                obj.open('POST', 'savesize', true);
                obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                obj.send("st=" + st + "&value=" + value);
            }

            function setQty(qty) {
                currentQty = qty;
                document.getElementById('qv').innerHTML = currentQty;
            }

            function c_q1M(q) {
                c_q1 = currentQty - q;
                document.getElementById('q2').value = c_q1;
                Checknumbers(q, 'itemforcolor');
            }
            function c_q2M(q) {
                c_q2 = c_q1 - q;
                document.getElementById('q3').value = c_q2;
                Checknumbers(q, 'itemforcolor');
            }
            function c_q3M(q) {
                c_q3 = c_q2 - q;
                document.getElementById('q4').value = c_q3;
                Checknumbers(q, 'itemforcolor');
            }
            function c_q4M(q) {
                c_q4 = c_q3 - q;
                document.getElementById('q5').value = c_q4;
                Checknumbers(q, 'itemforcolor');
            }
            function savecolorqty() {
                var q = Number(document.getElementById('q1').value) + Number(document.getElementById('q2').value) + Number(document.getElementById('q3').value) + Number(document.getElementById('q4').value) + Number(document.getElementById('q5').value);
                if (Number(document.getElementById('q1').value) < 0 |
                        Number(document.getElementById('q2').value) < 0 |
                        Number(document.getElementById('q3').value) < 0 |
                        Number(document.getElementById('q4').value) < 0 |
                        Number(document.getElementById('q5').value) < 0) {
                    alert('Fist Enter Correct qty');
                }
                else if (currentQty == q) {
                    bk('popUpDiv5');
                }
            }
            function Checknumbers(no, msgid) {
                var error = "";
                var no = no
                no = no.replace(/[\(\)\.\-\ ]/g, '')

                if (no == "") {
                    error = "You didn't enter Nomber";
                    document.getElementById('sbid').disabled = true;
                } else if (isNaN(parseInt(no))) {
                    error = "The number contains illegal characters.";
                    document.getElementById('sbid').disabled = true;
                } else {
                    error = "Valied No"
                    document.getElementById('sbid').disabled = false;
                }
                document.getElementById(msgid).innerHTML = error;
                //document.getElementById('imagesub')
            }
            function saveDataall() {

                checkBrowser();
                var proName, cate, subCate, Bra, Mode, Size, SizeType, Discri, QtyFist, c_q1t, c_q2t, c_q3t, c_q4t, c_q5t, Price, DisType, Dis, color1, color2, color3, color4, color5;
                proName = document.getElementById('pname').value;
                cate = document.getElementById('Cat1').value;
                subCate = document.getElementById('Cat2').value;
                Bra = document.getElementById('Br1').value;
                Mode = document.getElementById('Model1').value;
                Size = document.getElementById('Size').value;
                SizeType = document.getElementById('SizeType').value;
                Discri = document.getElementById('dis1').value;
                QtyFist = currentQty;
                c_q1t = document.getElementById('q1').value;
                c_q2t = document.getElementById('q2').value;
                c_q3t = document.getElementById('q3').value;
                c_q4t = document.getElementById('q4').value;
                c_q5t = document.getElementById('q5').value;
                Price = document.getElementById('pri').value;
                DisType = document.getElementById('dt').value;
                Dis = document.getElementById('dis').value;
                color1 = document.getElementById('color1').value;
                color2 = document.getElementById('color2').value;
                color3 = document.getElementById('color3').value;
                color4 = document.getElementById('color4').value;
                color5 = document.getElementById('color5').value;

                if (proName == "" | cate == "~Choose~" |
                        cate == "" | subCate == "~Choose~" |
                        subCate == "~" | Bra == "~Choose~" |
                        Bra == "" | cate == "~Choose~" |
                        Mode == "~Choose~" | Mode == "" |
                        Size == "" | SizeType == "~Choose~" | Discri == "" |
                        QtyFist == "00.00" | QtyFist == "" |
                        c_q1t == "" | c_q2t == "" |
                        c_q3t == "" | c_q4t == "" |
                        c_q5t == "" | Price == "00.00" |
                        Dis == "" | DisType == "~Choose~" | color1 == "~Choose~") {

                    alert('Please Enter All Feilds & Correct information');

                } else {


                    var qre = Number(document.getElementById('q1').value) + Number(document.getElementById('q2').value) + Number(document.getElementById('q3').value) + Number(document.getElementById('q4').value) + Number(document.getElementById('q5').value);
                    if (currentQty == qre) {
                        if (document.getElementById('im1').value == "") {
                            alert("Please Choose Image File");
                        } else {

                            obj.onreadystatechange = function () {
//                                alert(obj.status);
                                if (obj.readyState === 4 && obj.status === 200) {
                                    //alert('Dinidu');
//                                    document.getElementById('sbid').disabled = false;
                                    var rr = JSON.parse(obj.responseText);
                                    var r1 = rr.data;
                                    for (i = 0; i < r1.length; i++) {
                                        var r2 = r1[0].pid;
                                        document.getElementById('pid').value = r2;
                                        //alert(r2);
                                        document.getElementById('imagesub').click();

                                    }
                                }

                            };
//                            document.getElementById('sbid').disabled = true;
                            obj.open('POST', 'saveproduct', true);
                            obj.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                            obj.send("proName=" + proName + "&cate=" + cate + "&subCate=" + subCate + "&Bra=" + Bra + "&Mode=" + Mode + "&Size=" + Size + "&SizeType=" + SizeType + "&Discri=" + Discri + "&QtyFist=" + QtyFist + "&c_q1t=" + c_q1t + "&c_q2t=" + c_q2t + "&c_q3t=" + c_q3t + "&c_q4t=" + c_q4t + "&c_q5t=" + c_q5t + "&Price=" + Price + "&DisType=" + DisType + "&Dis=" + Dis + "&color1=" + color1 + "&color2=" + color2 + "&color3=" + color3 + "&color4=" + color4 + "&color5=" + color5);

                        }
                    } else {
                        alert("Did't Match color qty Please check it again");
                    }
                }
            }
        </script>

    </head>
    <body onload="runlord();">


        <div id="popUpDiv" style="display:none;" >
            <center>
                <table border="0" width="350px" height = "250px">
                    <tr><td><h3><center>Sub Category</center></h3></td></tr>
                    <tr>
                        <td width="150px">Category</td>
                        <td width="200px">

                            <select class="form-control" id="SubCategory_cata">
                            </select>

                        </td>
                    </tr>
                    <tr>
                        <td width="150px">New Sub Category</td>
                        <td width="200px"><input type="text" name="sc" width="120px" class="form-control" id="text_scat"></td>
                    </tr>

                    <tr><td></td><td><input type="submit" value="Submit" class="btn btn-default" onclick="saveSubcate(SubCategory_cata.value, text_scat.value)"><button class="btn btn-danger" style="position: relative;left: 20px" onclick="bk('popUpDiv')">Close</button></td></tr>

                </table>
            </center>
        </div>




        <div id="popUpDiv2" style="display:none;" >
            <center>
                <table border="0" width="350px" height = "250px">
                    <tr><td><h3><center>Add Brand</center></h3></td></tr>
                    <tr>
                        <td width="150px">Category</td>
                        <td width="200px">

                            <select class="form-control" id="brand_cata1" onchange="lordSubCata(this.value, 'brand_subcata1')">
                            </select>

                        </td>
                    </tr>
                    <tr>
                        <td width="150px">Sub Category</td>
                        <td width="200px">

                            <select class="form-control" id="brand_subcata1">
                            </select>

                        </td>
                    </tr>
                    <tr>
                        <td width="150px">Brand</td>
                        <td width="200px"><input type="text" name="brand" width="120px" class="form-control" id="text_brand"></td>
                    </tr>

                    <tr><td></td><td><input type="submit" value="Submit" class="btn btn-default" onclick="saveBrand(brand_cata1.value, brand_subcata1.value, text_brand.value)"><button class="btn btn-danger" style="position: relative;left: 20px" onclick="bk('popUpDiv2')">Close</button></td></tr>

                </table>
            </center>
        </div>



        <div id="popUpDiv3" style="display:none;" >
            <center>
                <table border="0" width="350px" height = "250px">
                    <tr><td><h3><center>Model</center></h3></td></tr>
                    <tr>
                        <td width="150px">Category</td>
                        <td width="200px">

                            <select class="form-control" id="brand_cata" onchange="lordSubCata(this.value, 'brand_scata')">
                            </select>

                        </td>
                    </tr>
                    <tr>
                        <td width="150px">Sub Category</td>
                        <td width="200px">

                            <select class="form-control" id="brand_scata" onchange="lordBrand(brand_cata.value, this.value, 'brand_br')">
                            </select>

                        </td>
                    </tr>
                    <tr>
                        <td width="150px">Brand</td>
                        <td width="200px">

                            <select class="form-control" id="brand_br" >
                            </select>

                        </td>
                    </tr>
                    <tr>
                        <td width="150px">Model</td>
                        <td width="200px"><input type="text" name="model" width="120px" class="form-control" id="text_model"></td>
                    </tr>

                    <tr><td></td><td><input type="submit" value="Submit" class="btn btn-default" onclick="saveModel(brand_cata.value, brand_scata.value, brand_br.value, text_model.value)"><button class="btn btn-danger" style="position: relative;left: 20px" onclick="bk('popUpDiv3')">Close</button></td></tr>

                </table>
            </center>
        </div>



        <div id="popUpDiv4" style="display:none;" >
            <center>
                <table border="0" width="350px" height = "250px">
                    <tr><td><h3><center>Size </center></h3></td></tr>
                    <tr>
                        <td width="150px">Size Type</td>
                        <td width="200px">

                            <select class="form-control" id="size_type_pop">
                                <option>~Choose~</option>
                                <%
                                    try {
                                        Session ses = new HibernateConnection().getSessionFactory().openSession();
                                        Criteria c0 = ses.createCriteria(Databasefile.Sizetype.class);
                                        List<Databasefile.Sizetype> li0 = c0.list();
                                        for (Sizetype st : li0) {
                                %>
                                <option><%= st.getName()%></option>
                                <%}
                                %>
                            </select>

                        </td>
                    </tr>
                    <tr>
                        <td width="150px">New Size </td>
                        <td width="200px"><input type="text" name="size" width="120px" class="form-control" id="new_size"></td>
                    </tr>

                    <tr><td></td><td><input type="submit" value="Submit" class="btn btn-default" onclick="saveSize(size_type_pop.value, new_size.value)"><button class="btn btn-danger" style="position: relative;left: 20px" onclick="bk('popUpDiv4')">Close</button></td></tr>

                </table>
            </center>
        </div>
        <div id="popUpDiv5" style="display:none;" >

            <center>



                <table border="0" width="350px" height = "250px">
                    <tr><td><h3><center>Item for Color </center></h3></td><td><h4><p id="qv" style="position: relative; float: right; color: red;"></p></h4></td></tr>

                    <tr>
                        <td width="200px"><select id="color1" class="form-control" style="width: 200px"></select></td>
                        <td width="150px"><input type="text" name="qty1" placeholder="QTY" class="form-control" style="width: 150px ;text-align: right;" id="q1" onkeyup ="c_q1M(this.value)"></td>
                    </tr>
                    <tr>
                        <td width="200px"><select id="color2" class="form-control" style="width: 200px"></select></td>
                        <td width="150px"><input type="text" name="qty2" placeholder="QTY" class="form-control" style="width: 150px ;text-align: right;" id="q2" onkeyup="c_q2M(this.value)"></td>
                    </tr>
                    <tr>
                        <td width="200px"><select id="color3" class="form-control" style="width: 200px"></select></td>
                        <td width="150px"><input type="text" name="qty3" placeholder="QTY" class="form-control" style="width: 150px ;text-align: right;" id="q3" onkeyup="c_q3M(this.value)"></td>
                    </tr>
                    <tr>
                        <td width="200px"><select id="color4" class="form-control" style="width: 200px"></select></td>
                        <td width="150px"><input type="text" name="qty4" placeholder="QTY" class="form-control" style="width: 150px ;text-align: right;" id="q4" onkeyup="c_q4M(this.value)"></td>
                    </tr>
                    <tr>
                        <td width="200px"><select id="color5" class="form-control" style="width: 200px"></select></td>
                        <td width="150px"><input type="text" name="qty5" placeholder="QTY" class="form-control" style="width: 150px ;text-align: right;" id="q5"></td>
                    </tr>


                    <tr><td></td><td><input type="submit" value="Submit" class="btn btn-default" onclick="savecolorqty()" ><button class="btn btn-danger" style="position: relative;left: 20px" onclick="bk('popUpDiv5')">Close</button></td></tr>

                    <tr><td><p id="itemforcolor"></p></td></tr>
                </table>

            </center>
        </div>

        <div id="popUpDiv6" style="display:none;" >
            <center>
                <form method="post" enctype="multipart/form-data" action="Uplord" name="imgup">
                    <table border="0" width="550px" height = "430px">
                        <tr><td><h3><center>Images</center></h3></td></tr>
                        <tr>
                            <td width="275px"><input type="file" class="btn btn-info" name="Img1" id="im1"/></td>
                            <td width="275px"><input type="file" class="btn btn-info" name="Img2" id="im2"/></td>
                        </tr>
                        <tr>
                            <td width="275px"><input type="file" class="btn btn-info" name="Img3" id="im3"/></td>
                            <td width="275px"><input type="file" class="btn btn-info" name="Img4" id="im4"/></td>
                        </tr>

                        <tr><td><input type="text" id="pid" style="display: none;" name="p_i" /></td><td><input type="submit" value="Uplord" class="btn btn-default" style="position: relative;left: 110px;display: none;" id="imagesub"></td></tr>
                        <!--style="display: none;"-->
                    </table>
                </form>
                <button class="btn btn-danger" style="position: absolute;top: 410px;left: 500px" onclick="bk('popUpDiv6')">Close</button>
            </center>
        </div>


        <div id="wrapper">

            <%@include file="adminhedder.jsp" %>



            <div style="position: absolute;left: 100px;top: 180px;width: 1250px;height: 470px">
                <center>


                    <table border="0" width="650px" height="450px">

                        <tr>
                            <td width="150px"><h4>Product Name</h4></td>
                            <td width="350px"><input type="text" name="pname" class="form-control" id="pname"></td>
                            <td width="150px"></td>
                        </tr>
                        <tr>
                            <td width="150px"><h4>Category</h4></td>
                            <td width="350px">

                                <select class="form-control" id="Cat1" onchange= "lordSubCata(this.value, 'Cat2')">
                                </select>

                            </td>
                            <td width="150px"></td>
                        </tr>
                        <tr>
                            <td width="150px"><h4>Sub Category</h4></td>
                            <td width="350px">

                                <select class="form-control" id="Cat2" onchange="lordBrand(Cat1.value, this.value, 'Br1')">
                                </select>

                            </td>
                            <td width="150px"><h5><a href="#" onclick="bl('popUpDiv')">Add Sub Category</a></h5></td>
                        </tr>
                        <tr>
                            <td width="150px"><h4>Brand</h4></td>
                            <td width="350px">

                                <select class="form-control" id="Br1" onchange="lordmodel(Cat1.value, Cat2.value, this.value, 'Model1')">
                                </select>

                            </td>
                            <td width="150px"><h5><a href="#" onclick="bl('popUpDiv2')">Add Brand</a></h5></td>
                        </tr>
                        <tr>
                            <td width="150px"><h4>Model</h4></td>
                            <td width="350px">

                                <select class="form-control" id="Model1">
                                </select>

                            </td>
                            <td width="150px"><h5><a href="#" onclick="bl('popUpDiv3')">Add Model</a></h5></td>
                        </tr>
                        <tr>
                            <td width="150px"><h4>Size</h4></td>
                            <td width="350px">

                                <table>
                                    <tr>
                                        <td>
                                            <select class="form-control" style="width: 200px" id="Size">
                                            </select> 
                                        </td>
                                        <td>
                                            <select class="form-control" style="width: 150px" id="SizeType" onchange="lordsize(this.value, 'Size')">
                                                <option>~Choose~</option>
                                                <%                                                    Criteria c1 = ses.createCriteria(Databasefile.Sizetype.class);
                                                    List<Databasefile.Sizetype> li = c1.list();
                                                    for (Sizetype st : li) {
                                                %>
                                                <option><%= st.getName()%></option>
                                                <%}%>
                                            </select>
                                        </td>
                                    </tr>
                                </table>

                            </td>
                            <td width="150px"><h5><a href="#" onclick="bl('popUpDiv4')">Add Size </a></h5></td>
                        </tr>
                        <tr>
                            <td width="150px"><h4>Description</h4></td>
                            <td width="350px"><input type="text" name="des" class="form-control" id="dis1"></td>
                            <td width="150px"></td>
                        </tr>
                        <tr>
                            <td width="150px"><h4>Color & QTY</h4></td>
                            <td width="350px"><input type="text" name="qty" id="qr0" class="form-control" style="text-align: right" placeholder="0" onchange="setQty(this.value);" onkeyup="Checknumbers(this.value, 'mainmsg');"></td>
                            <td width="150px"><h5><a href="#" onclick="ic('popUpDiv5')">Item for Color</a></h5></td>
                        </tr>
                        <tr>
                            <td width="150px"><h4>Price</h4></td>
                            <td width="350px"><input type="text" name="price" id="pri" class="form-control" style="text-align: right" placeholder="00.00" onkeyup="Checknumbers(this.value, 'mainmsg');"></td>
                            <td width="150px"></td>
                        </tr>
                        <tr>
                            <td width="150px"><h4>Discount</h4></td>
                            <td width="350px"><input type="text" name="dis" id="dis" class="form-control" style="text-align: right" placeholder="00.00" onkeyup="Checknumbers(this.value, 'mainmsg');"></td>
                            <td width="150px">

                                <select class="form-control" name="DistType" id="dt">
                                    <option>~Choose~</option>
                                    <%
                                        Criteria c2 = ses.createCriteria(Databasefile.Distype.class);
                                        List<Databasefile.Distype> li2 = c2.list();
                                        for (Distype st : li2) {
                                    %>
                                    <option><%= st.getType()%></option>
                                    <%
                                            }

                                        } catch (Exception e) {
                                            response.sendRedirect("_Admin_DashBord.jsp");
                                        }
                                    %>
                                </select>

                            </td>
                        </tr>
                        <!--                        <tr>
                                                    <td width="150px"><h4>Delivery (1Km)</h4></td>
                                                    <td width="350px"><input type="text" name="der" class="form-control" style="text-align: right" placeholder="00.00"></td>
                                                    <td width="150px"></td>
                                                </tr>-->
                        <tr>
                            <td width="150px"><button class="btn btn-default" onclick="bl('popUpDiv6')">Upload Image</button></td>
                            <td width="350px"><input type="submit" value="Submit" class="btn btn-default" id="sbid" onclick="saveDataall();"></td>
                            <td width="150px"><button class="btn btn-danger" onclick="clearbtn()">Clear</button></td>
                        </tr>

                        <tr><td><p id="mainmsg"></p></td></tr>
                    </table>
                </center>


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
