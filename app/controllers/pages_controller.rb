class PagesController < ApplicationController

  def show
    begin
      @page = Page.find_by_permalink!(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to Redirect.find_by_from!(params[:id]).to
    end
  end

end
