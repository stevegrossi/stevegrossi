class BooksController < ApplicationController

  def index
    @books = Book.published
  end

  def show
    @book = Book.find(params[:id])

    if @book.draft?
      if current_user || params[:draft] == 'yep'
        flash.now.alert = 'This is a draft.'
      else
        redirect_to books_path, flash: { error: 'You must be logged in to view that draft.' }
      end
    end
  end

  def topics
    @topics = Book.topic_counts
  end

  def topic
    @topic = ActsAsTaggableOn::Tag.find(params[:topic])
    @books = Book.published.tagged_with(@topic)
  end

end
