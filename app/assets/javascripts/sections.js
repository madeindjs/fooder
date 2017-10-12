// section has been updated / created
$(document).on('ajax:success', 'form.new_section, form.edit_section, form.delete_section', function(e, data, status, xhr){
  $('#sections-list').html(xhr.responseText);
  $('.dialog').dialog('close');
});

$(document).on("ajax:remotipartComplete", 'form.new_section, form.edit_section, form.delete_section', function(e, xhr){
  $('#sections-list').html(xhr.responseText);
  $('.dialog').dialog('close');
});


/**
 * `ajax:error` is called after `ajax:remotipartComplete` due to [remotipart](https://github.com/JangoSteve/remotipart) gem
 */
// $(document).on('ajax:error', 'form.new_section, form.edit_section, form.delete_section', function(e, xhr, status, error){
//   var form = $(this);
//   form.parent().html(xhr.responseText);
// });
