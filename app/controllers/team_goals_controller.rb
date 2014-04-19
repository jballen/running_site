class TeamGoalsController < ApplicationController
  before_action :set_team_goal, only: [:show, :edit, :update, :destroy]

  # GET /team_goals
  # GET /team_goals.json
  def index
    @team_goals = TeamGoal.all
  end

  # GET /team_goals/1
  # GET /team_goals/1.json
  def show
  end

  # GET /team_goals/new
  def new
    @team_goal = TeamGoal.new
  end

  # GET /team_goals/1/edit
  def edit
  end

  # POST /team_goals
  # POST /team_goals.json
  def create
    @team_goal = TeamGoal.new(team_goal_params)

    respond_to do |format|
      if @team_goal.save
        format.html { redirect_to @team_goal, notice: 'Team goal was successfully created.' }
        format.json { render action: 'show', status: :created, location: @team_goal }
      else
        format.html { render action: 'new' }
        format.json { render json: @team_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_goals/1
  # PATCH/PUT /team_goals/1.json
  def update
    respond_to do |format|
      if @team_goal.update(team_goal_params)
        format.html { redirect_to @team_goal, notice: 'Team goal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @team_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_goals/1
  # DELETE /team_goals/1.json
  def destroy
    @team_goal.destroy
    respond_to do |format|
      format.html { redirect_to team_goals_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_goal
      @team_goal = TeamGoal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_goal_params
      params.require(:team_goal).permit(:team_id, :start_date, :end_date, :distance, :duration, :activity, :title)
    end
end
