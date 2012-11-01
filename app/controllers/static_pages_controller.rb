class StaticPagesController < ApplicationController
  def home
    latest_works = Work.published.limit(10)
    latest_writings = Writing.published.limit(10)
    latest_books = Book.published.limit(10)
    @latest = (latest_works + latest_writings + latest_books).sort_by{ |thing| -thing.published_at.to_i }
  end

  def feed
    latest_works = Work.published.limit(10)
    latest_writings = Writing.published.limit(10)
    latest_books = Book.published.limit(10)
    @latest = (latest_works + latest_writings + latest_books).sort_by{ |thing| -thing.published_at.to_i }
    respond_to :rss
  end

  def search
    @query = params[:for]
    return redirect_to search_path if @query == ''
    @results = PgSearch.multisearch(@query).limit(10)
  end

  def error_404
    render file: "/static_pages/error_404.html.erb", status: 404, layout: true
  end

end
