require 'spec_helper'

describe Writing do
  it 'has a valid factory' do
    FactoryGirl.create(:writing).should be_valid
  end
  it 'is invalid without a title' do
    FactoryGirl.build(:writing, title: nil).should_not be_valid
  end
  it 'is invalid without content' do
    FactoryGirl.build(:writing, content: nil).should_not be_valid
  end
  it 'is invalid without a summary' do
    FactoryGirl.build(:writing, summary: nil).should_not be_valid
  end
end