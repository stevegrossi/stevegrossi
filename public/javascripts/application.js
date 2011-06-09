$(function() {

  $('html').removeClass('no-js').addClass('js');
  
  $('.success').delay(1000).fadeOut(500);

  one = 'me';
	two = 'stevegrossi';
	three = 'com';
	four = 'mail';
	$('#contact').html('<a href="'+four+'to:'+one+'@'+two+'.'+three+'">' + one+'@'+two+'.'+three+'</a>');
	
});