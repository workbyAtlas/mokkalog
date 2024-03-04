class Activity < ApplicationRecord
  belongs_to :post, dependent: :destroy
  belongs_to :user, optional: true
  

  def self.ransackable_attributes(auth_object = nil)
    ["id", "location"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["post", "user"]
  end

end
