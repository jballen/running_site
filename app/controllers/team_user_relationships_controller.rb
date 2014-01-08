class TeamUserRelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @team = Team.find(params[:team_user_relationship][:team_id])
    current_user.join_team!(@team)
    respond_to do |format|
      format.html {redirect_to @team}
      format.js
    end
  end

  def destroy
    @team = TeamUserRelationship.find(params[:id]).team
    current_user.quit_team!(@team)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
end
