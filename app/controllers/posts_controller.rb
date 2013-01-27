class PostsController < ApplicationController

  def index
    @posts = Post.published
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

end
