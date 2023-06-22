class Tag < ApplicationRecord
	validates :name, length: { maximum: 20 }, allow_blank: true
  
  has_many :taggables, dependent: :destroy
	has_many :posts, through: :taggables



  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
end

