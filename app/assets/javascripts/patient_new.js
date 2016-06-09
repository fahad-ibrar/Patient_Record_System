
 $(function ()
 {  $("#patients").on("click","#paging .pagination a", function(){

        var url = this.href.toString()+"&firstName="+$("#patient_firstName").val()+"&lastName="+$("#patient_lastName").val()+"&age="+$("#patient_age").val()+"&gender="+$("#patient_gender").val()+"&sortBy="+$("#patient_sortBy").val();
        $.getScript(url);
        return false;

    });

 $("#patientHistory").on("click","#paging_history .pagination a", function(){

        var str = this.href;
        var n = str.indexOf("/profile");
        if(n==-1){

          var url = this.href;

        }
        else{
        var url = str.substring(0,n+1) +"history_load"+ str.substring(n+8,str.length);
}
        $.getScript(url);
        return false;

    });

 $("#doctorDiagnosis").on("click","#paging_diagnosis .pagination a", function(){

        var str = this.href;
        var n = str.indexOf("/profile");
        if(n==-1){

          var url = this.href;

        }
        else{
        var url = str.substring(0,n+1) +"diagnosis_load"+ str.substring(n+8,str.length);
}
        $.getScript(url);
        return false;

    });

$("#patientHistory").on("click",".patientHistoryEdit a",function(){


      var url = "/patient/editHistory/"+$(this).attr('data_patient_id')+"?history_id="+$(this).attr('data_history_id');
      $("#patient_history_detail").attr('value',$(this).attr('data_history_detail'));
      $("#editHistory_form").attr('action', url);
 });

$("#doctorDiagnosis").on("click",".doctorDiagnosisEdit a",function(){


      var url = "/patient/editDiagnosis/"+$(this).attr('data_patient_id')+"?diagnosis_id="+$(this).attr('data_diagnosis_id');
      $("#doctor_diagnosis_detail").attr('value',$(this).attr('data_diagnosis_detail'));
      $("#editDiagnosis_form").attr('action', url);
 });

// $("ul").on("click","li #patient_history_tab",function(){

//       var url = "/patient/history_load/"+$(this).attr("data_patient_id")+"#History";
//       $.getScript(url);
//       $("#patient_details_li").attr("class",'');
//       $("#patient_history_li").attr("class",'active');
// });
});
