# coding: utf-8
# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  link_url     :string(255)
#  idea         :text
#  content      :text
#  book_id      :integer
#  slug         :string(255)
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  word_count   :integer
#

require 'spec_helper'

describe Post do
  it 'has a valid factory' do
    build(:post).should be_valid
  end
  it 'is invalid without a title' do
    post = build(:post, title: nil)
    post.should_not be_valid
    expect(post.errors[:title].size).to eq(1)
  end
  it 'sets book post title to book title by default' do
    post = build(:book_post)
    post.should be_valid
    post.title.should eq(post.book.title)
  end
  it 'is invalid without content' do
    post = build(:post, content: nil)
    post.should_not be_valid
    expect(post.errors[:content].size).to eq(1)
  end
  it 'is invalid without an idea' do
    post = build(:post, idea: nil)
    post.should_not be_valid
    expect(post.errors[:idea].size).to eq(1)
  end
  it 'counts its words' do
    post = create(:post, content: 'I’ve been workin’ on the railroad all the live-long day.')
    post.word_count.should eq(10)
  end
  it_behaves_like 'a Postable', :post
end
