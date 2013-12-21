# == Schema Information
#
# Table name: authors
#
#  id         :integer          not null, primary key
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
    build(:author).should be_valid
  end
  it 'is invalid without a first name' do
    build(:author, fname: nil).should_not be_valid
  end
  it 'is invalid without a last_name' do
    build(:author, lname: nil).should_not be_valid
  end
  it 'does not allow duplicates' do
    create(:author, fname: 'Steven', lname: 'Grossi')
    build(:author, fname: 'Steven', lname: 'Grossi').should_not be_valid
  end
  describe '#full_name' do
    it 'returns an author\'s full name as a string' do
      author = build(:author, fname: 'Steven', mname: 'Michael', lname: 'Grossi')
      author.full_name.should == 'Steven Michael Grossi'
    end
  end
end
