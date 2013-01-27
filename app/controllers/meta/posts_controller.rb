class Meta::PostsController < Meta::DashboardController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])
    if params[:commit] == 'Publish'
      @post.published_at ||= Time.now
    end
    if @post.save
      redirect_to @post, notice: view_context.notify(:new, :post)
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.attributes = params[:post]
    if params[:commit] == 'Publish'
      @post.published_at ||= Time.now
    elsif params[:commit] == 'Unpublish'
      @post.published_at = nil
    end
    if @post.save
      redirect_to @post, notice: view_context.notify(:updated, :post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    title = @post.title
    @post.destroy
    redirect_to meta_posts_path, notice: "You deleted <b>#{title}</b>."
  end

end
