class PagesController < ApplicationController
  def home
    @title = 'Steve Grossi makes websites often and sense sometimes.'
    @description = 'Hey, I\'m Steve and I design and build tools that help people do awesome things on the internet. This, like me, is a work-in-progress.'
    latest_works = Work.published.limit(10)
    latest_writings = Writing.published.limit(10)
    latest_books = Book.published.limit(10)
    @latest = (latest_works + latest_writings + latest_books).sort_by{ |thing| -thing.created_at.to_i }
  end

  def about
    @title = 'A Bit About Me'
  end

  def colophon
    @title = "Credit Where It's Due"
  end
  
  def styleguide
    @title = 'Styleguide'
  end
  
  def search
    @query = params[:for]
    @title = @query.blank? ? 'Search' : "Searching for '#{@query}'"
    
    @results = PgSearch.multisearch(@query).limit(10)
  end

  def error_404
    @title = '404: Page Not Found'
    render :file => "/pages/error_404.html.erb", :status => 404, :layout => true
  end

end