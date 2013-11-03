class Meta::AuthorsController < Meta::DashboardController

  def index
    @authors = Author.includes(:books)
  end

  def new
    @author = Author.new
  end

  def edit
    @author = Author.find(params[:id])
  end

  def create
    @author = Author.new(author_params)
    respond_to do |format|
      if @author.save
        format.html { redirect_to @author, notice: view_context.notify(:new, :author) }
        format.js
      else
        format.html { render :new }
      end
    end
  end

  def update
    @author = Author.find(params[:id])
    if @author.update_attributes(author_params)
      redirect_to @author, notice: view_context.notify(:updated, :author)
    else
      render :edit
    end
  end

  def destroy
    @author = Author.find(params[:id])
    name = @author.full_name
    @author.destroy
    redirect_to meta_authors_path, notice: "You deleted <b>#{name}</b>"
  end

  private

  def author_params
    params.require(:author).permit(:fname, :mname, :lname)
  end

end
