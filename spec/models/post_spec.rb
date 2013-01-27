# == Schema Information
#
# Table name: posts
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  link_url     :string(255)
#  idea         :text
#  content      :text
#  book_id      :integer
#  slug         :string(255)
#  published_at :datetime
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

require 'spec_helper'

describe Post do
  it 'has a valid factory' do
    FactoryGirl.build(:post).should be_valid
  end
  it 'is invalid without a title' do
    post = FactoryGirl.build(:post, title: nil)
    post.should_not be_valid
    post.should have(1).error_on(:title)
  end
  it 'is invalid without content' do
    post = FactoryGirl.build(:post, content: nil)
    post.should_not be_valid
    post.should have(1).error_on(:content)
  end
  it 'is invalid without an idea' do
    post = FactoryGirl.build(:post, idea: nil)
    post.should_not be_valid
    post.should have(1).error_on(:idea)
  end
  it_behaves_like 'a Postable', :post
end
