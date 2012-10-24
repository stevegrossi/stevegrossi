class WritingsController < ApplicationController

  def index
    @title = 'I write things'
    @description = 'Some thoughts I\'ve liked enough to write down'
    @writings = Writing.published
  end

  def show
    @writing = Writing.find(params[:id])
    @title = @writing.title
    @description = @writing.summary unless @writing.summary.blank?

    if @writing.draft?
      if current_user || params[:draft] == 'yep'
        flash.now[:alert] = 'This is a draft.'
      else
        flash[:error] = 'You must be logged in to view this draft.'
        redirect_to writings_path and return
      end
    end
  end

end
