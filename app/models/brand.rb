class Brand < ApplicationRecord
  validates :name, uniqueness: true, presence: true, length:{ maximum: 20}

  validate :check_for_image
  validate :check_for_banner
  
  validates :link, format: { with: /\Ahttps:\/\//, message: "should start with 'https://" }, allow_blank: true, length:{maximum:40}


	has_many :posts
  has_rich_text :body



  has_one_attached :image
  has_one_attached :banner
  has_one_attached :gallery1
  has_one_attached :gallery2
  has_one_attached :gallery3
  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "views", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["brandables", "image_attachment", "image_blob", "posts", "user"]
  end

  def image_as_thumbnail
    return unless image.content_type.in?(%w[image/jpeg image/png image/webp])
    image.variant(resize_to_fill: [200,200]).processed
  end

  def image_as_profile
    return unless image.content_type.in?(%w[image/jpeg image/png image/webp])
    image.variant(resize_to_fill: [400,400]).processed
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

end
