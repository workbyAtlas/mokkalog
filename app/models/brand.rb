class Brand < ApplicationRecord
  validates :name, presence: true, length: {minimum:3, maximum: 30}

	has_many :brandables, dependent: :destroy
	has_many :posts, through: :brandables
  has_one_attached :image
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



  def image_validation
    return unless image.content_type.in?(%w[image/jpeg image/png image/webp]) 
      
    end

  private
  def downcase_fields
      self.name.downcase!
  end
end
