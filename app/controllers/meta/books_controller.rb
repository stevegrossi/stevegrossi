class Meta::BooksController < Meta::DashboardController

  def index
    @books = Book.includes(:authors).order("start_date DESC")
  end

  def new
    @book = Book.new
    @book.start_date = Time.now.to_date
    @authors = Author.all
  end

  def edit
    @book = Book.friendly.find(params[:id])
    @authors = Author.all
  end

  def create
    @book = Book.new(book_params)
    @authors = Author.all
    if @book.save
      redirect_to @book, notice: view_context.notify(:new, :book)
    else
      render :new
    end
  end

  def update
    @book = Book.friendly.find(params[:id])
    @authors = Author.all
    @book.attributes = book_params
    book_params[:published_at] = nil if book_params[:published_at].blank?
    if @book.save
      redirect_to @book, notice: view_context.notify(:updated, :book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.friendly.find(params[:id])
    title = @book.title
    @book.destroy
    redirect_to meta_books_path, notice: "You deleted <b>#{title}</b>."
  end

  def finish
    book = Book.friendly.find(params[:book_id])
    book.finish
    book.save
    redirect_to meta_books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :subtitle, :asin, :publisher, :pub_year, { author_ids: [] }, :cover_image, :start_date, :end_date)
  end

end
