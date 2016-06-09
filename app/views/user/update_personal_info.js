$("#personalInfoModal").modal('hide');
// alert('done');
// alert(document.getElementById('user_firstName').value);
document.getElementById('firstName').innerHTML = document.getElementById('user_firstName').value;
document.getElementById('lastName').innerHTML = document.getElementById('user_lastName').value;
document.getElementById('gender').innerHTML = document.getElementById('user_gender').value;
document.getElementById('city').innerHTML = document.getElementById('user_city').value;
document.getElementById('dob').innerHTML = document.getElementById('user_dob').value;