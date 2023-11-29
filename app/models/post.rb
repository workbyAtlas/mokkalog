class Post < ApplicationRecord
	extend FriendlyId
	validates :title, presence: {message: "Name can't be blank"}, length: {maximum: 40}
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


	#friendly_id :custom_slug, use: [:slugged, :finders]
	friendly_id :custom_slug, use: %i[slugged finders history]
	#friendly_id :custom_slug, use: %i[slugged]

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

	has_many :favoritables, dependent: :destroy
	has_many :favorites, through: :favoritables, source: :user

	has_many :collectibles, dependent: :destroy
	has_many :collections, through: :collectibles

	has_many :comments, as: :commentable, dependent: :destroy
	has_many :pagelinks, dependent: :destroy

	belongs_to :user
	#before_save :downcase_fields
	#SLUGS
  def custom_slug
    "#{brand.name.parameterize}-#{title.parameterize}"
  end

	def should_generate_new_friendly_id?
		title_changed? || slug.blank?
	end

	#validate :image, :image_validation
  def self.ransackable_attributes(auth_object = nil)
    ["body", "color", "id",  "price", "sub_category",
     "title", "updated_at", "material", "archive", "c_type", "season"]
 	end

	 def self.ransackable_associations(auth_object = nil)
	   ["taggables", "tags", "brand", "category"]
	 end

	def cat
		Category.pluck(:name)
	end

	def sc
		if category.nil?
			[""]
		else
			category.subcats.split(',')
		end
	end

	def image_post
		image.variant(resize_to_fill: [350,400]).processed
	end

	def image_as_profile
		return unless image.content_type.in?(%w[image/jpeg image/png image/webp image/avif])
		image.variant(resize_to_fill: [400,400]).processed
	end

	def check_for_image
		#attributes = []
	    if image.attached? && !image.content_type.in?(%w[image/jpeg image/png image/webp image/avif])
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

	def titled
		shortened_title = title.truncate(30, omission: '', separator: ' ')
		display_title = shortened_title.length > 20 ? "#{shortened_title[0..16]}..." : shortened_title
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


