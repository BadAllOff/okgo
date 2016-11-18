require "rails_helper"

RSpec.describe EventMembershipsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/event_memberships").to route_to("event_memberships#index")
    end

    it "routes to #new" do
      expect(:get => "/event_memberships/new").to route_to("event_memberships#new")
    end

    it "routes to #show" do
      expect(:get => "/event_memberships/1").to route_to("event_memberships#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/event_memberships/1/edit").to route_to("event_memberships#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/event_memberships").to route_to("event_memberships#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/event_memberships/1").to route_to("event_memberships#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/event_memberships/1").to route_to("event_memberships#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/event_memberships/1").to route_to("event_memberships#destroy", :id => "1")
    end

  end
end
