
    $( document ).ready(function() {
      $("#backdrop_on").css("z-index","0");
       $('#openSidebarMenu').click(function() {
          if (!$(this).is(':checked')) {
              $("#backdrop_on").removeClass("show");
              $("#backdrop_on").css("z-index","0");
          }else{
             $("#backdrop_on").addClass("show");
             $("#backdrop_on").css("z-index","3");

          }
        });  

    });

    