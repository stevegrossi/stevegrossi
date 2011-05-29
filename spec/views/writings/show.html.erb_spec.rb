require 'spec_helper'

describe "writings/show.html.erb" do
  before(:each) do
    @writing = assign(:writing, stub_model(Writing,
      :title => "Title",
      :content => "MyText",
      :summary => "Summary"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Summary/)
  end
end
