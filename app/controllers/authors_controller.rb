class AuthorsController < ApplicationController

  def index
    @authors = Author.includes(:books).all
  end

  def show
    @author = Author.includes(books: [:post, :authors]).find(params[:id])
  end

end
