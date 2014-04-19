require 'spec_helper'

describe "team_goals/index" do
  before(:each) do
    assign(:team_goals, [
      stub_model(TeamGoal,
        :team => nil,
        :distance => "9.99",
        :duration => 1,
        :activity => "Activity",
        :title => "Title"
      ),
      stub_model(TeamGoal,
        :team => nil,
        :distance => "9.99",
        :duration => 1,
        :activity => "Activity",
        :title => "Title"
      )
    ])
  end

  it "renders a list of team_goals" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Activity".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
