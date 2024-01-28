#require 'tf-idf-similarity'
class Brand < ApplicationRecord
  extend FriendlyId

  validates :name, uniqueness: true, presence: true, length:{ maximum: 25}
  #validate :unique_name_case_insensitive
  validates :body, length: {maximum: 4000}, allow_blank: true
  validates :header, length: {maximum:2000}, allow_blank: true

  validate :check_for_image
  validate :check_for_banner

  validates :styles, length: { maximum: 5, message: "Too many styles! Please choose up to 5!" }
  validates :link, format: { with: /\Ahttps:\/\//, message: "should start with 'https://" }, allow_blank: true, length:{maximum:60}
  validates :ig_link, format: { with: /\Ahttps:\/\//, message: "should start with 'https://" }, allow_blank: true, length:{maximum:60}
  validates :x_twitter, format: { with: /\Ahttps:\/\//, message: "should start with 'https://" }, allow_blank: true, length:{maximum:60}

  validate :unique_name_case_insensitive

  friendly_id :name, use: %i[slugged finders history]

  has_one_attached :image
  has_one_attached :banner
  has_one_attached :gallery1
  has_one_attached :gallery2
  has_one_attached :gallery3
  has_rich_text :body
  belongs_to :user

  has_many :posts, dependent: :destroy
  has_many :styleables, dependent: :destroy
  has_many :styles, through: :styleables

  has_many :brand_tag_assocs, dependent: :destroy
  has_many :tags, through: :brand_tag_assocs

  has_many :likeables, as: :likeable, dependent: :destroy
  has_many :likes, through: :likeables, source: :user

  

  scope :grouped_by_day, -> { group_by_day(:created_at) }






  def similarity_to(other_brand)
    # Implement your similarity metric here
    styles_similarity = styles & other_brand.styles
    location_similarity = (location == other_brand.location) ? 1 : 0
    views_similarity = (views - other_brand.views).abs

    # Combine the similarities using weights or other criteria if needed
    combined_similarity = styles_similarity.size
    #combined_similarity = styles_similarity.size
  end

  def dissimilarity_to(other_brand)
    # Assuming you want to use the opposite of your similarity metric
    1 / (1 + similarity_to(other_brand))
  end


  def should_generate_new_friendly_id?
    name_changed? || slug.blank?
  end
  
  def countries_name
    CS.countries.with_indifferent_access
  end

  def country_label
    countries_name[location]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "views", "updated_at", "verification", "badge", "style_id","location"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["brandables", "image_attachment", "image_blob", "posts", "user","styles","tags"]
  end


  #SO MESSY UNDER HERE:(
  def image_brand
    image.variant(resize_to_fill: [300,300]).processed
  end

  def image_post
    image.variant(resize_to_fill: [350,400]).processed
  end

  def image_as_thumbnail
    return unless image.content_type.in?(%w[image/jpeg image/png image/webp])
    image.variant(resize_to_fill: [200,200]).processed
  end

  def banner_image
    return unless banner.content_type.in?(%w[image/jpeg image/png image/webp])
    banner.variant(resize_to_fill: [400,400]).processed
  end

  private

  def check_for_image()
      if image.attached? && !image.content_type.in?(%w[image/jpeg image/png image/webp])
        errors.add(:image, "file must be, JPEG, PNG, or WEBP")
      end
  end

  def check_for_banner
      if banner.attached? && !banner.content_type.in?(%w[image/jpeg image/png image/webp])
        errors.add(:banner, "file must be, JPEG, PNG, or WEBP")
      end
  end

  def unique_name_case_insensitive
    if Brand.exists?(name: name.downcase)
      return
      errors.add(:name, "has already been taken")
    end
  end

end
