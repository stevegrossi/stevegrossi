class Meta::AuthorsController < Meta::DashboardController

  def index
    @authors = Author.includes(:books).all
  end

  def new
    @author = Author.new
  end

  def edit
    @author = Author.find(params[:id])
  end

  def create
    @author = Author.new(params[:author])
    respond_to do |format|
      if @author.save
        format.html { redirect_to @author, notice: view_context.notify(:new, :author) }
        format.js
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @author = Author.find(params[:id])
    if @author.update_attributes(params[:author])
      redirect_to @author, notice: view_context.notify(:updated, :author)
    else
      render action: "edit"
    end
  end

  def destroy
    @author = Author.find(params[:id])
    name = @author.full_name
    @author.destroy
    redirect_to meta_authors_path, notice: "You deleted <b>#{name}</b>"
  end

end
