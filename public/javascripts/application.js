$(document).ready(function() {
  $("a[title]").tooltip({ effect: 'fade', delay: 0 });
  $("span.help[title]").tooltip({ effect: 'fade'});
  $("#review_title").keyup(function() {
    var value = $(this).val();
    $("#review_search_term").val(value)
  });
  $("#toggle_genes_by_species").click(function () {
    $("#genes_by_species").toggle("slow");
  });
  $("#toggle_genes_by_chromosome").click(function () {
    $("#genes_by_chromosome").toggle("slow");
  });
});