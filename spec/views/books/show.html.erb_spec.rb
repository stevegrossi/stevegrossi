require 'spec_helper'

describe "books/show.html.erb" do
  before(:each) do
    @book = assign(:book, stub_model(Book,
      :title => "Title",
      :author => "Author",
      :publisher => "Publisher",
      :pub_year => "Pub Year",
      :asin => "Asin",
      :thoughts => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Author/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Publisher/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Pub Year/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Asin/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
