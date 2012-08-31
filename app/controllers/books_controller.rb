class BooksController < ApplicationController

  before_filter :logged_in?, :except => [:index, :show, :topic, :topics]

  def index
    @title = 'Books'
    @description = 'Writing about books helps me figure out what I think about them.'
    @books = Book.published
  end
  
  def everything
    @title = 'Everything I\'ve read.'
    @books = Book.all
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

  def new
    @book = Book.new
    @authors = Author.all
  end

  def edit
    @book = Book.find(params[:id])
    @authors = Author.all
  end

  def create
    @book = Book.new(params[:book])
    @authors = Author.all
    if params[:commit] == 'Publish'
      @book.published_at ||= Time.now
    end
    if @book.save
      flash[:success] = 'Yay, you read another thing!'
      redirect_to @book
    else
      render :action => "new"
    end
  end

  def update
    @book = Book.find(params[:id])
    @authors = Author.all
    # Set '' to nil so ||= works 2 below
    params[:book][:published_at] = nil if params[:book][:published_at].blank?
    if params[:commit] == 'Publish'
      params[:book][:published_at] ||= Time.now
    elsif params[:commit] == 'Unpublish'
      params[:book][:published_at] = nil
    end
    if @book.update_attributes(params[:book])
      flash[:success] = 'Book updated.'
      redirect_to @book
    else
      render :action => "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    flash[:success] = "You deleted <b>#{@book.title}</b>."
    @book.destroy
    return redirect_to everything_books_path
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
