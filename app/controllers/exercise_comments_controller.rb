class ExerciseCommentsController < ApplicationController

  def create
    @comment = ExerciseComment.new(comment_params)
    @comment.user_id = current_user.id;
    @comment.commenter = current_user.name;
    if @comment.save                
      flash[:success] = "Comment saved."
      redirect_to :back
    else
      flash[:error] = "An error occurred, please try submitting the comment again. "
      redirect_to :back
    end
  end

  private

    def comment_params
      params.require(:exercise_comment).permit(:body, :exercise_id)
    end
end
