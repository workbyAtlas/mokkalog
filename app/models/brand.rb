class Brand < ApplicationRecord
  extend FriendlyId
  validates :name, uniqueness: true, presence: true, length:{ maximum: 25}
  #validate :unique_name_case_insensitive
  validates :body, length: {maximum: 6000}, allow_blank: true
  validates :header, length: {maximum:2000}, allow_blank: true
  validates :brand_text, length: {maximum:40}, allow_blank: true

  validate :check_for_image
  validate :check_for_banner
  
  validates :link, format: { with: /\Ahttps:\/\//, message: "should start with 'https://" }, allow_blank: true, length:{maximum:60}
  validates :ig_link, format: { with: /\Ahttps:\/\//, message: "should start with 'https://" }, allow_blank: true, length:{maximum:60}
  validates :x_twitter, format: { with: /\Ahttps:\/\//, message: "should start with 'https://" }, allow_blank: true, length:{maximum:60}


  validate :unique_name_case_insensitive

  friendly_id :name, use: %i[slugged]
	has_many :posts

  has_one_attached :image
  has_one_attached :banner
  has_one_attached :gallery1
  has_one_attached :gallery2
  has_one_attached :gallery3
  has_rich_text :body
  belongs_to :user

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
    ["created_at", "id", "name", "views", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["brandables", "image_attachment", "image_blob", "posts", "user"]
  end

  def image_brand
    image.variant(resize_to_fill: [300,300]).processed
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
        errors.add(:image, "The file must be, JPEG, PNG, or WEBP")
      end
  end
  def check_for_banner
      if banner.attached? && !banner.content_type.in?(%w[image/jpeg image/png image/webp])
        errors.add(:banner, "The file must be, JPEG, PNG, or WEBP")
      end
  end






  def unique_name_case_insensitive
    if Brand.exists?(name: name.downcase)
      return
      errors.add(:name, "has already been taken")
    end
  end

end
