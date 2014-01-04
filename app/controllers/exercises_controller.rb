class ExercisesController < ApplicationController
  # This requires that the user is signed in before
  # they can access the other methods
  before_filter :fix_params, :only => [:create, :update]
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @exercise = current_user.exercises.build(exercise_params)
    if @exercise.save
      flash[:success] = "exercise saved."
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @exercise.destroy
    redirect_to root_url
  end

  private
    def fix_params
      # @exer = params.delete(:exercise)
      @hours = params[:exercise].delete(:duration_hours).to_i
      @minutes = params[:exercise].delete(:duration_minutes).to_i
      @seconds = params[:exercise].delete(:duration_seconds).to_i
      
      logger.debug 'Hours: ' + @hours.to_s
      logger.debug 'Minutes: ' + @minutes.to_s
      logger.debug 'Seconds: ' + @seconds.to_s
      params[:exercise][:duration] = @hours * 3600 + @minutes * 60 + @seconds
    end
    def exercise_params
      params.require(:exercise).permit(:distance, 
                                       :duration, 
                                       :comment, 
                                       :activity, 
                                       :activity_date)
    end

    def correct_user
      @exercise = current_user.exercises.find_by(id: params[:id])
      redirect_to root_url if @exercise.nil?
    end
end
