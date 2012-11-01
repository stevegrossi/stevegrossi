class Meta::PagesController < Meta::DashboardController

  def index
    @pages = Page.all
  end

  def new
    @page = Page.new
  end

  def edit
    @page = Page.find(params[:id])
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      redirect_to @page, notice: 'Yay, another page!'
    else
      render action: "new"
    end
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      redirect_to @page, notice: 'Page updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @page = Page.find(params[:id])
    title = @page.title
    @page.destroy
    redirect_to meta_pages_path, notice: "You deleted the page <b>#{title}</b>."
  end

end
