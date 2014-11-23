require 'spec_helper'

describe ApplicationHelper do
  describe '#markdown' do
    it 'parses markdown' do
      string = 'I *am* some **simple** markdown.'
      markdown_string = '<p>I <em>am</em> some <strong>simple</strong> markdown.</p>'
      expect(markdown(string)).to include(markdown_string)
    end
  end
  describe '#link_to_new' do
    it 'links to a new type of record' do
      link_to_new_post = link_to('New post', new_meta_post_path, class: 'link_to_new')
      def current_user; true; end
      expect(link_to_new(:post)).to eq(link_to_new_post)
    end
  end
  describe '#nav_link_to' do
    it 'links to a page with the class "current" if it is the current page' do
      expected = link_to('Books', books_path, class: 'current')
      def current_page?(*); true; end
      expect(nav_link_to('Books', books_path)).to eq(expected)
    end
    it 'links to a page without the class "current" if it is not the current page' do
      expected = link_to('Books', books_path)
      def current_page?(*); false; end
      expect(nav_link_to('Books', books_path)).to eq(expected)
    end
  end
  describe '#bubble_up' do
    it 'moves items to the beginning of an array' do
      array = %w(one two three four five)
      goal = %w(three four one two five)
      expect(bubble_up(array, %w(three four))).to eq(goal)
    end
    it 'handles single input' do
      array = %w(one two three four five)
      goal = %w(four one two three five)
      expect(bubble_up(array, 'four')).to eq(goal)
    end
  end
  describe '#notify' do
    it 'notifies new and links to meta all' do
      expected = 'New author created. <a href="/meta/authors">View all</a>.'
      expect(notify(:new, :author)).to eq(expected)
    end
    it 'notifies updated and links to meta all' do
      expected = 'Updated book. <a href="/meta/books">View all</a>.'
      expect(notify(:updated, :book)).to eq(expected)
    end
    it 'raises an exception for invalid actions' do
      expect {
        notify(:deleted, :post)
      }.to raise_error
    end
  end
end
