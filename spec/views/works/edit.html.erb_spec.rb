require 'spec_helper'

describe "works/edit.html.erb" do
  before(:each) do
    @work = assign(:work, stub_model(Work,
      :title => "MyString",
      :about => "MyText",
      :url => "MyString",
      :client => "MyString"
    ))
  end

  it "renders the edit work form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => works_path(@work), :method => "post" do
      assert_select "input#work_title", :name => "work[title]"
      assert_select "textarea#work_about", :name => "work[about]"
      assert_select "input#work_url", :name => "work[url]"
      assert_select "input#work_client", :name => "work[client]"
    end
  end
end
