function defer(method) {
    if (window.jQuery)
        method();
    else
        setTimeout(function() { defer(method) }, 50);
};


var admin_accordion = $("#accordion")

if(admin_accordion.length){
  admin_accordion.accordion({heightStyle: "content"});
  $('#admin-panel').fadeIn();
}


$('#toggle-client-view').click(function(){
    console.log("button clicked");

  // hide all admin panels
  $(".admin").each(function(index, el){
    $(el).fadeToggle();
  });

  //
  var mainContainer = $("#main-container");
  var offsetClasses = 'col-md-offset-2 col-sm-offset-1';
  if(mainContainer.hasClass(offsetClasses)){
    $(this).text('Afficher la vue client');
    $("#main-container").removeClass(offsetClasses);
  }else{
    $(this).text("Afficher l'administration");
    $("#main-container").addClass(offsetClasses);
  }
});