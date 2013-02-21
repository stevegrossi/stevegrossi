class BooksController < ApplicationController

  def index
    @unread = Book.includes(:post).unread
    @unposted = Book.read.unposted
    @posted = Book.posted.limit(5)
  end

  def show
    @book = Book.find(params[:id])
  end

end
