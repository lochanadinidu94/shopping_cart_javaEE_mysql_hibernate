/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function form_emptychecker() {

    if (document.regform.fname.value == "" ||
            document.regform.lname.value == "" ||
            document.regform.nic.value == "" ||
            document.regform.homeaddress.value == "" ||
            document.regform.street.value == "" ||
            document.regform.ciyt.value == "" ||
            document.regform.mobile.value == "" ||
            document.regform.email.value == "" ||
            document.regform.password1.value == "" ||
            document.regform.password2.value == "") {

        document.getElementById('sid').disabled = true
        alert('Enter all information and submit later')

        //return '#';
        //   document.regform.actrion = '#'
    } else {
        //return 'UserRegistation';
        //   document.regform.actrion = 'UserRegistation'
        document.getElementById('sid').disabled = false
    }

//onsubmit="form_emptychecker(),checkboxchecker()"
}
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

function checkboxchecker() {

    var a = document.getElementById('check1')
//    var b = document.getElementById('check2')

    if (a.checked == true ) {
        document.getElementById('sid').disabled = false
    } else {
        document.getElementById('sid').disabled = true
        //alert('Please agree all condition and others !')
    }

}

function alertopen(){
    alert('Please agree all condition and others and Enter all information')
}