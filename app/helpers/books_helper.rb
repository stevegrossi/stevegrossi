module BooksHelper
  
  def authors_for(book)
    author_links = []
    book.authors.each do |author|
      author_links << link_to(author.full_name, author)
    end
    raw author_links.to_sentence
  end

end