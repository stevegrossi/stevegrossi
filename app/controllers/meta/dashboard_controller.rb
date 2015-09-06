class Meta::DashboardController < ApplicationController

  layout "meta"

  before_action :authenticate_user!

  def home
    @posts_count = Post.published.count
    @word_count = Post.published.sum(:word_count)
    @books_count = Book.count
    @authors_count = Author.count
    @pages_count = Page.count
    @redirects_count = Redirect.count
    @users_count = User.count
  end
end
