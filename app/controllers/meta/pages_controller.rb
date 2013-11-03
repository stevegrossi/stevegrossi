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
    @page = Page.new(page_params)
    if @page.save
      redirect_to @page, notice: view_context.notify(:new, :page)
    else
      render :new
    end
  end

  def update
    @page = Page.find_by_permalink!(params[:id])
    if @page.update_attributes(page_params)
      redirect_to @page, notice: view_context.notify(:updated, :page)
    else
      render :edit
    end
  end

  def destroy
    @page = Page.find_by_permalink!(params[:id])
    title = @page.title
    @page.destroy
    redirect_to meta_pages_path, notice: "You deleted the page <b>#{title}</b>."
  end

  private

  def page_params
    params.require(:page).permit(:title, :permalink, :content, :description)
  end

end
