class PagesController < ApplicationController
  def home
    @body_class = 'home'
    
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

end
