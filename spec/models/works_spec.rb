require 'spec_helper'

describe Book do
  it 'has a valid factory' do
    FactoryGirl.create(:work).should be_valid
  end
  it 'is invalid without a title' do
    FactoryGirl.build(:work, title: nil).should_not be_valid
  end
  it 'is invalid without a summary' do
    FactoryGirl.build(:work, about: nil).should_not be_valid
  end
  it 'is invalid without an image filename' do
    FactoryGirl.build(:work, image_filename: nil).should_not be_valid
  end
end