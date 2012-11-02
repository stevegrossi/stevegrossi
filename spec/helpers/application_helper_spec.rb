# coding: utf-8
require 'spec_helper'

describe ApplicationHelper do
  describe '#markdown' do
    it 'parses markdown' do
      string = 'I *am* some **simple** markdown.'
      markdown_string = '<p>I <em>am</em> some <strong>simple</strong> markdown.</p>'
      markdown(string).should eq(markdown_string)
    end
  end
  describe '#link_to_new' do
    it 'links to a new type of record' do
      link_to_new_writing = link_to('New writing', new_meta_writing_path, class: 'link_to_new')
      stub!(:current_user).and_return(true)
      link_to_new(:writing).should eq(link_to_new_writing)
    end
  end
  describe '#nav_link_to' do
    it 'links to a page with the class "current" if it is the current page' do
      expected = link_to('Works', works_path, class: 'current')
      stub!(:current_page?).and_return(true)
      nav_link_to('Works', works_path).should eq(expected)
    end
    it 'links to a page without the class "current" if it is not the current page' do
      expected = link_to('Works', works_path)
      stub!(:current_page?).and_return(false)
      nav_link_to('Works', works_path).should eq(expected)
    end
    # TODO: figure out how to stub the current controller actions so
    # it 'works for children of the linked-to page'
  end
  describe '#word_count' do
    it 'counts words' do
      # TODO: this could be much more specific
      string = 'Hey there, how are you?'
      word_count(string).should eq('5 words')
    end
  end
  describe '#bubble_up' do
    it 'moves items to the beginning of an array' do
      array = %w(one two three four five)
      goal = %w(three four one two five)
      bubble_up(array, %w(three four)).should eq(goal)
    end
    it 'handles single input' do
      array = %w(one two three four five)
      goal = %w(four one two three five)
      bubble_up(array, 'four').should eq(goal)
    end
  end
end
