class Post < ApplicationRecord
	validates :title, presence: {message: "Name can't be blank"}, length: {maximum: 20}
	validates :body, length: { maximum: 3000 }, allow_blank: true
  validates :web_link, format: { with: /\Ahttps?:\/\//, message: 'should start with http:// or https://' }, allow_blank: true
	#validate :check_for_image
	#validates :image, presence: true
	validates :price, numericality: { greater_than: 0, less_than: 99999 }, allow_blank: true
	validate :clean_word

#Associations
	has_one_attached :image

	has_many :taggables, dependent: :destroy
	has_many :tags, through: :taggables

	belongs_to :brand

	has_many :likeables, dependent: :destroy
	has_many :likes, through: :likeables, source: :user

	has_many :collectibles, dependent: :destroy
	has_many :collections, through: :collectibles

	has_many :comments, as: :commentable, dependent: :destroy

	belongs_to :user
	#before_save :downcase_fields




	#validate :image, :image_validation
  	def self.ransackable_attributes(auth_object = nil)
    	["body", "category", "color", "id",  "price", "sub_category", "title", "updated_at", "material", "category", "tags"]
 	end

	 def self.ransackable_associations(auth_object = nil)
	   ["taggables", "tags"]
	 end

	def image_as_thumbnail
		return unless image.content_type.in?(%w[image/jpeg image/png image/webp])
		image.variant(resize_to_fill: [200,200]).processed
	end

	def image_as_profile
		return unless image.content_type.in?(%w[image/jpeg image/png image/webp])
		image.variant(resize_to_fill: [400,400]).processed
	end

	def check_for_image
	    if image.attached? && !image.content_type.in?(%w[image/jpeg image/png image/webp])
	      errors.add(:image, "The file must be, JPEG, PNG, or WEBP")
	    end
	end

	def branded
	 if brand.nil?
	 	"#N/A"
	 else
	 	brand.name
	 end

	end

	#i think this is deletable
	def image_validation
		return unless image.content_type.in?(%w[image/jpeg image/png image/webp])	
	    
  	end

  	private

    def clean_word
      validate_bad_words(:title)
    end

  	def downcase_fields

  		self.body.downcase!
	end
end


