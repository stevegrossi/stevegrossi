//= require jquery
//= require jquery_ujs
//= require jquery.lazyload
//= require respond
//= require jquery.bigfoot
//= require_self

$ ->

  $('html')
    .removeClass 'no-js'
    .addClass 'js'

  $.bigfoot().addBreakpoint 'iPhone'

