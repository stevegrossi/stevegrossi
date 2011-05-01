module ApplicationHelper
  
  def markdown(text)
    md = RDiscount.new(text, :smart)
    raw md.to_html
  end
  
end