function defer(method) {
    if (window.jQuery)
        method();
    else
        setTimeout(function() { defer(method) }, 50);
};

$("#accordion").accordion({heightStyle: "content"});


$('#toggle-client-view').click(function(){
    console.log("button clicked");

  // hide all admin panels
  $(".admin").each(function(index, el){
    $(el).fadeOut();
  });

  //
  $("#main-container").addClass('col-md-offset-2 col-sm-offset-1');
});