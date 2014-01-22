class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  respond_to :json

  def show
    @user = User.find(params[:id])
    @exercise_comment = ExerciseComment.new
    if @user.id == current_user.id
      @exercise  = current_user.exercises.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
    respond_to do |format|
      format.html do
        @exercises = @user.exercises.paginate(page: params[:page])
      end
    end
  end
  
  def list_exercises
    @user = User.find(params[:id])
    respond_to do |format|
      format.json do
        @formatted_exercises = []
        @user.exercises.each do |exercise|
          @formatted_exercises << format_exercise_for_json(exercise, @user)
        end
        render json: @formatted_exercises
      end
    end
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to LogAJog!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
