class Style < ApplicationRecord
  has_many :styleables, dependent: :destroy
  has_many :brands, through: :styleables

  has_one_attached :image


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at", "image"]
  end

end
