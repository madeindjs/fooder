$('.ajax-new, .ajax-edit').click(function(e){
  e.preventDefault();

  var button = $(this);
  var container = button.parent().parent();

  $.ajax({
       url : $(this).attr('href'),
       type : 'GET',
       dataType : 'html',
       success : function(result, status){
        container.html(result);
       },
       error : function(result, statut, error){
        console.log(result);
       },
       complete : function(result, status){
       }
    });
});