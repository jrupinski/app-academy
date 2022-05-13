require "rails_helper"

describe "goals/index" do
  let(:user) { create(:user) }
  let(:goal_foo) { create(:goal, user: user) }
  let(:goal_bar) { create(:goal, user: user) }

  it 'shows #index page header' do
    assign(:goals, [goal_foo])

    render

    expect(rendered).to have_content(/Your goals/)
  end

  it 'shows goal title' do
    assign(:goals, [goal_foo, goal_bar])

    render

    expect(rendered).to have_content(/#{goal_foo.title}/)
    expect(rendered).to have_content(/#{goal_bar.title}/)
  end

  context 'shows goal privacy setting' do
    let(:public_goal) { create(:goal, user: user, private: false, completed: true) }
    let(:private_goal) { create(:goal, user: user, private: true, completed: true) }

    it 'shows private goal status' do
      assign(:goals, [private_goal])

      render

      expect(rendered).to have_content(/Private/)
    end

    it 'shows public goal status' do
      assign(:goals, [public_goal])

      render

      expect(rendered).to have_content(/Public/)
    end
  end

  context 'shows goal complete status' do
    let(:completed_goal) { create(:goal, user: user, completed: true) }
    let(:in_progress_goal) { create(:goal, user: user, completed: false) }

    it 'shows completed status' do
      assign(:goals, [completed_goal])

      render

      expect(rendered).to have_content(/Completed/)
    end

    it 'shows uncompleted goal status' do
      assign(:goals, [in_progress_goal])

      render

      expect(rendered).to have_content(/In progress/)
    end
  end
end
