require 'spec_helper'

describe 'Authentication' do

  context 'when logged in' do

    before :each do
      log_in_user
    end

    it 'logs in a user' do
      page.should have_content('Signed in')
      current_path.should eq(meta_dashboard_path)
    end

    it 'logs out a user' do
      visit destroy_user_session_path
      current_path.should eq(posts_path) # Not root_path for now, since I redirect to /on
    end

    it 'notifies a user if they are already logged in' do
      visit new_user_session_path
      page.should have_content('already signed in')
    end
  end

  context 'when logging in' do

    it 'redirects to the intended path upon authentication' do
      user = create(:user)
      visit new_meta_book_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: test_password
      click_button 'Sign in'
      current_path.should eq(new_meta_book_path)
    end
  end
end
