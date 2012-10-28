class WorksController < ApplicationController

  include ApplicationHelper

  def index
    @works = Work.published
    @title = 'The finest websites, built with love'
  end

  def show
    @work = Work.find(params[:id])
    @title = @work.title
    @description = "I built #{nice_url(@work.url)} for #{@work.client}."

    if @work.draft?
      if current_user || params[:draft] == 'yep'
        flash.now[:alert] = 'This is a draft.'
      else
        redirect_to works_path, flash: { error: 'You must be logged in to view that draft.' }
      end
    end
  end

end
