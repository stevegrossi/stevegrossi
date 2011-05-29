require 'spec_helper'

describe "writings/index.html.erb" do
  before(:each) do
    assign(:writings, [
      stub_model(Writing,
        :title => "Title",
        :content => "MyText",
        :summary => "Summary"
      ),
      stub_model(Writing,
        :title => "Title",
        :content => "MyText",
        :summary => "Summary"
      )
    ])
  end

  it "renders a list of writings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Summary".to_s, :count => 2
  end
end
