class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @exercise  = current_user.exercises.build
    end
  end

  def help
  end

  def about
  end
  def contact
  end
end
