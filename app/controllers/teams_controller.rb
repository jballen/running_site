class TeamsController < ApplicationController
  before_action :signed_in_user, only: [:index]
  before_action :team_captain,   only: [:edit, :update, :destroy]

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def show
    @team = Team.find(params[:id])
  end

  def create
    @team = Team.new(team_params)
    # Set the user who created the team to the captain
    @team.captain = Captain.new(:user_id => current_user, :team_id => params[:id])
    # 
    # Also add the user as a member
    current_user.teams ||= []
    current_user.teams << @team.team_id
    current_user.save

    if @team.save
      flash[:success] = "Created Team: " + @team.name + '!'
      redirect_to @team
    else
      render 'new'
    end
  end

  private

    def team_captain
      #TODO
    end

    def team_params
      params[:captain] = current_user
      params.require(:team).permit(:name, :captain, :description)
    end
end
