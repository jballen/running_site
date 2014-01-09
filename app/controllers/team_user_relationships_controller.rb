class TeamUserRelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @team = Team.find(params[:team_user_relationship][:team_id])
    @user = User.find(params[:team_user_relationship][:user_id])
    @team.notifications.find_by(user_id: @user.id).destroy!
    @user.join_team!(@team)
    flash[:success] = 'Added ' + @user.name + ' to the team!'
    redirect_to @team
  end

  def destroy
    @team = TeamUserRelationship.find(params[:id]).team
    @user_id = params[:team_user_relationship][:user_id] || current_user
    @user = User.find(@user_id)
    @user.quit_team!(@team)
    redirect_to @team
  end
end
