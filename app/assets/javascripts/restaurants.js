$(document).on('ajax:success', '#edit-restaurant-link', function(e, data, status, xhr){
  console.log("hello");
  // create dialog
  var div = document.createElement('div');
  var dialog = $(div);
  dialog.attr('class', 'dialog');
  dialog.attr('title', "Editer votre restaurant");
  dialog.html(xhr.responseText);
  dialog.dialog();
});

// // dish has been updated / created
// $(document).on('ajax:success', 'form.new_dish, form.edit_dish, form.delete_dish', function(e, data, status, xhr){
//   $('#dishes-list').html(xhr.responseText);
//   $('.dialog').dialog('close');
// });

// $(document).on('ajax:error', 'form.new_dish, form.edit_dish, form.delete_dish', function(e, xhr, status, error){
//   var form = $(this);
//   form.parent().html(xhr.responseText);
// });

// $(document).on('click', '#edit-restaurant-link', function(e){
//     e.preventDefault();
//     var input = $('input[name="category[name]"]');
//     var select = $('select[name="dish[category_id]"]');
//     input.val(select.find('option:selected').text())
//     input.toggle();
//     select.toggle();
// });

