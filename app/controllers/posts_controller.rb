class PostsController < ApplicationController

  caches_action :index, :show, :tag, if: proc{ !current_user }

  def index
    posts = Post.published.includes(:book, :tags).all
    @posts = Kaminari.paginate_array(posts).page(params[:page])
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

  def tags
    @tags = Post.tag_counts # TODO: only count published
  end

  def tag
    @tag = Tag.find_by_slug!(params[:slug])
    @posts = Post.tagged_with(@tag).published.includes(:book, :tags)
  end

end
