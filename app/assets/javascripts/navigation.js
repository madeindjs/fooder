$(document).scroll(function() {
  var y = $(this).scrollTop();
  if (y > 750) {
    $('#navigation').fadeIn();
  } else {
    $('#navigation').fadeOut();
  }
});