class DayItemsController < ApplicationController
  before_action :set_day_item, only: [:show, :edit, :update, :destroy]
  before_action :fix_params, :only => [:create, :update]
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:update, :destroy]
  # GET /day_items
  # GET /day_items.json
  def index
    @day_items = DayItem.all
  end

  # GET /day_items/1
  # GET /day_items/1.json
  def show
  end

  # GET /day_items/new
  def new
    @day_item = DayItem.new
  end

  # GET /day_items/1/edit
  def edit
  end

  # POST /day_items
  def create
    @day_item = get_or_init_day_item
    @exercise_comment = ExerciseComment.new(:body => params[:day_item][:exercises_attributes]['0'][:comment],
                                            :commenter_email => current_user.email,
                                            :user_id => current_user,
                                            :commenter_name => current_user.name,
                                            :exercise_id => @day_item.exercises.last.id)
    @exercise_comment.save!
    respond_to do |format|
      if @day_item.save
        format.html { 
          flash[:success] = 'Exercise saved.'
          redirect_back_or current_user
        }
      else
        format.html {
          logger.debug 'ERROR'
          logger.debug @day_item.exercises.first.id
          flash[:error] = 'There was an error saving the exercise. Please try again.'
          redirect_back_or current_user
        }
      end
    end
  end

  # PATCH/PUT /day_items/1
  # PATCH/PUT /day_items/1.json
  def update
    respond_to do |format|
      if @day_item.update(day_item_params)
        format.html { redirect_to @day_item, notice: 'Day item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @day_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /day_items/1
  # DELETE /day_items/1.json
  def destroy
    @day_item.destroy
    respond_to do |format|
      format.html { redirect_to day_items_url }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def day_item_params
      params.require(:day_item).permit(:day, 
                                       :title,
                                       :user_id,
                                       exercises_attributes: [:distance, 
                                         :duration, 
                                         :comment, 
                                         :activity, 
                                         :activity_date,
                                         :unit,
                                         :user_id])
    end

    def get_or_init_day_item
      @day_item = DayItem.find_by(:day => params[:day_item][:day])
      if @day_item == nil
        logger.debug 'New day item created'
        @day_item = DayItem.create(day_item_params)
      else
        logger.debug 'Day existed'
        @day_item.update(day_item_params)
      end
      return @day_item
    end

    def fix_params
      params[:day_item][:exercises_attributes]['0'][:activity_date] = params[:day_item][:day]
      @hours = params[:day_item][:exercises_attributes]['0'].delete(:duration_hours).to_i
      @minutes = params[:day_item][:exercises_attributes]['0'].delete(:duration_minutes).to_i
      @seconds = params[:day_item][:exercises_attributes]['0'].delete(:duration_seconds).to_i
      params[:day_item][:exercises_attributes]['0'][:duration] = @hours * 3600 + @minutes * 60 + @seconds
      logger.debug '^^^^^^^^^^^^^^^^^^^'
      logger.debug params[:day_item]
    end

    def correct_user
      @exercise = current_user.exercises.find_by(id: params[:id])
      redirect_to root_url if @exercise.nil?
    end
end
