class BooksController < ApplicationController

  def index
    @unread = Book.includes(:authors, :post).unread
    @unposted = Book.includes(:authors, :post).read.unposted
    @posted = Book.includes(:authors, :post).posted.limit(5)
  end

  def show
    @book = Book.find(params[:id])
  end

end
