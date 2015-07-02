//= require jquery
//= require jquery_ujs
//= require jquery.lazyload
//= require respond
//= require jquery.bigfoot
//= require turbolinks
//= require_self

$ ->

  $('html')
    .removeClass 'no-js'
    .addClass 'js'

Turbolinks.enableTransitionCache()
Turbolinks.enableProgressBar()

$(document).on 'page:load', ->

  $.bigfoot().addBreakpoint 'iPhone'

  $("._book img").lazyload
    effect: 'fadeIn'
