# == Schema Information
#
# Table name: books
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  author       :string(255)
#  publisher    :string(255)
#  pub_year     :string(255)
#  asin         :string(255)
#  thoughts     :text
#  created_at   :datetime
#  updated_at   :datetime
#  subtitle     :string(255)
#  cover_image  :string(255)
#  thesis       :text
#  published_at :datetime
#  slug         :string(255)
#  read_on      :date
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
  it 'is invalid without thoughts' do
    FactoryGirl.build(:book, thoughts: nil).should_not be_valid
  end
  it 'is invalid without an author or authors' do
    FactoryGirl.build(:book_without_author).should_not be_valid
  end
  it 'is valid with multiple authors' do
    FactoryGirl.build(:book_with_two_authors).should be_valid
  end
  it_behaves_like 'a Postable', :book
end
