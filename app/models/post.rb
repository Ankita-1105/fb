class Post < ApplicationRecord
	belongs_to :user
	has_many :likes
	has_many :comments

	mount_uploader :image, ImageUploader
	default_scope -> { order(created_at: :desc) }

	scope :active, -> { where active: true }
	before_create :set_active

  private

  def set_active
  	self.active = true
  end
end
