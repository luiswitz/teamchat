class InvitationsController < ApplicationController

  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.invited_by_user = current_user

    authorize! :create, @invitation

    respond_to do |format|
      if @invitation.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def invitation_params
    email = params[:invitation][:email]
    user = User.find_by(email: email)
    if !user
      password = SecureRandom.base58(32)
      user = User.new(email: email, password: password, password_confirmation: password)
      user.save!
    end
    params.require(:invitation).permit(:team_id, :email).merge(user_id: user.id) 
  end

end
