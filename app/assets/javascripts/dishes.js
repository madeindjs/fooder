// dish has been updated / created
$(document).on('ajax:success', 'form.new_dish, form.edit_dish, form.delete_dish', function(e, data, status, xhr){
  $('#dishes-list').html(xhr.responseText);
  $('.dialog').dialog('close');
});

$(document).on('ajax:error', 'form.new_dish, form.edit_dish, form.delete_dish', function(e, xhr, status, error){
  var form = $(this);
  form.parent().html(xhr.responseText);
});

$(document).on('click', '#new-category-button', function(e){
    e.preventDefault();
    $('input[name="category[name]"]').toggle();
    $('select[name="dish[category_id]"]').toggle();
});


