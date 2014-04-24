class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include ExercisesHelper
  include UsersHelper
  include TeamsHelper
  include ApplicationHelper

  def get_user_data
    @user = User.find_by(:email => params[:email])
    logger.debug @user
    respond_to do |format|
      format.json do
        @formatted_day_items = []
        @user.day_items.each do |day_item|
          @formatted_day_items << format_day_item_for_json(day_item, @user)
        end
        render json: @formatted_day_items
      end
    end
  end

  def get_user_data_for_month
    month = params[:month]
    year = params[:year]
    date = DateTime.new(year.to_i, month.to_i)
    user = User.find_by(:email => params[:email])
    exercises = user.exercises.where(:day => date..date.end_of_month())
    respond_to do |format|
      format.json do 
        render json: exercises
      end
    end
    logger.debug '************************'
    logger.debug date
    # date = DateTime.strptime(year + '/' + month, '%Y')
  end

  def format_user_data_for_json(user) 
    @new_user = {}
    @new_user['name'] = user.name
    @new_user['email'] = user.email
    @new_user['exercises'] = user.exercises
    return @new_user
  end

  def get_team_data
    @team = Team.find_by(:name => params[:name])
    respond_to do |format|
      format.json do
        @formatted_user_data = []
        @team.users.each do |user|
          @formatted_user_data << format_user_data_for_json(user)
        end
        render json: @formatted_user_data
      end
    end
  end

  def get_users_teams
    @user = User.find_by(:email => params[:email])
    respond_to do |format|
      format.json do
        render json: @user.teams
      end
    end
  end

  # Return 
  def get_all_teams
    respond_to do |format|
      format.json do
        render json: Team.all        
      end
    end
  end
end
