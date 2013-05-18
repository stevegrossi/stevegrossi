module TagsHelper
  def linked_tags_for(post)
      post.tags.map{|t| link_to_tag(t)}.to_sentence
  end

  def link_to_tag(tag)
    link_to(tag.name, tagged_posts_path(tag))
  end
end
