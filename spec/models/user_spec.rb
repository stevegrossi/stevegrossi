require "spec_helper"

describe User do

  describe "#days_alive" do
    let(:user) { build(:user, birthdate: 1.year.ago.to_date) }

    it "returns the number of days since the user’s date of birth" do
      expect(user.days_alive).to be_in 365..366 # timezones
    end

    context "when the user has no birthday" do
      let(:user) { build(:user) }

      it "returns 0" do
        expect(user.days_alive).to be 0
      end
    end
  end
end
