$(document).on('click', '.editable', function(e){
  var element = $(this);
  var fields = element.attr('data-fields');
  var url = element.attr('data-url');

  var div = document.createElement('div');
  document.body.appendChild(div);
  var dialog = $(div);
  dialog.attr('class', 'dialog');
  dialog.attr('title', "Editer l'élément")

  $.ajax({
    url: url,
    method: 'GET',
    data: {
      fields: fields
    },
    success : function(html, status){
      dialog.html(html);
      var component = dialog.dialog();
      component.dialog("option", "width", 500);
    },
    error : function(xhr, status, errorThrown ){
      dialog.html('<div class="alert alert-danger" role="alert">' + errorThrown + '</div>');
      dialog.dialog();
    }
  });
});