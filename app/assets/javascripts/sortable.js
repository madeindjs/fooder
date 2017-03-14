$(".sortable").sortable({
  handle: '.handle',
  placeholder: "ui-state-highlight col-xs-12",
  update: function(event, ui){
    console.log(ui.position);
    console.log(ui.item.attr('id') + "is now #" + ui.position);
  }
});
$(".sortable").disableSelection();