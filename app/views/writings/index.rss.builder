xml.instruct! :xml, version: "1.0" 
xml.rss version: "2.0" do
  xml.channel do
    xml.title "Steve Grossi's Writings"
    xml.description "Particularly noteworthy thoughts."
    xml.link writings_url

    @writings.each do |writing|
      xml.item do
        xml.title writing.title
        xml.description markdown(writing.content)
        xml.pubDate writing.published_at.to_s(:rfc822)
        xml.link writing_url(writing)
        xml.guid writing_url(writing)
      end
    end
  end
end