class PostSweeper < ActionController::Caching::Sweeper
  observe Post

  def sweep(post)
    expire_action(posts_url)
    expire_action(post_url(post))
    expire_paginated_posts
    expire_tag_pages(post)
  end

  alias_method :after_update, :sweep
  alias_method :after_create, :sweep
  alias_method :after_destroy, :sweep

  private

  def expire_paginated_posts
    published_post_page_count = (Post.published.count / 25.0).ceil
    1.upto(published_post_page_count) do |i|
      expire_action(paged_posts_url(page: i))
    end
  end

  def expire_tag_pages(post)
    post.tags.each do |tag|
      expire_action(tagged_posts_url(slug: tag.slug))
    end
  end
end
