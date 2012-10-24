class AuthorsController < ApplicationController

  def index
    @authors = Author.includes(:books).all
  end

  def show
    @author = Author.find(params[:id])
  end

end