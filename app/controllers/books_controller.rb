class BooksController < ApplicationController

  def index
    @unread = Book.includes(:post).unread
    @unposted = Book.includes(:authors).read.unposted
    @posted = Book.includes(:authors).posted.limit(5)
  end

  def show
    @book = Book.find(params[:id])
  end

end
