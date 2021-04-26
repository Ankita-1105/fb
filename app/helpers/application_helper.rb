module ApplicationHelper
  def friend_request_sent?(user)
    current_user.friend_request_sent.exists?(sent_to_id: user.id)
  end
  
  def friend_request_received?(user)
    current_user.friend_request_receive.exists?(sent_by_id: user.id)
  end
  
  def possible_friend?(user)
    request_sent = current_user.friend_request_sent.exists?(sent_to_id: user.id)
    request_received = current_user.friend_request_receive.exists?(sent_by_id: user.id)
    return true if request_sent != request_received
    return true if request_sent == request_received && request_sent == true
    return false if request_sent == request_received && request_sent == false
  end
end
