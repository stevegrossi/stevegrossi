//= require jquery.tagsinput
//= require_self

// TODO: make :contains match exactly
function tagAdded(tag) {
  $('.topics p span:contains('+tag+')').hide();
}
function tagRemoved(tag) {
  $('.topics p span:contains('+tag+')').show();
}

$(function() {
  // TagsInput plugin
  $('#book_topic_list').tagsInput({
    'onAddTag': tagAdded,
    'onRemoveTag': tagRemoved
  });
  $('p .tag').on('click', function() {
    var tag = $(this).html();
    $('#book_topic_list').addTag(tag);
  });
  
  $("label[for='book_new_author']").hide();
  $('#book_new_author').hide();
  $("label[for='book_author_ids']").before('<a id="new_author_link" href="#">Add New</a>');
  $('#new_author_link').on('click', function() {
    $(this).hide();
    $("label[for='book_new_author']").show();
    $('#book_new_author').show();
    return false;
  });
});