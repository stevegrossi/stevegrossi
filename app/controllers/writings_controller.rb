class WritingsController < ApplicationController

  def index
    @writings = Writing.published
  end

  def show
    @writing = Writing.find(params[:id])
    if @writing.draft?
      if current_user || params[:draft] == 'yep'
        flash.now.alert = 'This is a draft.'
      else
        redirect_to writings_path, flash: { error: 'You must be logged in to view that draft.' }
      end
    end
  end

end
