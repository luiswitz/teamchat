class InvitationsController < ApplicationController
  before_action :set_invitation, only: [:accept]

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


  def accept
    if @invitation
      @invitation.accept
      @invitation.save
      @team = @invitation.team
      @team.users << @invitation.get_user
      @team.save
    else
      redirect_to :root, notice: "It is not a valid invitation"
    end
  end

  private

  def set_invitation
    @invitation = Invitation.find_by(token: params[:token], user_email: current_user.email)
  end

  def invitation_params
    params.require(:invitation).permit(:team_id, :user_email)
  end

end
