class Post < ApplicationRecord
	validates :title, presence: true, length: {minimum:3, maximum: 30}
	validates :body, length: {minimum:3, maximum: 3000}

	has_one_attached :image


	has_many :taggables, dependent: :destroy
	has_many :tags, through: :taggables

	has_many :brandables, dependent: :destroy
	has_many :brands, through: :brandables

	has_many :collectibles, dependent: :destroy
	has_many :collections, through: :collectibles

	has_many :comments, dependent: :destroy

	belongs_to :user
	before_save :downcase_fields



	#validate :image, :image_validation
  	def self.ransackable_attributes(auth_object = nil)
    	["body", "category", "color", "created_at", "id", "likes", "price", "sub_category", "title", "updated_at", "web_link"]
 	end

	 def self.ransackable_associations(auth_object = nil)
	   ["brandables", "brands", "image_attachment", "image_blob", "taggables", "tags"]
	 end

	def image_as_thumbnail
		return unless image.content_type.in?(%w[image/jpeg image/png image/webp])
		image.variant(resize_to_fill: [200,200]).processed
	end

	def image_as_profile
		return unless image.content_type.in?(%w[image/jpeg image/png image/webp])
		image.variant(resize_to_fill: [400,400]).processed
	end



	def image_validation
		return unless image.content_type.in?(%w[image/jpeg image/png image/webp])	
	    
  	end

  	private

  	def downcase_fields

  		self.body.downcase!
	end
end


