require "spec_helper"

describe WritingsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/writings" }.should route_to(:controller => "writings", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/writings/new" }.should route_to(:controller => "writings", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/writings/1" }.should route_to(:controller => "writings", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/writings/1/edit" }.should route_to(:controller => "writings", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/writings" }.should route_to(:controller => "writings", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/writings/1" }.should route_to(:controller => "writings", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/writings/1" }.should route_to(:controller => "writings", :action => "destroy", :id => "1")
    end

  end
end
