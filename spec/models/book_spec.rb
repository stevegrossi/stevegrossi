require "spec_helper"

describe Book do

  it "is invalid without a title" do
    expect(build(:book, title: nil)).to_not be_valid
  end

  it "is invalid without a publisher" do
    expect(build(:book, publisher: nil)).to_not be_valid
  end

  it "is invalid without a pub_year" do
    expect(build(:book, pub_year: nil)).to_not be_valid
  end

  it "is invalid without an author or authors" do
    expect(build(:book, :without_author)).to_not be_valid
  end

  it "is valid with multiple authors" do
    expect(build(:book, :with_two_authors)).to be_valid
  end

  it "can mark itself as finished" do
    book = build(:book)
    book.finish

    expect(book.end_date).to eq(Date.current)
  end

  describe "scopes" do
    let!(:read) { create(:book) }
    let!(:unread) { create(:book, :unread) }

    it "selects unread books" do
      expect(Book.unread).to eq([unread])
    end

    it "selects read books" do
      expect(Book.read).to eq([read])
    end
  end
end
