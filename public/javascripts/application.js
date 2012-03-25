// Place your application-specific JavaScript functions and classes here
// This file is automatically included by 
// $(function (){  
//     $("#agenda_meeting_date").datepicker();  
// }); 
// var $j = jQuery.noConflict();
$(document).ready(function() {
    $('#meeting_meeting_date_part').datepicker();
    $('#meeting_meeting_time_part').timepicker();
  });
$('a.delete').click (function(){
    if(confirm("Are you sure?")){
        return false;
    } else {
      // they clicked no
      return false;
    }
});


