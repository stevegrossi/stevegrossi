# == Schema Information
#
# Table name: writings
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  content      :text
#  summary      :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  published_at :datetime
#

require 'spec_helper'

describe Writing do
  it 'has a valid factory' do
    FactoryGirl.build(:writing).should be_valid
  end
  it 'is invalid without a title' do
    writing = FactoryGirl.build(:writing, title: nil)
    writing.should_not be_valid
    writing.should have(1).error_on(:title)
  end
  it 'is invalid without content' do
    writing = FactoryGirl.build(:writing, content: nil)
    writing.should_not be_valid
    writing.should have(1).error_on(:content)
  end
  it 'is invalid without a summary' do
    writing = FactoryGirl.build(:writing, summary: nil)
    writing.should_not be_valid
    writing.should have(1).error_on(:summary)
  end
end
