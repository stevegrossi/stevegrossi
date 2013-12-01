# coding: utf-8
# == Schema Information
#
# Table name: books
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  publisher   :string(255)
#  pub_year    :string(255)
#  asin        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  subtitle    :string(255)
#  cover_image :string(255)
#  slug        :string(255)
#  end_date    :date
#  start_date  :date
#

require 'spec_helper'

describe Book do
  it 'has a valid factory' do
    FactoryGirl.build(:book).should be_valid
  end
  it 'is invalid without a title' do
    FactoryGirl.build(:book, title: nil).should_not be_valid
  end
  it 'is invalid without a publisher' do
    FactoryGirl.build(:book, publisher: nil).should_not be_valid
  end
  it 'is invalid without a pub_year' do
    FactoryGirl.build(:book, pub_year: nil).should_not be_valid
  end
  it 'is invalid without an author or authors' do
    FactoryGirl.build(:book_without_author).should_not be_valid
  end
  it 'is valid with multiple authors' do
    FactoryGirl.build(:book_with_two_authors).should be_valid
  end
  it 'can mark itself as finished' do
    book = FactoryGirl.build(:book)
    book.finish
    book.end_date.should eq(Time.now.to_date)
  end
  describe 'scopes' do
    before :each do
      @read = FactoryGirl.create(:book)
      @unread = FactoryGirl.create(:unread_book)
    end
    it 'selects unread books' do
      Book.unread.should eq([@unread])
    end
    it 'selects read books' do
      Book.read.should eq([@read])
    end
  end
end
