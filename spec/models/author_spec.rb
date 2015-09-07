require "spec_helper"

describe Author do

  it "has a valid factory" do
    expect(build(:author)).to be_valid
  end

  it "is invalid without a first name" do
    expect(build(:author, fname: nil)).to_not be_valid
  end

  it "is invalid without a last_name" do
    expect(build(:author, lname: nil)).to_not be_valid
  end

  it "does not allow duplicates" do
    create(:author, fname: "Steven", lname: "Grossi")

    expect(build(:author, fname: "Steven", lname: "Grossi")).to_not be_valid
  end

  describe "#full_name" do
    let(:author) { build(:author, fname: "Steven", mname: "Michael", lname: "Grossi") }

    it "returns an author’s full name as a string" do
      expect(author.full_name).to eq("Steven Michael Grossi")
    end
  end
end
