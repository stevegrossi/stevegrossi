require 'spec_helper'

describe "books/edit.html.erb" do
  before(:each) do
    @book = assign(:book, stub_model(Book,
      :title => "MyString",
      :author => "MyString",
      :publisher => "MyString",
      :pub_year => "MyString",
      :asin => "MyString",
      :thoughts => "MyText"
    ))
  end

  it "renders the edit book form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => books_path(@book), :method => "post" do
      assert_select "input#book_title", :name => "book[title]"
      assert_select "input#book_author", :name => "book[author]"
      assert_select "input#book_publisher", :name => "book[publisher]"
      assert_select "input#book_pub_year", :name => "book[pub_year]"
      assert_select "input#book_asin", :name => "book[asin]"
      assert_select "textarea#book_thoughts", :name => "book[thoughts]"
    end
  end
end
