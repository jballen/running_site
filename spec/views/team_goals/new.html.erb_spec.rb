require 'spec_helper'

describe "team_goals/new" do
  before(:each) do
    assign(:team_goal, stub_model(TeamGoal,
      :team => nil,
      :distance => "9.99",
      :duration => 1,
      :activity => "MyString",
      :title => "MyString"
    ).as_new_record)
  end

  it "renders new team_goal form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", team_goals_path, "post" do
      assert_select "input#team_goal_team[name=?]", "team_goal[team]"
      assert_select "input#team_goal_distance[name=?]", "team_goal[distance]"
      assert_select "input#team_goal_duration[name=?]", "team_goal[duration]"
      assert_select "input#team_goal_activity[name=?]", "team_goal[activity]"
      assert_select "input#team_goal_title[name=?]", "team_goal[title]"
    end
  end
end
