require 'rails_helper'

feature 'goals CRUD functionality' do
  let!(:user) { FactoryBot.create(:user, password: 'password') }

  background(:each) do
    login_as(email: user.email)
  end

  feature 'creating goals' do
    scenario 'should have a page for creating a new goal' do
      visit new_goal_path
      expect(page).to have_content 'New goal'
    end

    scenario 'should show the new goal after creation' do
      visit new_goal_path
      fill_in 'Title', with: 'test goal'
      check 'Private?'
      click_button 'New goal'

      expect(page).to have_content 'test goal'
      expect(page).to have_content 'Goal saved!'
    end
  end

  feature 'reading goals' do
    scenario 'should list goals' do
      2.times do |i|
        visit new_goal_path
        fill_in 'Title', with: "test goal #{i}"
        fill_in 'Description', with: Faker::Lorem.paragraph
        check 'Private?'

        click_button 'New goal'
      end

      visit goals_path
      expect(page).to have_content 'test goal 0'
      expect(page).to have_content 'test goal 1'
    end
  end

  feature 'updating goals' do
    let(:goal) { FactoryBot.create(:goal, user: user) }

    scenario 'should have a page for updating an existing goal' do
      visit edit_goal_path(goal)

      expect(page).to have_content 'Edit goal'
      expect(find_field('Title').value).to eq(goal.title)
    end

    scenario 'should show the updated goal after changes are saved' do
      visit edit_goal_path(goal)
      fill_in 'Title', with: 'visit the sun'
      click_button 'Update goal'
      expect(page).not_to have_content 'Edit goal'
      expect(page).to have_content 'Goal updated!'
      expect(page).to have_content 'visit the sun'
    end
  end

  feature 'deleting goals' do
    scenario 'should allow the deletion of a goal' do
      2.times do |i|
        visit new_goal_path
        fill_in 'Title', with: "test goal #{i}"
        fill_in 'Description', with: Faker::Lorem.paragraph
        check 'Private?'
        click_button 'New goal'
      end

      visit goals_path
      click_button "Delete 'test goal 1' goal"
      expect(page).not_to have_content 'test goal 1'
      expect(page).to have_content 'Goal deleted!'
    end
  end
end
