require 'spec_helper'

describe "books/new.html.erb" do
  before(:each) do
    assign(:book, stub_model(Book,
      :title => "MyString",
      :author => "MyString",
      :publisher => "MyString",
      :pub_year => "MyString",
      :asin => "MyString",
      :thoughts => "MyText"
    ).as_new_record)
  end

  it "renders new book form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => books_path, :method => "post" do
      assert_select "input#book_title", :name => "book[title]"
      assert_select "input#book_author", :name => "book[author]"
      assert_select "input#book_publisher", :name => "book[publisher]"
      assert_select "input#book_pub_year", :name => "book[pub_year]"
      assert_select "input#book_asin", :name => "book[asin]"
      assert_select "textarea#book_thoughts", :name => "book[thoughts]"
    end
  end
end
