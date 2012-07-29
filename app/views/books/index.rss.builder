xml.instruct! :xml, version: "1.0" 
xml.rss version: "2.0" do
  xml.channel do
    xml.title "Steve Grossi's Reading List"
    xml.description "Books I've read, and thoughts they've made me think."
    xml.link books_url

    @books.each do |book|
      xml.item do
        xml.title "#{book.title}, by #{book.authors.collect{|author| author.full_name}.to_sentence}"
        xml.description markdown(book.thoughts)
        xml.pubDate book.published_at.to_s(:rfc822)
        xml.link book_url(book)
        xml.guid book_url(book)
      end
    end
  end
end