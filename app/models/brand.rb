class Brand < ApplicationRecord
  validates :name, presence: true, length: {maximum: 30}

  validate :check_for_image
  validate :check_for_banner
  
  validates :link, format: { with: /\Ahttps:\/\//, message: "should start with 'https://" }, allow_blank: true, length:{maximum:40}

	has_many :brandables, dependent: :destroy
	has_many :posts, through: :brandables

  has_one_attached :image
  has_one_attached :banner

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

  private
  def downcase_fields
      self.name.downcase
  end
end
