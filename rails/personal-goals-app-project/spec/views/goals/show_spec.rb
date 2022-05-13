require "rails_helper"

describe "goals/show" do
  let(:user) { create(:user) }
  let(:goal) { create(:goal, user: user) }

  it 'shows goal title' do
    assign(:goal, goal)

    render

    expect(rendered).to have_content(/#{goal.title}/)
  end

  it 'shows goal description' do
    assign(:goal, goal)

    render

    expect(rendered).to have_content(/#{goal.description}/)
  end

  context 'shows goal privacy setting' do
    let(:public_goal) { create(:goal, user: user, private: false, completed: true) }
    let(:private_goal) { create(:goal, user: user, private: true, completed: true) }

    it 'shows private goal status' do
      assign(:goal, private_goal)

      render

      expect(rendered).to have_content(/Private/)
    end

    it 'shows public goal status' do
      assign(:goal, public_goal)

      render

      expect(rendered).to have_content(/Public/)
    end
  end

  context 'shows goal complete status' do
    let(:completed_goal) { create(:goal, user: user, completed: true) }
    let(:in_progress_goal) { create(:goal, user: user, completed: false) }

    it 'shows completed status' do
      assign(:goal, completed_goal)

      render

      expect(rendered).to have_content(/Completed/)
    end

    it 'shows uncompleted goal status' do
      assign(:goal, in_progress_goal)

      render

      expect(rendered).to have_content(/In progress/)
    end
  end
end
