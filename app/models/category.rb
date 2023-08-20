class Category < ApplicationRecord
	has_many :posts

 def self.ransackable_associations(auth_object = nil)
   ["posts"]
 end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
end
