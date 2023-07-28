class Post < ApplicationRecord
	validates :title, presence: {message: "Name can't be blank"}, length: {maximum: 25}
	validates :body, length: { maximum: 3000 }, allow_blank: true
	validates :price, numericality: { greater_than: 0, less_than: 99999 }, allow_blank: true
	validates :body, length: {maximum: 6000}, allow_blank: true
	#Links
  validates :web_link, format: { with: /\Ahttps?:\/\//, message: 'should start with http:// or https://' }, allow_blank: true
  validates :amazon_link, format: { with: /\Ahttps?:\/\//, message: 'should start with http:// or https://' }, allow_blank: true
  validates :grailed, format: { with: /\Ahttps?:\/\//, message: 'should start with http:// or https://' }, allow_blank: true

	validate :check_for_image
	validates :image, presence: true

	validate :clean_word




#Associations
	has_one_attached :image
	has_one_attached :image1
	has_one_attached :image2
	has_one_attached :image3
	has_rich_text :body
	
	has_many :taggables, dependent: :destroy
	has_many :tags, through: :taggables

	belongs_to :brand
	belongs_to :category, optional: true

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
	   ["taggables", "tags", "brand"]
	 end

	#def image_as_thumbnail
		#return unless image.content_type.in?(%w[image/jpeg image/png image/webp])
		#image.variant(resize_to_fill: [200,200]).processed
	#end

	def image_post
		image.variant(resize_to_fill: [350,400]).processed
	end

	def image_as_profile
		return unless image.content_type.in?(%w[image/jpeg image/png image/webp])
		image.variant(resize_to_fill: [400,400]).processed
	end

	def check_for_image
		#attributes = []
	    if image.attached? && !image.content_type.in?(%w[image/jpeg image/png image/webp])
	      errors.add(:image, "The file must be, JPEG, PNG, or WEBP")
	    end

	end

	#Redefining Attributes
	def branded
	 if brand.nil?
	 	"#N/A"
	 else
	 	brand.name
	 end
	end

	def categoryed
		if category.nil?
			"#N/A"
		else
			category.name
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




end


