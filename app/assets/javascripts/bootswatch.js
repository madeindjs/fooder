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
      $("link").attr("href", $(this).val());
    });

  }, "json").fail(function(){
    // do something here
  });
}

