class UsersController < ApplicationController
   
  def index
    @posts = Post.active
    @comment = Comment.new
    @users = User.all
    @friends = current_user.friends
    @pending_requests = current_user.pending_requests
    @friend_requests = current_user.received_requests
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.active
  end
  
end
