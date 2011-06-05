require 'spec_helper'

describe "works/index.html.erb" do
  before(:each) do
    assign(:works, [
      stub_model(Work,
        :title => "Title",
        :about => "MyText",
        :url => "Url",
        :client => "Client"
      ),
      stub_model(Work,
        :title => "Title",
        :about => "MyText",
        :url => "Url",
        :client => "Client"
      )
    ])
  end

  it "renders a list of works" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Client".to_s, :count => 2
  end
end
