def log_in_user
  user = FactoryGirl.create(:user)
  visit log_in_path
  fill_in 'Username', with: user.username
  fill_in 'Password', with: 'secret'
  click_button 'Log In'
end

def class_to_symbol(klass)
  klass.to_s.downcase.to_sym
end
