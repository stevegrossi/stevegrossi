module ApplicationHelper
  
  def title
    @title ? @title + ' | Steve Grossi' : 'Steve Grossi makes websites often and sense sometimes.'
  end
  
  def markdown(text)
    md = RDiscount.new(text, :smart)
    raw md.to_html
  end
  
  def get_cover(book)
    if book.cover_image.blank?
      image_tag("http://images.amazon.com/images/P/#{ book.asin }.01.LZZZZZZZ.jpg", :alt => book.title, :class => 'cover')
    else
      image_tag("/images/books/#{book.cover_image}", :alt => book.title, :class => 'cover')
    end
  end
  
end