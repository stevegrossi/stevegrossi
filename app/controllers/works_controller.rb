class WorksController < ApplicationController

  include ApplicationHelper

  def index
    @works = Work.published
    @title = 'The finest websites, built with love'
  end

  # GET /works/1
  # GET /works/1.xml
  def show
    @work = Work.find(params[:id])
    @title = @work.title
    @description = "I built #{nice_url(@work.url)} for #{@work.client}."

    if @work.draft?
      if current_user || params[:draft] == 'yep'
        flash.now[:alert] = 'This is a draft.'
      else
        flash[:error] = 'You must be logged in to view this draft.'
        redirect_to works_path and return
      end
    end
  end

end
