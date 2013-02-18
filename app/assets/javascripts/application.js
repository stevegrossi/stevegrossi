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

});
