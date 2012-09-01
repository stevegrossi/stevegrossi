class Meta::DashboardController < ApplicationController
  def index
    @books_count = Book.count
    @authors_count = Author.count
    @works_count = Work.count
    @writings_count = Writing.count
  end
end