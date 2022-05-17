require 'rails_helper'

RSpec.feature "Comments", type: :feature do
  let!(:user) { FactoryBot.create(:user, password: 'password') }
  let!(:different_user) { FactoryBot.create(:user, password: 'password') }
  let!(:user_goal) { FactoryBot.create(:goal, user: user) }

  background(:each) do
    login_as(email: different_user.email)
    visit user_path(user)
  end

  shared_examples 'comment' do
    feature 'creating comments' do
      scenario 'should have a form for creating a new comment' do
        expect(page).to have_content 'New comment'
        expect(page).to have_field 'Comment'
      end

      scenario 'should show the new goal after creation' do
        fill_in 'Comment', with: 'Great job!'
        click_button 'Save comment'

        expect(page).to have_content 'Comment saved!'
        expect(page).to have_content 'Great job!'
        expect(page).to have_content different_user.email
      end
    end
  end

  describe 'User comments' do
    it_behaves_like 'comment'
  end

  describe 'Goal comments' do
    background(:each) do
      click_on user_goal.title
    end

    it_behaves_like 'comment'
  end
end
