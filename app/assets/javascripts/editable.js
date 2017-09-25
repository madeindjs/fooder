$('.editable').on('click', function(e){
	var element = $(this);
  var fields = element.attr('data-fields');
  var url = element.attr('data-url');

  var dialog = $("#dialog");

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