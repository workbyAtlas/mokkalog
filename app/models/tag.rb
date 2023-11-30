class Tag < ApplicationRecord
	validates :name, length: { maximum: 20 }, allow_blank: true
  
  has_many :taggables, dependent: :destroy
	has_many :posts, through: :taggables

  has_many :brand_tag_assocs, dependent: :destroy
  has_many :brands, through: :brand_tag_assocs



  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
end

