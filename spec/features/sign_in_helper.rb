def sign_in
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: 'alice@example.com')
  fill_in('Password', with: 'alice123')
  fill_in('Password confirmation', with: 'alice123')
  click_button('Sign up')
end
