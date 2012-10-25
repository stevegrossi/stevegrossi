require 'spec_helper'

describe "Authentication" do

  let(:user) { FactoryGirl.create(:user) }

  it 'logs in a user' do
    visit log_in_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: 'secret'
    click_button 'Log In'
    page.should have_content('Hey there, sexy')
    current_path.should == meta_dashboard_path
  end

  it 'logs out a user' do
    visit log_in_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: 'secret'
    click_button 'Log In'
    visit log_out_path
    page.should have_content('See you around, cowboy')
    current_path.should == root_path
  end
end
