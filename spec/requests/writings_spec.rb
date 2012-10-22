require 'spec_helper'

describe "Writings" do
  describe "Create a writing" do
    it "Adds a new writing and displays the result" do
      visit new_writing_url
    end
  end
end