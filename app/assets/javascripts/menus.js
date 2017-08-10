$("button.menu-show-details").on('click', function(e){
  var menuId = $(this).attr('data-id');
  $("#menu-details-" + menuId).slideToggle();
})