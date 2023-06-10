class Brand < ApplicationRecord
	has_many :brandables, dependent: :destroy
	has_many :brands, through: :brandables


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end

  private
  def downcase_fields
      self.name.downcase!
  end
end
