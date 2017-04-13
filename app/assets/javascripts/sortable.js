$('.tooltip').tooltip();

if($(".sortable").length){
  var sortableList = $(".sortable");

  sortableList.sortable({
    handle: '.handle',
    placeholder: "ui-state-highlight col-xs-12",
    update: function(event, ui){
      // get all items existing
      sortableList.children("div.item").each(function (){
        // set index number in input value 
        $(this).children('input.order').first().val($(this).index());
      });
    }
  });
  $(".sortable").disableSelection();
}

