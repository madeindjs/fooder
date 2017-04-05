var select = $("select#themes");

if(select.length){
  
  $.getJSON("https://bootswatch.com/api/3.json", function (data) {
    var themes = data.themes;
    select.show();
    
    themes.forEach(function(value, index){
      select.append($("<option />")
            .val(value.cssCdn)
            .text(value.name));
    });
    
    select.change(function(){
      var value = $(this).val();
      if( value != ""){
        $("link").attr("href", value);
        $(".admin").each(function(index, el){
          $(el).fadeToggle();
        });
      }
    });

  }, "json").fail(function(){
    // do something here
  });
}

