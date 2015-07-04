require 'spec_helper'

describe BooksHelper do

  describe '#author_list' do

    it 'lists authors' do
      author1 = build(:author)
      author2 = build(:author)
      book = build(:book_without_author, authors: [author1, author2])
      expected = "#{author1.full_name} and #{author2.full_name}"
      expect(author_list(book)).to eq(expected)
    end
  end

  describe '#linked_author_list' do

    it 'lists authors linked to their pages' do
      author1 = build(:author)
      author2 = build(:author)
      book = build(:book_without_author, authors: [author1, author2])
      expected = link_to(author1.full_name, author1)
      expected += ' and '
      expected += link_to(author2.full_name, author2)
      expect(linked_author_list(book)).to eq(expected)
    end
  end
end
