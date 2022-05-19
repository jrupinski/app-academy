require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_path
    expect(page).to have_content 'Sign up'
  end

  feature 'signing up a user' do
    subject(:user) { build(:user) }

    before(:each) do
      sign_up_as(email: user.email)
    end

    scenario 'shows username on the homepage after signup' do
      expect(page).to have_content "Welcome #{user.email}"
    end
  end

  feature 'with user email already taken' do
    subject(:existing_user) { create(:user, password: 'password') }

    before(:each) do
      sign_up_as(email: existing_user.email)
    end

    scenario 're-renders the new page with error printout after failed signup' do
      expect(page).to have_content('Email has already been taken')
    end
  end

  feature 'with an invalid user' do
    before(:each) do
      sign_up_as(email: '')

    end

    scenario 're-renders the new page with error printout after failed signup' do
      expect(page).to have_content(/Email can't be blank/)
    end
  end
end

feature 'logging in' do
  feature 'with valid user credentials' do
    subject(:user) { create(:user, password: 'password') }

    before(:each) do
      login_as(email: user.email)
    end

    scenario 'shows username on the homepage after log in' do
      expect(page).to have_content "Welcome #{user.email}"
    end
  end

  feature 'with an invalid user' do
    before(:each) do
      login_as(email: 'wrong_user@example.com')
    end

    scenario 're-renders the log in page with error printout after failed signup' do
      expect(page).to have_content('Invalid credentials')
    end
  end
end

feature 'logging out' do
  subject(:user) { create(:user, password: 'password') }

  scenario 'begins with a logged out state' do
    visit root_path
    expect(page).to have_link 'Log in'
  end

  scenario 'doesn\'t show username on the homepage after log out' do
    login_as(email: user.email)

    click_button 'Log out'
    expect(page).not_to have_content user.email.to_s
  end
end
