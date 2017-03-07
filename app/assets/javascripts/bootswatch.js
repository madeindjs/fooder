
$.getJSON("https://bootswatch.com/api/3.json", function (data) {
  var themes = data.themes;
  var select = $("select");
  select.show();
  
  themes.forEach(function(value, index){
    console.log(value);
    select.append($("<option />")
          .val(value.cssCdn)
          .text(value.name));
  });
  
  select.change(function(){
    $("link").attr("href", $(this).val());
  }).change();

}, "json").fail(function(){
  // do something here
});