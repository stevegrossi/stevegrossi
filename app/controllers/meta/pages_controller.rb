class Meta::PagesController < Meta::DashboardController

  def index
    @pages = Page.all
  end

  def new
    @page = Page.new
  end

  def edit
    @page = Page.find_by_permalink!(params[:id])
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      redirect_to @page, notice: view_context.notify(:new, :page)
    else
      render action: "new"
    end
  end

  def update
    @page = Page.find_by_permalink!(params[:id])
    if @page.update_attributes(params[:page])
      redirect_to @page, notice: view_context.notify(:updated, :page)
    else
      render action: "edit"
    end
  end

  def destroy
    @page = Page.find_by_permalink!(params[:id])
    title = @page.title
    @page.destroy
    redirect_to meta_pages_path, notice: "You deleted the page <b>#{title}</b>."
  end

end
