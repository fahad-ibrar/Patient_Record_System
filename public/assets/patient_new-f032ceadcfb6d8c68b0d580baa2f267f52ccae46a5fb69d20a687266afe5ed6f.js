var status =false;
 $(function ()
 {
    $(".pagination").on("click","a", function()
    {
        status = true;
        alert("success");
        $.getScript(this.href);
        return false;
    });
 });
