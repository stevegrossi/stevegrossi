require "spec_helper"

describe Post do
  it_behaves_like "a Postable", :post

  it "is invalid without a title" do
    post = build(:post, title: nil)
    expect(post).to_not be_valid
    expect(post.errors[:title].size).to eq(1)
  end

  it "sets book post title to book title by default" do
    post = build(:post, :book_post)
    expect(post).to be_valid
    expect(post.title).to eq(post.book.title)
  end

  it "is invalid without content" do
    post = build(:post, content: nil)
    expect(post).to_not be_valid
    expect(post.errors[:content].size).to eq(1)
  end

  it "is invalid without an idea" do
    post = build(:post, idea: nil)
    expect(post).to_not be_valid
    expect(post.errors[:idea].size).to eq(1)
  end

  it "counts its words" do
    post = create(:post, content: "I’ve been workin’ on the railroad all the live-long day.")
    expect(post.word_count).to eq(10)
  end
end
