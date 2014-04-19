require 'spec_helper'

describe "team_goals/edit" do
  before(:each) do
    @team_goal = assign(:team_goal, stub_model(TeamGoal,
      :team => nil,
      :distance => "9.99",
      :duration => 1,
      :activity => "MyString",
      :title => "MyString"
    ))
  end

  it "renders the edit team_goal form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", team_goal_path(@team_goal), "post" do
      assert_select "input#team_goal_team[name=?]", "team_goal[team]"
      assert_select "input#team_goal_distance[name=?]", "team_goal[distance]"
      assert_select "input#team_goal_duration[name=?]", "team_goal[duration]"
      assert_select "input#team_goal_activity[name=?]", "team_goal[activity]"
      assert_select "input#team_goal_title[name=?]", "team_goal[title]"
    end
  end
end
