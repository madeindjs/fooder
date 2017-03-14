$(".sortable").sortable({
  handle: '.handle',
  placeholder: "ui-state-highlight col-xs-12",
  update: function(event, ui){
    console.log
  }
} );
$(".sortable").disableSelection();