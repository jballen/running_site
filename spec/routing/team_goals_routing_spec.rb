require "spec_helper"

describe TeamGoalsController do
  describe "routing" do

    it "routes to #index" do
      get("/team_goals").should route_to("team_goals#index")
    end

    it "routes to #new" do
      get("/team_goals/new").should route_to("team_goals#new")
    end

    it "routes to #show" do
      get("/team_goals/1").should route_to("team_goals#show", :id => "1")
    end

    it "routes to #edit" do
      get("/team_goals/1/edit").should route_to("team_goals#edit", :id => "1")
    end

    it "routes to #create" do
      post("/team_goals").should route_to("team_goals#create")
    end

    it "routes to #update" do
      put("/team_goals/1").should route_to("team_goals#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/team_goals/1").should route_to("team_goals#destroy", :id => "1")
    end

  end
end
