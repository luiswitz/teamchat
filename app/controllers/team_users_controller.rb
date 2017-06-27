class TeamUsersController < ApplicationController
  before_action :set_team_user, only: [:destroy]

  def create
    @team_user = TeamUser.new(team_user_params)
    authorize! :create, @team_user

    respond_to do |format|
      if @team_user.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @team_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :destroy, @team_user
    @team_user.destroy
    flash[:notice] = "Você saiu do time #{@team_user.team.slug}" 
    
    respond_to do |format|
      format.json { render json: true }
      format.html { redirect_to root_path }
    end
  end

  private

  def set_team_user
    @team_user = TeamUser.find_by(user_id: params[:id], team_id: params[:team_id])
  end

  def team_user_params
    user = User.find_by(email: params[:team_user][:email])
    params.require(:team_user).permit(:team_id).merge(user_id: user.id)
  end
end
