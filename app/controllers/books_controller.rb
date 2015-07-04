class BooksController < ApplicationController

  def index
    @books_by_year = Book.includes(:post).order(end_date: :asc, start_date: :asc).group_by(&:year_read).to_a.reverse.to_h
  end

  def show
    @book = Book.friendly.find(params[:id])
  end

end
