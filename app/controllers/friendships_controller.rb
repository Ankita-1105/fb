class FriendshipsController < ApplicationController
  include ApplicationHelper
  def create
    @friendship = current_user.friend_request_sent.build(sent_to_id: params[:user_id])
    if @friendship.save
      flash[:success] = 'Friend Request Sent!'
    else
      flash[:danger] = 'Friend Request Failed!'
    end
    redirect_to root_path
  end

  def accept_friend
    @friendship = Friendship.find_by(sent_by_id: params[:user_id], sent_to_id: current_user.id, status: false)
    return unless @friendship

    @friendship.status = true

    if @friendship.save
      flash[:success] = 'Friend Request Accepted!'
      @friendship2 = current_user.friend_request_sent.build(sent_to_id: params[:user_id], status: true)
      @friendship2.save
    else
      flash[:danger] = 'Friend Request could not be accepted!'
    end
    redirect_to root_path
  end

  def decline_friend
    @friendship = Friendship.find_by(sent_by_id: params[:user_id], sent_to_id: current_user.id, status: false)
    return unless @friendship
    
    @friendship.destroy
    flash[:success] = 'Friend Request Declined!'
    redirect_to root_path
  end
end
