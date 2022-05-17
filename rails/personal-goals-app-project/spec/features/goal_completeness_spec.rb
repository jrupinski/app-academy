require 'rails_helper'

feature 'tracking goal progress/completeness' do
  let!(:user) { FactoryBot.create(:user, password: 'password') }
  let!(:goal) { FactoryBot.create(:goal, user: user) }

  background(:each) do
    login_as(email: user.email)
  end

  describe 'New goals are not completed' do
    context 'in Goal#show page' do
      it 'starts as not complete' do
        visit goal_path(goal)
        expect(page).to have_content 'In progress'
      end
    end

    context 'in Goals#index page' do
      it 'starts as not complete' do
        visit goals_path
        expect(page).to have_content 'In progress'
      end
    end

    context 'in User profile page' do
      it 'starts as not complete' do
        visit user_path(user)
        expect(page).to have_content 'In progress'
      end
    end
  end

  describe 'Goals can be toggled as complete' do
    context 'in Goal#show page' do
      it 'Allows user to toggle goal status to complete' do
        visit goal_path(goal)
        click_button "goal_#{goal.id}_completed"
        expect(page).to have_content 'Completed'
      end

      it 'Does not allow other users to edit goal status' do
        visit goal_path(goal)
        expect(page).to have_button "goal_#{goal.id}_completed"
        click_button 'Log out'
        expect(page).to_not have_button "goal_#{goal.id}_completed"
      end

      it 'Does not redirect to a different page' do
        visit goal_path(goal)
        click_button "goal_#{goal.id}_completed"
        expect(page).to have_content 'Goal completedness'
        expect(page).to have_content goal.title
      end
    end

    context 'in Goals#index page' do
      it 'Allows user to toggle goal status to complete' do
        visit goals_path
        click_button "goal_#{goal.id}_completed"
        expect(page).to have_content 'Completed'
      end

      it 'Does not allow other users to edit goal status' do
        visit goals_path
        expect(page).to have_button "goal_#{goal.id}_completed"
        click_button 'Log out'
        expect(page).to_not have_button "goal_#{goal.id}_completed"
      end

      it 'Does not redirect to a different page' do
        visit goals_path
        click_button "goal_#{goal.id}_completed"
        expect(page).to have_content 'Goal completedness'
        expect(page).to have_content goal.title
      end
    end

    context 'in User profile page' do
      it 'Allows user to toggle goal status to complete' do
        visit user_path(user)
        click_button "goal_#{goal.id}_completed"
        expect(page).to have_content 'Completed'
      end

      it 'Does not allow other users to edit goal status' do
        visit user_path(user)
        expect(page).to have_button "goal_#{goal.id}_completed"
        click_button 'Log out'
        expect(page).to_not have_button "goal_#{goal.id}_completed"
      end

      it 'Does not redirect to a different page' do
        visit user_path(user)
        click_button "goal_#{goal.id}_completed"
        expect(page).to have_content 'Goal completedness'
        expect(page).to have_content goal.title
      end
    end
  end
end
