class AuthorsController < ApplicationController

  def index
    @authors = Author.includes(:books).all
  end

  def show
    @author = Author.find(params[:id])
  end

  def new
    @author = Author.new
  end

  def edit
    @author = Author.find(params[:id])
  end

  def create
    @author = Author.new(params[:author])
    if @author.save
      flash[:success] = 'A new author!'
      return redirect_to @author
    else
      render :action => "new"
    end
  end

  def update
    @author = Author.find(params[:id])
    if @author.update_attributes(params[:author])
      flash[:success] = 'Update successful.'
      redirect_to @author
    else
      render :action => "edit"
    end
  end

  def destroy
    @author = Author.find(params[:id])
    @author.destroy
  end
end