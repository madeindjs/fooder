$('.editable').on('click', function(e){
	var element = $(this);
  var field = element.attr('data-field');
  var url = element.attr('data-url');

  var dialog = $("#dialog");
  dialog.html("<p>Alex</p>");

  $.ajax({
    url: url,
    method: 'GET',
    data: {
      field: field
    },
    success : function(html, status){
      dialog.html(html);
      dialog.dialog();
    }
  });
});