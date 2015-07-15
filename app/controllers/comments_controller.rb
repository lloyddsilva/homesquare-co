class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create!(comment_params)
        @comment.user = current_user
        @comment.save
        redirect_to(:back)
    end

  # DELETE /comments/1
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to(:back)
  end

private
        # Never trust parameters from the scary internet, only allow the white list through.
        def comment_params
            params.require(:comment).permit(:post_id, :comment, :user_id)
        end
    end