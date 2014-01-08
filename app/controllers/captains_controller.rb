class CaptainsController < ApplicationController
  def create
    @captain = current_user.captains.build(captain_params)
    if @captain.save

    else

    end
  end
  def destroy
    
  end

  private

    def captain_params
      params.require(:captain).permit(:user_id, :team_id)
    end
end
