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
  if (hr > 18 || hr < 6) {
    $('body').addClass('evening');
    $('.home h1').html('Good evening, I\'m Steve and I build things on the internet for people. I\'m interested in just what the hell is going on, among other things. This, like me, is a work-in-progress.')
  }

});