# == Schema Information
#
# Table name: pages
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  permalink   :string(255)
#  content     :text
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Page do
  it 'has a valid factory' do
    FactoryGirl.build(:page).should be_valid
  end
  it 'is invalid without a title' do
    page = FactoryGirl.build(:page, title: nil)
    page.should_not be_valid
    page.should have(1).error_on(:title)
  end
  it 'is invalid without a permalink' do
    page = FactoryGirl.build(:page, permalink: nil)
    page.should_not be_valid
    page.should have(1).error_on(:permalink)
  end
  it 'is invalid without content' do
    page = FactoryGirl.build(:page, content: nil)
    page.should_not be_valid
    page.should have(1).error_on(:content)
  end
  it 'has a unique title' do
    FactoryGirl.create(:page, title: 'About')
    FactoryGirl.build(:page, title: 'About').should_not be_valid
  end
  it 'has a unique permalink' do
    FactoryGirl.create(:page, permalink: 'about/pants')
    FactoryGirl.build(:page, permalink: 'about/pants').should_not be_valid
  end
end
