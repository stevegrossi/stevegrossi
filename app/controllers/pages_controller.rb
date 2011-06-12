class PagesController < ApplicationController
  def home
    @body_class = 'home'
    
    @latest_work = Work.find(:first, :order => "created_at DESC");
    @latest_writing = Writing.find(:first, :order => "created_at DESC");
    @latest_book = Book.find(:first, :order => "created_at DESC")
  end

  def about
  end
  
  def colophon
  end

end
