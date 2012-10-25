require 'spec_helper'

describe Meta::WritingsController do

  describe "GET #new" do
    context 'as authenticated user' do
      before :each do
        session[:user_id] = 1
      end
      it "assigns a new Writing to @writing" do
        get :new
        assigns(:writing).should be_a(Writing)
        assigns(:writing).should be_new_record
      end
      it "renders the :new template" do
        get :new
        response.should render_template :new
      end
    end

    context 'as unauthenticated user' do
      it 'redirects to the log in page' do
        get :new
        response.should redirect_to log_in_path
      end
    end

  end

  describe "GET #edit" do

    context 'as authenticated user' do
      before :each do
        session[:user_id] = 1
      end
      it "assigns the requested writing to @writing" do
        writing = FactoryGirl.create(:writing)
        get :edit, id: writing.id
        assigns(:writing).should eq(writing)
      end
      it "renders the :edit template" do
        writing = FactoryGirl.create(:writing)
        get :edit, id: writing.id
        response.should render_template :edit
      end
    end

    context 'as unauthenticated user' do
      it 'redirects to the log in page' do
        get :new
        response.should redirect_to log_in_path
      end
    end

  end

  describe "POST #create" do
    before :each do
      session[:user_id] = 1
    end
    context "with valid attributes" do
      it "saves the new writing in the database" do
        expect{
          post :create, writing: FactoryGirl.attributes_for(:writing)
        }.to change(Writing,:count).by(1)
      end
      # TODO: why isn't FriendlyID set here?
      # Expects redirect_to /wrote/friendly_id_slug, instead gets /wrote/1
      #
      # it "redirects to the created writing" do
      #   post :create, writing: FactoryGirl.attributes_for(:writing)
      #   response.should redirect_to Writing.first
      # end
    end

    context "with invalid attributes" do
      it "does not save the new writing in the database" do
        expect{
          post :create, writing: FactoryGirl.attributes_for(:invalid_writing)
        }.to_not change(Writing,:count)
      end
      it "re-renders the :new template" do
        post :create, writing: FactoryGirl.attributes_for(:invalid_writing)
        response.should render_template :new
      end
    end
  end

  describe 'PUT update' do
    before :each do
      session[:user_id] = 1
      @writing = FactoryGirl.create(:writing, content: 'Lorem ipsum.')
    end

    context "with valid attributes" do
      it "locates the requested @writing" do
        put :update, id: @writing, writing: FactoryGirl.attributes_for(:writing)
        assigns(:writing).should eq(@writing)
      end

      it "changes @writing's attributes" do
        put :update, id: @writing,
          writing: FactoryGirl.attributes_for(:writing, title: "War and Peace")
        @writing.reload
        @writing.title.should eq("War and Peace")
      end

      it "redirects to the updated writing"
      # TODO: why isn't FriendlyID set here?
      # Expects redirect_to /wrote/friendly_id_slug, instead gets /wrote/1
      #
      # do
      #   put :update, id: @writing, writing: FactoryGirl.attributes_for(:writing)
      #   response.should redirect_to @writing
      # end
    end

    context "with invalid attributes" do
      it "locates the requested @writing" do
        put :update, id: @writing, writing: FactoryGirl.attributes_for(:invalid_writing)
        assigns(:writing).should eq(@writing)
      end

      it "does not change @writing's attributes" do
        put :update, id: @writing,
          writing: FactoryGirl.attributes_for(:writing, title: "Larry", content: nil)
        @writing.reload
        @writing.title.should_not eq("Larry")
        @writing.content.should eq('Lorem ipsum.')
      end

      it "re-renders the edit method with flash message" do
        put :update, id: @writing, writing: FactoryGirl.attributes_for(:invalid_writing)
        response.should render_template :edit
        flash.should_not be_nil
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      session[:user_id] = 1
      @writing = FactoryGirl.create(:writing)
    end

    it "deletes the writing" do
      expect{
        delete :destroy, id: @writing
      }.to change(Writing,:count).by(-1)
    end

    it "redirects to writings#index" do
      delete :destroy, id: @writing
      response.should redirect_to meta_writings_path
    end
  end

end
