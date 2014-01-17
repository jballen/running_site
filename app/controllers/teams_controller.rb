class TeamsController < ApplicationController
  before_action :signed_in_user, only: [:index, :create, :user_request]
  before_action :team_captain?,  only: [:destroy, :update]
  respond_to :json

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def show
    @team = this_team
    @member_items = @team.users.paginate(page: params[:page])
    @notifications = @team.notifications.paginate(page: params[:page])
  end

  def create
    @team = Team.new(team_params)
    # Set the user who created the team to the captain
    @team.captains = current_user.id

    if @team.save
      # Also add the user as a member
      current_user.join_team!(@team)
      flash[:success] = "Created Team: " + @team.name + '!'
      redirect_to @team
    else
      render 'new'
    end
  end

  def list_team_exercises
    @team = this_team
    exercise_arr = []
    @team.users.each do |user|
      user.exercises.each do |exercise|
        exercise_arr << format_exercise_for_json(exercise, user)
      end
    end
    respond_to do |format|
      format.json do
        render json: exercise_arr
      end
    end
  end

  private

    def this_team
      @team ||= Team.find(params[:id])
    end

    def team_captain?(other_user = current_user)
      this_team.captains.to_i == other_user.id
    end

    def team_params
      params.require(:team).permit(:name, :description)
    end
end
