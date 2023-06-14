class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :posts
  has_many :brands

  def image_as_avatar
    #return unless avatar.content_type.in?(%w[image/jpeg image/png image/webp])
    #avatar.variant(resize_to_fill: [100,100]).processed if avatar.attached?
    avatar.variant(resize_to_fill: [60,60]).processed if avatar.attached?
  end

  def image_as_profile_page_pic
    #return unless avatar.content_type.in?(%w[image/jpeg image/png image/webp])
    #avatar.variant(resize_to_fill: [100,100]).processed if avatar.attached?
    avatar.variant(resize_to_fill: [400,400]).processed if avatar.attached?
  end


end
