require "spec_helper"

describe "Publicly" do
  let(:redirect) { create(:redirect) }

  it "performs the redirect" do
    visit "/#{redirect.from}"

    # This isn't technically right, but since I'm only redirecting root
    # to /on temporarily and that's what Rails wants to do, I can live
    # with it if the test still works.
    expect(current_url).to eq("#{redirect.to}/on")
  end
end

describe "Administrates redirects" do

  before :each do
    log_in_user
  end

  describe "redirects dashboard" do
    let!(:redirect) { create(:redirect) }

    it "displays redirects" do
      visit meta_redirects_path

      expect(page).to have_content(redirect.from)
    end
  end

  describe "when creating a redirect" do

    before :each do
      visit new_meta_redirect_path
    end

    context "with valid attributes" do

      before :each do
        fill_in "From", with: "google"
        fill_in "To", with: "http://google.com"
      end

      it "creates a new redirect when you click 'Publish'" do
        expect {
          click_button "Publish"
        }.to change(Redirect, :count).by(1)
        expect(page).to have_content "google"
      end
    end

    context "with invalid attributes" do

      it "shows errors without saving redirect" do
        expect {
          fill_in "To", with: ""
          fill_in "From", with: ""
          click_button "Publish"
        }.not_to change(Redirect, :count)
        expect(page).to have_selector(".error")
      end
    end
  end

  describe "editing redirects" do
    let!(:redirect) { create(:redirect, from: "resume") }

    before :each do
      visit edit_meta_redirect_path(redirect)
    end

    context "with valid attributes" do

      it "redirects to the redirects meta index" do
        fill_in "To", with: "http://amazon.com"
        click_button "Publish"

        within "h1" do
          expect(page).to have_content("All the redirects.")
        end
      end
    end

    context "with invalid attributes" do

      it "re-renders the new redirect form with a flash" do
        fill_in "To", with: ""
        click_button "Publish"

        within ".Flash" do
          expect(page).to have_content("errors")
        end
      end
    end

    context "when you click delete" do

      it "destroys the redirect and confirms" do
        expect {
          click_link "Delete this Redirect"
        }.to change(Redirect, :count).by(-1)
        within ".Flash--notice" do
          expect(page).to have_content("You deleted the redirect.")
        end
      end
    end
  end

end
