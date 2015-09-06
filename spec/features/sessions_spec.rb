require "spec_helper"

describe "Authentication" do

  context "when logged in" do

    before :each do
      log_in_user
    end

    it "logs in a user" do
      expect(page).to have_content("Signed in")
      expect(current_path).to eq(meta_dashboard_path)
    end

    it "logs out a user" do
      visit destroy_user_session_path

      # Not root_path for now, since I redirect to /on
      expect(current_path).to eq(posts_path)
    end

    it "notifies a user if they are already logged in" do
      visit new_user_session_path

      expect(page).to have_content("already signed in")
    end
  end

  context "when logging in" do
    let(:user) { create(:user) }

    it "redirects to the intended path upon authentication" do
      visit new_meta_book_path

      fill_in "Email", with: user.email
      fill_in "Password", with: test_password
      click_button "Sign in"

      expect(current_path).to eq(new_meta_book_path)
    end
  end
end
