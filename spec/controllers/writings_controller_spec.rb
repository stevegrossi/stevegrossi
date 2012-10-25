require 'spec_helper'

describe WritingsController do

  describe "GET #index" do
    it "populates an array of published writings" do
      writing = FactoryGirl.create(:writing)
      get :index
      assigns(:writings).should include writing
    end
    it "excludes unpublished writings" do
      writing = FactoryGirl.create(:writing, published_at: nil)
      get :index
      assigns(:writings).should_not include writing
    end
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested writing to @writing" do
      writing = FactoryGirl.create(:writing)
      get :show, id: writing
      assigns(:writing).should eq(writing)
    end
    it "renders the :show template" do
      get :show, id: FactoryGirl.create(:writing)
      response.should render_template :show
    end
    it "redirects an unpublished writing to :index" do
      get :show, id: FactoryGirl.create(:writing, published_at: nil)
      response.should redirect_to writings_path
    end
  end

end
