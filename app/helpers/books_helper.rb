module BooksHelper

  def linked_author_list(book)
    author_links = []
    book.authors.each do |author|
      author_links << link_to(author.full_name, author)
    end
    raw author_links.to_sentence
  end

  def author_list(book)
    book.authors.map(&:full_name).to_sentence
  end

  def books_by(author)
    book_links = []
    author.books.each do |book|
      book_links << link_to(book.title, book)
    end
    raw book_links.to_sentence
  end

  def get_cover(book)
    if book.cover_image.blank?
      image_tag("http://images.amazon.com/images/P/#{ book.asin }.01.LZZZZZZZ.jpg", alt: '', class: 'cover')
    else
      image_tag( "http://cloud.stevegrossi.com/books/#{book.cover_image}", alt: book.title, class: 'cover')
    end
  end

end
