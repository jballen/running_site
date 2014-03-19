require 'spec_helper'

describe "day_items/edit" do
  before(:each) do
    @day_item = assign(:day_item, stub_model(DayItem,
      :title => "MyString"
    ))
  end

  it "renders the edit day_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", day_item_path(@day_item), "post" do
      assert_select "input#day_item_title[name=?]", "day_item[title]"
    end
  end
end
