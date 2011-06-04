class PagesController < ApplicationController
  def home
    @body_class = 'home'
    
    @latest_work = '';
    @latest_writing = Writing.find(:first, :order => "created_at DESC");
    @latest_book = Book.find(:first, :order => "created_at DESC")
  end

  def about
  end

end
