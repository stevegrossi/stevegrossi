require 'spec_helper'

describe "writings/new.html.erb" do
  before(:each) do
    assign(:writing, stub_model(Writing,
      :title => "MyString",
      :content => "MyText",
      :summary => "MyString"
    ).as_new_record)
  end

  it "renders new writing form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => writings_path, :method => "post" do
      assert_select "input#writing_title", :name => "writing[title]"
      assert_select "textarea#writing_content", :name => "writing[content]"
      assert_select "input#writing_summary", :name => "writing[summary]"
    end
  end
end
