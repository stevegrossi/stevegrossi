class Meta::WorksController < ApplicationController
  
  def index
    @title = 'Everything I\'ve built.'
    @works = Work.all
  end

end