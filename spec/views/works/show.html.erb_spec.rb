require 'spec_helper'

describe "works/show.html.erb" do
  before(:each) do
    @work = assign(:work, stub_model(Work,
      :title => "Title",
      :about => "MyText",
      :url => "Url",
      :client => "Client"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Client/)
  end
end
