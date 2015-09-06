class AuthorsController < ApplicationController

  def index
    @authors = Author.includes(:books)
  end

  def show
    @author = Author.includes(books: [:post, :authors]).find(params[:id])
    @books = @author.books.order("pub_year DESC") if @author
  end

end
