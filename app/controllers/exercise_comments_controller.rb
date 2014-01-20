class ExerciseCommentsController < ApplicationController

  def create
    @comment = ExerciseComment.new(comment_params)

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
      params.require(:exercise_comment).permit(:body,
                                               :commenter,
                                               :exercise_id)
    end
end
