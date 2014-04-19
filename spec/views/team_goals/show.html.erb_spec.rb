require 'spec_helper'

describe "team_goals/show" do
  before(:each) do
    @team_goal = assign(:team_goal, stub_model(TeamGoal,
      :team => nil,
      :distance => "9.99",
      :duration => 1,
      :activity => "Activity",
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/9.99/)
    rendered.should match(/1/)
    rendered.should match(/Activity/)
    rendered.should match(/Title/)
  end
end
