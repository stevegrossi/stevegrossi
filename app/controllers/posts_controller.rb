class PostsController < ApplicationController

  def index
    @posts = Post.published.includes(:book, :topics).page params[:page]
  end

  def show
    @post = Post.find(params[:id])
    if @post.draft?
      if current_user || params[:draft] == 'yep'
        flash.now.alert = 'This is a draft.'
      else
        redirect_to posts_path, flash: { error: 'You must be logged in to view that draft.' }
      end
    end
  end

  def topics
    @topics = Post.topic_counts
  end

  def topic
    @topic = ActsAsTaggableOn::Tag.find(params[:topic])
    @posts = Post.published.includes(:book, :topics).tagged_with(@topic)
  end

end
