class Meta::WorksController < Meta::DashboardController

  def index
    @title = 'Everything I\'ve built.'
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def edit
    @work = Work.find(params[:id])
  end

  def create
    @work = Work.new(params[:work])
    if params[:commit] == 'Publish'
      @work.published_at ||= Time.now
    end
    if @work.save
      redirect_to @work, flash: { success: 'Yay, you built another thing!' }
    else
      render action: "new"
    end
  end

  def update
    @work = Work.find(params[:id])
    # Set '' to nil so ||= works 2 below
    params[:work][:published_at] = nil if params[:work][:published_at].blank?
    if params[:commit] == 'Publish'
      params[:work][:published_at] ||= Time.now
    elsif params[:commit] == 'Unpublish'
      params[:work][:published_at] = nil
    end
    if @work.update_attributes(params[:work])
      redirect_to @work, flash: { success: 'Work updated.' }
    else
      render action: "edit"
    end
  end

  def destroy
    @work = Work.find(params[:id])
    flash[:success] = "You deleted <b>#{@work.title}</b>."
    @work.destroy
    redirect_to meta_works_path
  end

end
