# == Schema Information
#
# Table name: authors
#
#  id         :integer         not null, primary key
#  fname      :string(255)
#  mname      :string(255)
#  lname      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#

require 'spec_helper'

describe Author do
  it 'has a valid factory' do
    FactoryGirl.build(:author).should be_valid
  end
  it 'is invalid without a first name' do
    FactoryGirl.build(:author, fname: nil).should_not be_valid
  end
  it 'is invalid without a last_name' do
    FactoryGirl.build(:author, lname: nil).should_not be_valid
  end
  it 'does not allow duplicates' do
    FactoryGirl.create(:author, fname: 'Steven', lname: 'Grossi')
    FactoryGirl.build(:author, fname: 'Steven', lname: 'Grossi').should_not be_valid
  end
  describe '#full_name' do
    it 'returns an author\'s full name as a string' do
      author = FactoryGirl.build(:author, fname: 'Steven', mname: 'Michael', lname: 'Grossi')
      author.full_name.should == 'Steven Michael Grossi'
    end
  end
  describe '#has_published_books?' do
    it 'returns true when there are published books' do
      book = FactoryGirl.create(:book)
      author = book.authors.first
      author.has_published_books?.should eq(true)
    end
    it 'returns false when there are no published books' do
      author = FactoryGirl.create(:author)
      author.has_published_books?.should eq(false)
    end
  end
  describe '#published_books' do
    it 'returns books which have been published' do
      book = FactoryGirl.create(:book)
      author = book.authors[0]
      author.published_books.should eq([book])
    end
  end
end
