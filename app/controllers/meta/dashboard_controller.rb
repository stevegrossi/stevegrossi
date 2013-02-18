class Meta::DashboardController < ApplicationController

  before_filter :logged_in?

  def home
    @posts_count = Post.count
    @books_count = Book.count
    @authors_count = Author.count
    @works_count = Work.count
    @writings_count = Writing.count
    @pages_count = Page.count
    @redirects_count = Redirect.count
  end
end
