class Meta::WorksController < Meta::DashboardController

  def index
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
      redirect_to @work, notice: view_context.notify(:new, :work)
    else
      render :new
    end
  end

  def update
    @work = Work.find(params[:id])
    @work.attributes = params[:work]
    if params[:commit] == 'Publish'
      @work.published_at ||= Time.now
    elsif params[:commit] == 'Unpublish'
      @work.published_at = nil
    end
    if @work.save
      redirect_to @work, notice: view_context.notify(:updated, :work)
    else
      render :edit
    end
  end

  def destroy
    @work = Work.find(params[:id])
    title = @work.title
    @work.destroy
    redirect_to meta_works_path, notice: "You deleted <b>#{title}</b>."
  end

end
