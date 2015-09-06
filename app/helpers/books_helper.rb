module BooksHelper

  def linked_author_list(book)
    book.authors.map { |author|
      link_to(author.full_name, author)
    }.to_sentence.html_safe
  end

  def author_list(book)
    book.authors.map(&:full_name).to_sentence
  end
end
