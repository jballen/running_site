require 'spec_helper'

describe "Static pages" do

  describe "Home page" do
    it "should have the content 'LogAJog'" do
      visit root_path
      expect(page).to have_content('LogAJog')
    end
  end
end