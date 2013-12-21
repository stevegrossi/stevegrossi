def test_password
  'password'
end

def log_in_user
  user = create(:user)
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: test_password
  click_button 'Sign in'
end

def class_to_symbol(klass)
  klass.to_s.downcase.to_sym
end
