class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :image, ImageUploader

  has_many :posts, dependent:   :destroy
  has_many :likes
  has_many :friend_request_sent, class_name: 'Friendship',
                                 foreign_key: 'sent_by_id',
                                 dependent: :destroy
  has_many :friend_request_receive, class_name: 'Friendship',
                                    foreign_key: 'sent_to_id',
                                    dependent: :destroy
  has_many :friends, -> { merge(Friendship.friends) },
            through: :friend_request_sent, source: :sent_to
  has_many :pending_requests, -> { merge(Friendship.not_friends) },
            through: :friend_request_sent, source: :sent_to    
  has_many :received_requests, -> { merge(Friendship.not_friends) },
            through: :friend_request_receive, source: :sent_by

	def full_name
    "#{first_name} #{last_name}"
  end
end
