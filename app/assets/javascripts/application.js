//= require jquery
//= require jquery_ujs
//= require footnotes
//= require respond
//= require_self

$(function() {

  $('html').removeClass('no-js').addClass('js');

  one = 'me';
  two = 'stevegrossi';
  three = 'com';
  four = 'mail';
  $('#contact').html('<a accesskey="9" href="'+four+'to:'+one+'@'+two+'.'+three+'">' + one+'@'+two+'.'+three+'</a>');

  // Hook for evening styles
  var hr = (new Date()).getHours();
  if (hr > 17 || hr < 6) {
    var greeting = $('.home h1');
    greeting.text( greeting.text().replace("Hey", "Good evening") );
  }

});