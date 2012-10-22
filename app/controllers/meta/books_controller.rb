class Meta::BooksController < Meta::DashboardController

  def index
    @title = 'Everything I\'ve read.'
    @books = Book.all
  end

end