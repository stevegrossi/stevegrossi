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
    @redirect = Redirect.new(redirect_params)
    if @redirect.save
      redirect_to meta_redirects_path, notice: view_context.notify(:new, :redirect)
    else
      render :new
    end
  end

  def update
    @redirect = Redirect.find(params[:id])
    if @redirect.update_attributes(redirect_params)
      redirect_to meta_redirects_path, notice: view_context.notify(:updated, :redirect)
    else
      render :edit
    end
  end

  def destroy
    @redirect = Redirect.find(params[:id])
    @redirect.destroy
    redirect_to meta_redirects_path, notice: "You deleted the redirect."
  end

  private

  def redirect_params
    params.require(:redirect).permit(:to, :from)
  end

end
