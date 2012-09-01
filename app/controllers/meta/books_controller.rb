class Meta::BooksController < ApplicationController
  
  def index
    @title = 'Everything I\'ve read.'
    @books = Book.all
  end

end