// dish has been updated / created
$(document).on('ajax:success', 'form.new_menu, form.edit_menu, form.delete_menu', function(e, data, status, xhr){
  $('#menus-list').html(xhr.responseText);
  $('.dialog').dialog('close');
});

$(document).on('ajax:error', 'form.new_menu, form.edit_menu, form.delete_menu', function(e, xhr, status, error){
  var form = $(this);
  form.parent().html(xhr.responseText);
});
