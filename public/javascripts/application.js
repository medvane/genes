$(document).ready(function() {
  $("a[title]").tooltip({ effect: 'fade'});
  $("span.help[title]").tooltip({ effect: 'fade'});
  $("#review_title").keyup(function() {
    var value = $(this).val();
    $("#review_search_term").val(value)
  })
});