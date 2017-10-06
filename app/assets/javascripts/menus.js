// dish has been updated / created
$(document).on('ajax:success', 'form.new_menu, form.edit_menu', function(e, data, status, xhr){
  $('#menus-list').html(xhr.responseText);
  $('.ui-dialog').remove();
});

$(document).on('ajax:error', 'form.new_menu, form.edit_menu', function(e, xhr, status, error){
  var form = $(this);
  form.parent().html(xhr.responseText);
});