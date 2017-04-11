$('.opening-hour-advanced').change(function(item){
  var cell = $(this).parent().parent();
  cell.children().toggle();
});