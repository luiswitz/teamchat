require 'rails_helper'

RSpec.describe Invitation, type: :model do
  describe "create an invitation" do

    before do
      @invitation = FactoryGirl.create(:invitation)
    end

    it "cannot be valid without an user" do
      @invitation.user_email = nil
      expect(@invitation).to_not be_valid
    end
    
    it "cannot be valid without an invited by user" do
      @invitation.invited_by_user = nil
      expect(@invitation).to_not be_valid
    end

  end
end
