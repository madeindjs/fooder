// section has been updated / created
$(document).on('ajax:success', 'form.new_section, form.edit_section, form.delete_section', function(e, data, status, xhr){
  $('#sections-list').html(xhr.responseText);
  $('.dialog').dialog('close');
});

$(document).on('ajax:error', 'form.new_section, form.edit_section, form.delete_section', function(e, xhr, status, error){
  var form = $(this);
  form.parent().html(xhr.responseText);
});
