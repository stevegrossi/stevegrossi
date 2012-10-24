class Meta::WritingsController < Meta::DashboardController

  def index
    @title = 'All Writings'
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
      flash[:success] = 'Yay, you wrote another thing!'
      redirect_to @writing
    else
      render action: "new"
    end
  end

  def update
    @writing = Writing.find(params[:id])
    # Set '' to nil so ||= works 2 below
    params[:writing][:published_at] = nil if params[:writing][:published_at].blank?
    if params[:commit] == 'Publish'
      params[:writing][:published_at] ||= Time.now
    elsif params[:commit] == 'Unpublish'
      params[:writing][:published_at] = nil
    end
    if @writing.update_attributes(params[:writing])
      flash[:success] = 'Writing updated.'
      redirect_to @writing
    else
      render action: "edit"
    end
  end

  def destroy
    @writing = Writing.find(params[:id])
    flash[:success] = "You deleted <b>#{@writing.title}</b>."
    @writing.destroy
    redirect_to meta_writings_path
  end

end