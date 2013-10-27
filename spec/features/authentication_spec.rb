require 'spec_helper'

describe "Authentication" do

  before :each do
    log_in_user
  end

  it 'logs in a user' do
    page.should have_content('Hey there')
    current_path.should == meta_dashboard_path
  end

  it 'logs out a user' do
    visit log_out_path
    current_path.should == posts_path # Not root_path for now, since I redirect to /on
  end

  it 'notifies a user if they are already logged in' do
    visit log_in_path
    page.should have_content('already logged in')
  end
end