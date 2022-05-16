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
end
