require 'spec_helper'

describe "day_items/new" do
  before(:each) do
    assign(:day_item, stub_model(DayItem,
      :title => "MyString"
    ).as_new_record)
  end

  it "renders new day_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", day_items_path, "post" do
      assert_select "input#day_item_title[name=?]", "day_item[title]"
    end
  end
end
