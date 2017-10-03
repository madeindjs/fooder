$(document).on('click', '.editable', function(e){
  var element = $(this);
  var fields = element.attr('data-fields');
  var url = element.attr('data-url');

  var div = document.createElement('div');
  document.body.appendChild(div);
  var dialog = $(div);
  dialog.attr('title', "Editer l'élement")

  $.ajax({
    url: url,
    method: 'GET',
    data: {
      fields: fields
    },
    success : function(html, status){
      dialog.html(html);
      dialog.dialog();
    }
  });
});