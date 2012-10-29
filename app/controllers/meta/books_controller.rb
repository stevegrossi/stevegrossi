class Meta::BooksController < Meta::DashboardController

  def index
    @title = 'Everything I\'ve read.'
    @books = Book.all
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
      redirect_to @book, notice: 'Yay, you read another thing!'
    else
      render action: "new"
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
      redirect_to @book, notice: 'Book updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    title = @book.title
    @book.destroy
    redirect_to meta_books_path, notice: "You deleted <b>#{title}</b>."
  end

end
