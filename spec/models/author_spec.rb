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
#

require 'spec_helper'

describe Author do
  it 'has a valid factory' do
    FactoryGirl.create(:author).should be_valid
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
  it 'returns an author\'s full name as a string' do
    author = FactoryGirl.create(:author, fname: 'Steven', mname: 'Michael', lname: 'Grossi')
    author.full_name.should == 'Steven Michael Grossi'
  end
  
end
