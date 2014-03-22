//= require jquery
//= require jquery_ujs
//= require jquery.lazyload
//= require respond
//= require jquery.bigfoot
//= require_self

$(function() {
  $('html').removeClass('no-js').addClass('js');

  var bigfoot = $.bigfoot();
  bigfoot.addBreakpoint('iPhone');
});
