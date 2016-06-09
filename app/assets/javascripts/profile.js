$(document).ready(function () {
 $("#editAbo").on('submit',function(event) {
    event.preventDefault();

   $.ajax({
            type: "POST",
            url: "/user/updateAbout",
            data: $('#editAbout').serialize(),
            dataType: "json",
            success: function (d) {
                alert('success');
                console.log(d);
                $("#about_box").text(d['success'])
            }

        });

   });

   //  $("#editStatusPic").on('submit',function(event) {
   //  event.preventDefault();

   // $.ajax({
   //          type: "POST",
   //          url: "/user/updateStatusPhoto",
   //          data: $('#editStatusPic').serialize(),
   //          dataType: "json",
   //          success: function (d) {
   //              alert('success');
   //              console.log(d);
   //              // $("#about_box").text(d['success'])
   //          }

   //      });
   // $("#statusPicModal").modal('hide');
   // });

});