class Category < ApplicationRecord
	has_many :posts

 def self.ransackable_associations(auth_object = nil)
   ["posts"]
 end
end
