class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  #has_ont_attached :avatar


  def image_as_avatargg
    #return unless avatar.content_type.in?(%w[image/jpeg image/png image/webp])
    #avatar.variant(resize_to_fill: [100,100]).processed if avatar.attached?
    avatar.variant(resize: "100x100").processed if avatar.attached?
  end
end
