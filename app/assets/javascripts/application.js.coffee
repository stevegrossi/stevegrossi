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

$(document).on 'ready page:load', ->

  $.bigfoot().addBreakpoint 'iPhone'

  $(".MediaElement-media,.ThumbList-thumb").lazyload
    effect: 'fadeIn'
