class PagesController < ApplicationController

  def show
    begin
      @page = Page.find_by_permalink!(params[:id])
    rescue
      redirect = Redirect.find_by_from!(params[:id])
      redirect_to redirect.to if redirect
    end
  end

end
