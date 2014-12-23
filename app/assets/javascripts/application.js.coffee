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

  $.bigfoot().addBreakpoint 'iPhone'

Turbolinks.enableTransitionCache()
Turbolinks.enableProgressBar()

$(document).on 'ready page:load', ->

  $("._book img").lazyload
    effect: 'fadeIn'
