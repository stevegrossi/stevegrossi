class Meta::AuthorsController < Meta::DashboardController

  def index
    @title = 'All Authors I\'ve Read'
    @authors = Author.includes(:books).all
  end

end