function defer(method) {
    if (window.jQuery)
        method();
    else
        setTimeout(function() { defer(method) }, 50);
};

defer( function(){
  if($("#accordion").length){
    $("#accordion").accordion({heightStyle: "content"});
  }
});
