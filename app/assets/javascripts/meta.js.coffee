//= require jquery
//= require jquery_ujs
//= require jquery.facebox
//= require jquery.chosen
//= require turbolinks
//= require_self

$ ->

  $('html')
    .removeClass 'no-js'
    .addClass 'js'

Turbolinks.enableTransitionCache()
Turbolinks.enableProgressBar()

$(document).on 'ready page:load', ->

  # Chosen
  $('#book_author_ids,#post_book_id,#post_tag_ids').chosen()

