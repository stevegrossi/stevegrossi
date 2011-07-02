class PagesController < ApplicationController
  def home
    @latest_work = Work.find(:first, :order => "created_at DESC");
    @latest_writing = Writing.find(:first, :order => "created_at DESC");
    @latest_book = Book.find(:first, :order => "created_at DESC")
  end

  def about
    @title = 'A Bit About Me'
  end

  def colophon
    @title = "Credit Where It's Due"
  end

  def error_404
    @title = '404: Page Not Found'
    render :file => "/pages/error_404.html.erb", :status => 404, :layout => true
  end

end