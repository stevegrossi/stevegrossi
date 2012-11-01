class Meta::DashboardController < ApplicationController

  before_filter :logged_in?

  def home
    @books_count = Book.count
    @authors_count = Author.count
    @works_count = Work.count
    @writings_count = Writing.count
    @pages_count = Page.count
  end
end
