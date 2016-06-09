var passLen = false;
var passCheck = false;
var phoneCheck = true;
var emailCheck = false;

function passLength() {

    var val1 = document.getElementById("user_password").value;
    var len1 = val1.length;

    if (len1>0 && (len1 < 6 || len1 > 20)) {
        document.getElementById("user_password").setAttribute("style", "border-color:red;");
        passLen = false;
    }
    else{

        document.getElementById("user_password").setAttribute("style", "border-color:none;");
        passLen = true;
    }

    return;
}

function passConfirm(){


    if (document.getElementById("user_password").length!=0 && document.getElementById("user_password_confirmation").length!=0 && document.getElementById("user_password").value != document.getElementById("user_password_confirmation").value) {

        document.getElementById("user_password_confirmation").setAttribute("style", "border-color:red;");
        passCheck = false;
    }
    else{
        document.getElementById("user_password_confirmation").setAttribute("style", "border-color:none;");
        passCheck = true;
    }

}

function phoneNo() {                               //checking contact# for not allowed characters

    var val1 = document.getElementById("user_phone").value;
    var len = val1.length;
    for (var i = 0; i <= len; i++) {
        if (val1[i] < '0' || val1[i] > '9') {
            document.getElementById("user_phone").setAttribute("style", "border-color:red;");
            phoneCheck = false;
            return;
        }
    }
    document.getElementById("user_phone").setAttribute("style", "border-color:none;");
    phoneCheck = true;
}

function mail() {                                    //checking email for "@" and ".com"
    var val1 = document.getElementById("user_email").value;
    var len = val1.length;
    var find = val1.search(".com");
    var time = 0;
    for (var i = 0; i < len; i++) {
        if (val1[i] == '@') {
            time++;
        }
    }
    if (time != 1 || find == -1 || len - find != 4) {
        document.getElementById("mailerror").textContent = "email is not correct";
        emailCheck = false;
    }
    else{

        document.getElementById("mailerror").textContent = "";
        emailCheck = true;
    }

        }

function submitForm(){

   // return false;
    var pass = true;
    if(passLen===false){
        document.getElementById("user_password").setAttribute("style", "border-color:red;");
        pass = false;

    }

    if(passCheck===false){
        document.getElementById("user_password_confirmation").setAttribute("style", "border-color:red;");
        pass = false;
       // alert("passCheck");
    }

    if(phoneCheck === false){
        document.getElementById("user_phone").setAttribute("style", "border-color:red;");
        pass = false;

    }

return pass;


}
// function DOB(){

//     alert(document.getElementById("dob").value);
// }
