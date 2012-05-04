//= require jquery
//= require jquery_ujs
//= require_self
//= require_tree .

$(function() {

  $('html').removeClass('no-js').addClass('js');

  $('.success').delay(1000).fadeOut(500);

  one = 'me';
  two = 'stevegrossi';
  three = 'com';
  four = 'mail';
  $('#contact').html('<a accesskey="9" href="'+four+'to:'+one+'@'+two+'.'+three+'">' + one+'@'+two+'.'+three+'</a>');

  // Hook for evening styles
  var hr = (new Date()).getHours();
  if (hr > 17 || hr < 6) {
    $('body').addClass('evening');
    var greeting = $('.home h1');
    greeting.text( greeting.text().replace("Hey", "Good evening") );
  }

});