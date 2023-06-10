class Tag < ApplicationRecord
	has_many :taggables, dependent: :destroy
	has_many :posts, through: :taggables


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
end
