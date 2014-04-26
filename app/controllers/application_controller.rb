class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
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
    exercises = user.exercises.where(:activity_date => date..date.end_of_month())
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

  def post_user_activity
    @user = User.find_by(:email => params[:email])
    @day_item = DayItem.find_by(:day => params[:day_item][:day])
    if @day_item == nil
      # create a new day item
      logger.debug 'Creating new day item'
      @day_item = DayItem.create(day_item_params)

    else
      logger.debug 'Day item already existed'
      @day_item.update(day_item_params)
    end
    if @day_item.save
      logger.debug "\n\nSuccessfully saved the activity!\n\n"
    else
      logger.debug "\n\nCould not save the activity :(\n\n"
    end
    render json: "1"
  end

  def day_item_params
    params.require(:day_item).permit(:day,
                                 :title,
                                 :user_id,
                                 exercises_attributes: [
                                    :distance,
                                    :duration,
                                    :comment,
                                    :activity,
                                    :activity_date,
                                    :unit,
                                    :user_id])
  end
end
