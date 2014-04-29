class NotificationsController < ApplicationController
  before_action :signed_in_user

  def create
    @team = Team.find(params[:notification][:team_id])
    
    if !Notification.where(team_id: @team.id, user_id: current_user.id).empty?
      flash[:success] = "Your request has been received and is pending captain approval."
      redirect_to @team
      return
    end
    @notification = @team.notifications.build(notification_params)
    if @notification.save
      flash[:success] = "Sent request to team captain."
      redirect_to @team
    else
      flash[:error] = "An error occurred with your request to join the team. Please try again."
      redirect_to @team
    end
  end

  def notification_params
    params.require(:notification).permit(:user_id, :team_id, :what)
  end
  def destroy
    @notification.destroy
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

end
