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
  end

  def format_user_data_for_json(user) 
    @new_user = {}
    @new_user['name'] = user.name
    @new_user['email'] = user.email
    @new_user['total_mileages'] = calculate_monthly_mileage(user)
    return @new_user
  end

  def calculate_monthly_mileage(user) 
    date = Time.now
    bog= date.beginning_of_month().strftime("%Y-%m-%d")
    eom = date.end_of_month().strftime("%Y-%m-%d")
    logger.debug "*********************"
    logger.debug bog
    logger.debug eom
    exercises = user.exercises.where(:activity_date => bog..eom)
    total_mileages = {}
    exercises.each do |exercise|
      mileage_key = exercise.activity + '_total_mileage'
      if total_mileages[mileage_key].nil?
        total_mileages[mileage_key] = 0
      end
      total_mileages[mileage_key] = total_mileages[mileage_key] + exercise.distance
    end
    if total_mileages["run_total_mileage"].nil?
      total_mileages["run_total_mileage"] = 0
    end
    return total_mileages
  end

  def calculate_team_rankings team_data
   team_data = team_data.sort_by { |x| -x["total_mileages"]["run_total_mileage"] } 
   count = 1
   team_data.each do |member|
     member["rank"] = count
     count = count + 1
   end    
   return team_data
  end

  def get_team_data
    @team = Team.find_by(:name => params[:name])
    respond_to do |format|
      format.json do
        @formatted_user_data = []
        @team.users.each do |user|
          @formatted_user_data << format_user_data_for_json(user)
        end
	@ordered_data = calculate_team_rankings @formatted_user_data
        render json: @ordered_data
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

  def get_user_data_for_day
    @user = User.find_by(:email => params[:email])
    if !@user.nil?
      day_item = @user.day_items.where(:day => params[:day])
      if !day_item.empty?
	      day_item = day_item.first
        respond_to do |format|
          format.json do
            render json: day_item.exercises
          end
        end
      else
	render json: {}
      end
    else
      respond_to do |format|
        format.json do 
          render json: {:error => "Could not find user"}
        end
      end
    end
  end

  def post_user_activity
    @user = User.find_by(:email => params[:email])
    params[:day_item][:exercises_attributes]["0"].merge!("user_id" => @user.id)
    params[:day_item].merge!("user_id" =>  @user.id)
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
      @exercise_comment = ExerciseComment.new(:body => params[:day_item][:exercises_attributes]["0"][:comment],
                                            :commenter_email => @user.email,
                                            :user_id => @user.id,
                                            :commenter_name => @user.name,
                                            :exercise_id => @day_item.exercises.last.id)
      @exercise_comment.save!
    end
    render json: "1"
  end
 
  def post_activity_comment
    @commenter = User.find_by(:email => params[:commenter])
    @receiver = User.find_by(:email => params[:receiver])
    @exercise_comment = ExerciseComment.new(:body => params[:text],
                                            :commenter_email => @commenter.email,
                                            :user_id => @receiver.id,
                                            :commenter_name => @commenter.name,
                                            :exercise_id => params[:exercise_id])
    if @exercise_comment.save
      render json: {'success' => 'the comment was saved successfully' }
    else
      render json: {'error' => 'the exercise comment could not be saved'}
    end
  end

  def join_team
    @user = User.find_by(:email => params[:email])
    @team = Team.find_by(:id => params[:team_id])
    if !Notification.where(team_id: @team.id, user_id: @user.id).empty?
      render json: {"response" : "0"}
    end
    @notification = Notification.new(:user_id => @user.id,
                                     :team_id => @team.id,
                                     :what => "join")
    if @notification.save
      render json: {"response" : "1"}
    else
      render json: {"response" : "1"}
    end
  end

  def register_user
    @user = User.find_by(:email => params[:email])
    if @user.nil?
      @new_user = User.new(:email => params[:email],
                           :name => params[:name])
      render json: {"success" => "created user"}
    else
      render json: {"error" => "user exists"}
    end
  end

  private 

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
