def log_in_user
  user = FactoryGirl.create(:user)
  visit log_in_path
  fill_in 'username', with: user.username
  fill_in 'password', with: 'secret'
  click_button 'Log In'
end
