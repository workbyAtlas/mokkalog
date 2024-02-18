class Collection < ApplicationRecord
	has_many :collectibles, dependent: :destroy
	has_many :posts, through: :collectibles

	has_one_attached :banner
	has_one_attached :image

	belongs_to :user

	def self.ransackable_attributes(auth_object = nil)
		["body", "c_type", "created_at", "id", "likes", "link", "title", "updated_at", "user_id", "views"]
	end
  	def self.ransackable_associations(auth_object = nil)
    	["banner_attachment", "banner_blob", "collectibles", "image_attachment", "image_blob", "posts", "user"]
  	end
end
