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



function remove_fields(link) {
  $j(link).prev("input[type=hidden]").val("1");
  $j(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $j(link).parent().before(content.replace(regexp, new_id));
}

