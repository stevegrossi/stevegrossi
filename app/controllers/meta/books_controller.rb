class Meta::BooksController < Meta::DashboardController

  def index
    @books = Book.includes(:authors).all
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
      redirect_to @book, notice: view_context.notify(:new, :book)
    else
      render :new
    end
  end

  def update
    @book = Book.find(params[:id])
    @authors = Author.all
    @book.attributes = params[:book]
    params[:book][:published_at] = nil if params[:book][:published_at].blank?
    if params[:commit] == 'Publish'
      @book.published_at ||= Time.now
    elsif params[:commit] == 'Unpublish'
      @book.published_at = nil
    end
    if @book.save
      redirect_to @book, notice: view_context.notify(:updated, :book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    title = @book.title
    @book.destroy
    redirect_to meta_books_path, notice: "You deleted <b>#{title}</b>."
  end

end
