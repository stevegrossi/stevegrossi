class BooksController < ApplicationController

  def index
    @title = 'Books'
    @description = 'Writing about books helps me figure out what I think about them.'
    @books = Book.published
  end

  def show
    @book = Book.find(params[:id])
    @title = @book.title
    @description = @book.thesis unless @book.thesis.blank?

    if @book.draft?
      if current_user || params[:draft] == 'yep'
        flash.now[:alert] = 'This is a draft.'
      else
        flash[:error] = 'You must be logged in to view this draft.'
        redirect_to books_path and return
      end
    end
  end

  def topics
    @title = 'Topics covered in books I\'ve read'
    @topics = Book.topic_counts
  end

  def topic
    @topic = ActsAsTaggableOn::Tag.find(params[:topic])
    @books = Book.published.tagged_with(@topic)
    @title = "Books I've read about #{@topic.name}"
  end

end
