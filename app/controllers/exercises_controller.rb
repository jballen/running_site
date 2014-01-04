class ExercisesController < ApplicationController
  # This requires that the user is signed in before
  # they can access the other methods
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

    def exercise_params
      params.require(:exercise).permit(:distance, :duration, :comment)
    end

    def correct_user
      @exercise = current_user.exercises.find_by(id: params[:id])
      redirect_to root_url if @exercise.nil?
    end
end
