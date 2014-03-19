require "spec_helper"

describe DayItemsController do
  describe "routing" do

    it "routes to #index" do
      get("/day_items").should route_to("day_items#index")
    end

    it "routes to #new" do
      get("/day_items/new").should route_to("day_items#new")
    end

    it "routes to #show" do
      get("/day_items/1").should route_to("day_items#show", :id => "1")
    end

    it "routes to #edit" do
      get("/day_items/1/edit").should route_to("day_items#edit", :id => "1")
    end

    it "routes to #create" do
      post("/day_items").should route_to("day_items#create")
    end

    it "routes to #update" do
      put("/day_items/1").should route_to("day_items#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/day_items/1").should route_to("day_items#destroy", :id => "1")
    end

  end
end
