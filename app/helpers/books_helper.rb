module BooksHelper
  
  def authors_for(book)
    author_links = []
    book.authors.each do |author|
      author_links << link_to(author.full_name, author)
    end
    raw author_links.to_sentence
  end
  
  def get_cover(book)
    if book.cover_image.blank?
      image_tag("http://images.amazon.com/images/P/#{ book.asin }.01.LZZZZZZZ.jpg", :alt => '', :class => 'cover')
    else
      image_tag( "http://cloud.stevegrossi.com/books/#{book.cover_image}", :alt => book.title, :class => 'cover')
    end
  end

end