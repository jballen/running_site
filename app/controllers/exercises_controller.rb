class ExercisesController < ApplicationController
  
  def edit    
  end

  def create
  end

  def destroy
    @exercise = Exercise.find(params[:id]).destroy
    redirect_back_or current_user
  end
end
