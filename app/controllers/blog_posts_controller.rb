class BlogPostsController < ApplicationController

  def create
    @team = Team.find(params[:blog_post][:team_id])
    @blog_post = @team.blog_posts.build(blog_params)
    @blog_post.user_id = current_user.id
    if @blog_post.save
      flash[:success] = "Post saved."
      redirect_to :back
    else
      flash[:error] = "There was an error saving the post. Please try again."
      redirect_to :back
    end
  end

  def destroy
    BlogPost.find(params[:id]).destroy
    redirect_to :back
  end

  private

    def blog_params 
      params.require(:blog_post).permit(:body, :title, :user_id, :team_id)
    end
end
