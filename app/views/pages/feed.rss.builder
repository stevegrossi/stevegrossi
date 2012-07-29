xml.instruct! :xml, version: "1.0" 
xml.rss version: "2.0" do
  xml.channel do
    xml.title "Everything from Steve Grossi"
    xml.description "Books I've read, things I've written, and work I've done. You must really like me."
    xml.link books_url

    @latest.each do |thing|
      xml.item do
        xml.title thing.title
        if thing.is_a?(Book)
          xml.description markdown(thing.thoughts)
        elsif thing.is_a?(Writing)
          xml.description markdown(thing.content)
        elsif thing.is_a?(Work)
          xml.description image_tag(thing.image_filename, :alt => '') + markdown(thing.about) + "<p>Visit the site at #{link_to nice_url(thing.url)}</p>"
        else
          xml.description 'What is this thing?'
        end
        xml.description 
        xml.pubDate thing.published_at.to_s(:rfc822)
        xml.link polymorphic_url(thing)
        xml.guid polymorphic_url(thing)
      end
    end
  end
end