class RunsController < ApplicationController
  # This requires that the user is signed in before
  # they can access the other methods
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @run = current_user.runs.build(run_params)
    if @run.save
      flash[:success] = "Run saved."
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @run.destroy
    redirect_to root_url
  end

  private

    def run_params
      params.require(:run).permit(:distance, :duration, :comment)
    end

    def correct_user
      @run = current_user.runs.find_by(id: params[:id])
      redirect_to root_url if @run.nil?
    end
end
