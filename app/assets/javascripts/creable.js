$(document).on('click', '.creable', function(e){
  e.preventDefault();
  var element = $(this);
  var url = element.attr('href');

  var div = document.createElement('div');
  document.body.appendChild(div);
  var dialog = $(div);
  dialog.attr('class', 'dialog');
  dialog.attr('title', "Créer l'élément");

  $.ajax({
    url: url,
    method: 'GET',
    success : function(html, status){
      dialog.html(html);
      dialog.dialog();
    },
    error : function(xhr, status, errorThrown ){
      dialog.html('<div class="alert alert-danger" role="alert">' + errorThrown + '</div>');
      dialog.dialog();
    }
  });
});