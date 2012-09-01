class Meta::WritingsController < ApplicationController
  
  def index
    @title = 'All Writings'
    @writings = Writing.all
  end

end