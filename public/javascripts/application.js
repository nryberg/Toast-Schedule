// Place your application-specific JavaScript functions and classes here
// This file is automatically included by 
// $(function (){  
//     $("#agenda_meeting_date").datepicker();  
// }); 
var $j = jQuery.noConflict();
$j(document).ready(function() {
    $j('#meeting_meeting_date').datepicker();
  });
$j('a.delete').click (function(){
    if(confirm("Are you sure?")){
        return false;
    } else {
      // they clicked no
      return false;
    }
});
