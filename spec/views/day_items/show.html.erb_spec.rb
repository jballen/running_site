require 'spec_helper'

describe "day_items/show" do
  before(:each) do
    @day_item = assign(:day_item, stub_model(DayItem,
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
  end
end
