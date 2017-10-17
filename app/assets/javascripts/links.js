// link has been updated / created
$(document).on('ajax:success', 'form.new_link, form.edit_link, form.delete_link', function(e, data, status, xhr){
  $('#links-list').html(xhr.responseText);
  $('.dialog').dialog('close');
});

$(document).on('ajax:error', 'form.new_link, form.edit_link, form.delete_link', function(e, xhr, status, error){
  var form = $(this);
  form.parent().html(xhr.responseText);
});
