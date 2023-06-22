class Blog < ApplicationRecord
	has_rich_text :text
	has_many :comments, as: :commentable, dependent: :destroy
	belongs_to :user


  def image_as_avatar
    #return unless avatar.content_type.in?(%w[image/jpeg image/png image/webp])
    #avatar.variant(resize_to_fill: [100,100]).processed if avatar.attached?
    avatar.variant(resize: "100x100").processed if avatar.attached?
  end
end
