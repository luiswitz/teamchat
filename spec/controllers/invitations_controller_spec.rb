require 'rails_helper'

RSpec.describe InvitationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = FactoryGirl.create(:user)
    sign_in @current_user
  end

  describe "POST #create" do
    before do
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    render_views

    context "Team owner invites a system user" do
      before(:each) do
        @team = FactoryGirl.create(:team, user: @current_user)
        @system_user = FactoryGirl.create(:user)

        post :create, params: { invitation: { user_email: @system_user.email, team_id: @team.id } }
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "Returns the right params" do
        response_hash = JSON.parse(response.body)

        expect(response_hash["user_email"]).to eql(@system_user.email)
        expect(response_hash["team_id"]).to eql(@team.id)
      end
    end

    context "Team owner invites a non system user" do
      before(:each) do
        @team = FactoryGirl.create(:team, user: @current_user)
        @new_user_mail = FFaker::Internet.email

        post :create, params: { invitation: { user_email: @new_user_mail, team_id: @team.id } }
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end


      it "Returns the right params" do
        response_hash = JSON.parse(response.body)

        expect(response_hash["user_email"]).to eql(@new_user_mail)
        expect(response_hash["team_id"]).to eql(@team.id)
      end

      it "creates an invitation" do
        expect(Invitation.count).to eq(1)
      end
    end
  end

  describe "#accept" do
    context "when logged in with an invited user" do
      before do
        @invitation = FactoryGirl.create(:invitation, user_email: @current_user.email)
        get :accept, params: { token: @invitation.token }
      end

      it "accepts the invitation" do
        @invitation.reload
        expect(@invitation.accepted?).to be(true)
      end
    end

    context "when logged in with a non invited user" do
      before do
        @invitation = FactoryGirl.create(:invitation, user_email: FFaker::Internet.email)
        get :accept, params: { token: @invitation.token }
      end

      it "redirects the user to root path" do
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
