class Meta::RedirectsController < Meta::DashboardController

  def index
    @redirects = Redirect.all
  end

  def new
    @redirect = Redirect.new
  end

  def edit
    @redirect = Redirect.find(params[:id])
  end

  def create
    @redirect = Redirect.new(params[:redirect])
    if @redirect.save
      redirect_to meta_redirects_path, notice: view_context.notify(:new, :redirect)
      Stevegrossi::Application.reload_routes!
    else
      render :new
    end
  end

  def update
    @redirect = Redirect.find(params[:id])
    if @redirect.update_attributes(params[:redirect])
      Stevegrossi::Application.reload_routes!
      redirect_to meta_redirects_path, notice: view_context.notify(:updated, :redirect)
    else
      render :edit
    end
  end

  def destroy
    @redirect = Redirect.find(params[:id])
    @redirect.destroy
    Stevegrossi::Application.reload_routes!
    redirect_to meta_redirects_path, notice: "You deleted the redirect."
  end

end
