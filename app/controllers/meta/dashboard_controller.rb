class Meta::DashboardController < ApplicationController

  before_filter :logged_in?

  def home
    @posts_count = Post.count
    @word_count = Post.sum(:word_count)
    @books_count = Book.count
    @authors_count = Author.count
    @works_count = Work.count
    @pages_count = Page.count
    @redirects_count = Redirect.count
  end
end
