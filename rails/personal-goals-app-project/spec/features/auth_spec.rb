require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'Sign up'
  end

  feature 'signing up a user' do
    subject(:user) { build(:user) }

    before(:each) do
      visit new_user_url
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Create'
    end

    scenario 'shows username on the homepage after signup' do
      expect(page).to have_content "Welcolme #{user.email}"
    end
  end

  feature 'with an invalid user' do
    before(:each) do
      visit new_user_url
      fill_in 'Password', with: 'short'
      click_button 'Create'
    end

    scenario 're-renders the new page with error printout after failed signup' do
      expect(page).to have_content(/password is /)
    end
  end
end

feature 'logging in' do
  feature 'with valid user credentials' do
    subject(:user) { create(:user) }

    before(:each) do
      visit new_session_url
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Login'
    end

    scenario 'shows username on the homepage after login' do
      expect(page).to have_content "Welcolme #{user.email}"
    end
  end

  feature 'with an invalid user' do
    before(:each) do
      visit new_session_url
      fill_in 'Email', with: 'wrong_email'
      fill_in 'Password', with: 'wrong_password'
      click_button 'Login'
    end

    scenario 're-renders the login page with error printout after failed signup' do
      expect(page).to have_content('Username or password is not valid')
    end
  end
end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    visit root_url
    expect(page).to have_content 'Log in'
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    subject(:user) { create(:user) }

    visit new_session_url
    fill_in 'Email', with: 'wrong_email'
    fill_in 'Password', with: 'wrong_password'
    click_button 'Login'

    click_button 'Logout'
    expect(page).not_to have_content user.email.to_s
  end
end
