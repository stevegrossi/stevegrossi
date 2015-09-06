require "spec_helper"

describe ApplicationHelper do

  describe "#markdown" do

    it "parses markdown" do
      string = "I *am* some **simple** markdown."
      markdown_string = "<p>I <em>am</em> some <strong>simple</strong> markdown.</p>"

      expect(markdown(string)).to include(markdown_string)
    end
  end

  describe "#link_to_new" do

    it "links to a new type of record" do
      link_to_new_post = link_to("New post", new_meta_post_path)

      expect(link_to_new(:post)).to eq(link_to_new_post)
    end
  end

  describe "#nav_link_to" do

    context "when it’s the the current page" do

      before :each do
        allow(self).to receive(:current_page?) { true }
      end

      it 'links to a page with the class "current"' do
        expected = link_to("Books", books_path, class: "SiteHeader-navLink SiteHeader-navLink--current")
        expect(nav_link_to("Books", books_path)).to eq(expected)
      end
    end

    context "when it’s not the current page" do

      before do
        allow(self).to receive(:current_page?) { false }
      end

      it "links to a page" do
        expected = link_to("Books", books_path, class: "SiteHeader-navLink")
        expect(nav_link_to("Books", books_path)).to eq(expected)
      end
    end
  end

  describe "#notify" do

    it "notifies new and links to meta all" do
      expected = 'New author created. <a href="/meta/authors">View all</a>.'
      expect(notify(:new, :author)).to eq(expected)
    end

    it "notifies updated and links to meta all" do
      expected = 'Updated book. <a href="/meta/books">View all</a>.'
      expect(notify(:updated, :book)).to eq(expected)
    end

    it "raises an exception for invalid actions" do
      expect {
        notify(:deleted, :post)
      }.to raise_error
    end
  end
end
