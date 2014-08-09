class ErrorsController < ApplicationController
  def error_404
    render status: 404
  end

  def error_422
    render status: 422
  end

  def error_500
    render layout: false, status: 500,
           file: Rails.root.join('/public/500.html')
  end
end
