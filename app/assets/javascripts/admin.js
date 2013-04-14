//= require jquery.tagsinput
//= require jquery.facebox
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
  $('#post_topic_list').tagsInput({
    'onAddTag': tagAdded,
    'onRemoveTag': tagRemoved
  });
  $('p .tag').on('click', function() {
    var tag = $(this).html();
    $('#post_topic_list').addTag(tag);
  });

});
