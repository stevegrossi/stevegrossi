class Meta::WritingsController < Meta::DashboardController

  def index
    @writings = Writing.all
  end

  def new
    @writing = Writing.new
  end

  def edit
    @writing = Writing.find(params[:id])
  end

  def create
    @writing = Writing.new(params[:writing])
    if params[:commit] == 'Publish'
      @writing.published_at ||= Time.now
    end
    if @writing.save
      redirect_to @writing, notice: view_context.notify(:new, :writing)
    else
      render :new
    end
  end

  def update
    @writing = Writing.find(params[:id])
    @writing.attributes = params[:writing]
    if params[:commit] == 'Publish'
      @writing.published_at ||= Time.now
    elsif params[:commit] == 'Unpublish'
      @writing.published_at = nil
    end
    if @writing.save
      redirect_to @writing, notice: view_context.notify(:updated, :writing)
    else
      render :edit
    end
  end

  def destroy
    @writing = Writing.find(params[:id])
    title = @writing.title
    @writing.destroy
    redirect_to meta_writings_path, notice: "You deleted <b>#{title}</b>."
  end

end
