require 'rails_helper'

RSpec.describe "Removing users from teams", type: :feature do
  context "An user leaves the team" do
    before do
      @team = FactoryGirl.create(:team)
      @user = FactoryGirl.create(:user)

      @team.users << @user
      login_as(@user)
      
      visit "/#{@team.slug}"
    end

    it "shows a leave team button" do
      expect(page).to have_link("Sair do Time")
    end
    
    it "removes the user from the team" do
      click_link "Sair do Time"

      expect(@team.users.count).to eq(0)
    end

  end
end
