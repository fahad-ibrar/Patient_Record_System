var phoneCheck = false;

function phoneNo() {                               //checking contact# for not allowed characters

    var val1 = document.getElementById("phoneNumber").value;
    var len = val1.length;
    for (var i = 0; i <= len; i++) {
        if ((val1[i] < '0' || val1[i] > '9') && val1[i]!='+') {
            document.getElementById("phoneNumber").setAttribute("style", "border-color:red;");
            phoneCheck = false;
            return;
        }
    }
    document.getElementById("phoneNumber").setAttribute("style", "border-color:none;");
    phoneCheck = true;
}

function submitForm(){
    pass = true;
    if(phoneCheck === false){
        document.getElementById("phoneNumber").setAttribute("style", "border-color:red;");
        pass = false;
    }

return pass;
}
