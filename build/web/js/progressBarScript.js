$(document).ready(function() {

    var options = {
        beforeSend: function() {
            $("#progressBox").show();
            $("#pBar").html('0%');
            $("#pBar").css("width","0%");
            $("#message").empty();
        },
        uploadProgress: function(event, position, total, percentComplete) {
            
            $("#pBar").html(percentComplete+"%");
            $("#pBar").css("width",percentComplete+"%");
            
            if(percentComplete>50){
                $("#message").html("File Upload is in Progress!!!");
                $("#message").addClass("alert alert-warning");
            }
            
        },
        success: function() {
            $("#pBar").html("100%");
            $("#pBar").width("100%");
            $("#pBar").removeClass("active");
        },
        complete: function(response) {
            $("#message").html("Your File is Uploaded!!!");
            $("#message").removeClass("alert-warning");
            $("#message").addClass("alert-success");
        },
        error: function() {
            $("#message").html("ERROR : Unable to Upload File");
        }
    };

    $("#uploadForm").ajaxForm(options);



});