require 'rails_helper'

RSpec.describe InvitationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    request.env["HTTP_ACCEPT"] = 'application/json'

    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = FactoryGirl.create(:user)
    sign_in @current_user
  end

  describe "POST #create" do
    render_views

    context "Team owner invites a system user" do
      before(:each) do
        @team = FactoryGirl.create(:team, user: @current_user)
        @system_user = FactoryGirl.create(:user)

        post :create, params: { invitation: { email: @system_user.email, team_id: @team.id } }
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "Returns the right params" do
        response_hash = JSON.parse(response.body)

        expect(response_hash["user"]["email"]).to eql(@system_user.email)
        expect(response_hash["team_id"]).to eql(@team.id)
      end
    end

    context "Team owner invites a non system user" do
      before(:each) do
        @team = FactoryGirl.create(:team, user: @current_user)
        @new_user_mail = FFaker::Internet.email

        post :create, params: { invitation: {email: @new_user_mail, team_id: @team.id } }
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "creates a new user" do
        @new_user = User.find_by_email(@new_user_mail)
        expect(@new_user.email).to eq(@new_user_mail)
      end

      it "Returns the right params" do
        response_hash = JSON.parse(response.body)

        expect(response_hash["user"]["email"]).to eql(@new_user_mail)
        expect(response_hash["team_id"]).to eql(@team.id)
      end
    end
  end

end
