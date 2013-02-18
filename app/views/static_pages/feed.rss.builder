xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title "Thoughts from Steve Grossi"
    xml.description "Links, books, and other things I'm thinking about."
    xml.link books_url

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.description markdown(post.content)
        xml.pubDate post.published_at.to_s(:rfc822)
        xml.link post_url(post)
        xml.guid post_url(post)
      end
    end
  end
end
