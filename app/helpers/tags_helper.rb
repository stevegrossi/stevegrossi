module TagsHelper
  def linked_topics_for(post)
      post.topics.map{|t| link_to_topic(t)}.to_sentence
  end

  def link_to_topic(topic)
    link_to(topic.name, tagged_posts_path(topic))
  end
end
