require 'spec_helper'

describe Meta::DashboardController do

  describe "GET #home" do
    context 'as authenticated user' do
      before :each do
        session[:user_id] = 1
      end

      it "renders the :home template" do
        get :home
        response.should render_template :home
      end
    end

    context 'as unauthenticated user' do
      it 'redirects to the log in page' do
        get :home
        response.should redirect_to log_in_path
      end
    end
  end

end
