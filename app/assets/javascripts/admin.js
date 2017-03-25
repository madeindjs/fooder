function defer(method) {
    if (window.jQuery)
        method();
    else
        setTimeout(function() { defer(method) }, 50);
};

$("#accordion").accordion({heightStyle: "content"});


$('#toggle-client-view').click(function(){
    console.log("button clicked");

  $(".admin").each(function(index, el){
    console.log(el);
    $(el).fadeOut();
  });
});