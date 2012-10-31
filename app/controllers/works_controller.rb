class WorksController < ApplicationController

  include ApplicationHelper

  def index
    @works = Work.published
  end

  def show
    @work = Work.find(params[:id])
    if @work.draft?
      if current_user || params[:draft] == 'yep'
        flash.now.alert = 'This is a draft.'
      else
        redirect_to works_path, flash: { error: 'You must be logged in to view that draft.' }
      end
    end
  end

end
