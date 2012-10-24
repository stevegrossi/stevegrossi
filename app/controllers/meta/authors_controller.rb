class Meta::AuthorsController < Meta::DashboardController

  def index
    @title = 'All Authors I\'ve Read'
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
        format.html { redirect_to @author, success: 'A new author!' }
        format.js
      else
        render action: "new"
      end
    end
  end

  def update
    @author = Author.find(params[:id])
    if @author.update_attributes(params[:author])
      flash[:success] = 'Update successful.'
      redirect_to @author
    else
      render action: "edit"
    end
  end

  def destroy
    @author = Author.find(params[:id])
    @author.destroy
    redirect_to meta_authors_path
  end

end