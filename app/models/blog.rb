class Blog < ApplicationRecord
	has_rich_text :text
	has_many :comments, as: :commentable, dependent: :destroy
	belongs_to :user
  has_one_attached :cover


  def image_as_avatar
    #return unless avatar.content_type.in?(%w[image/jpeg image/png image/webp])
    #avatar.variant(resize_to_fill: [100,100]).processed if avatar.attached?
    avatar.variant(resize: "100x100").processed if avatar.attached?
  end

  def cover_image
    #return unless avatar.content_type.in?(%w[image/jpeg image/png image/webp])
    #avatar.variant(resize_to_fill: [100,100]).processed if avatar.attached?
    cover.variant(resize_to_fill: [400,300]).processed
    #cover.variant(resize: "400x200").processed
  end

  def main_image
    cover.variant(resize_to_fill: [500,450]).processed
  end

  def cover_imagev(image)
    image.variant(resize_to_fill: [400,300]).processed
  end
end
