module AuthHelper
  def sign_up_as(email:)
    visit new_user_path
    fill_in 'Email', with: email
    fill_in 'Password', with: 'password'
    click_button 'Create user'
  end

  def login_as(email:)
    visit new_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end
end
