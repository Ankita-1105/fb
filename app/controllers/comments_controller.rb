class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id if user_signed_in?
    if @comment.save
      redirect_to root_path, flash: { success: 'Comment was created successfully' }
    else
      redirect_to root_path, flash: { danger: 'Comment was not created' }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :post_id)
  end
end