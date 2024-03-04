class Activity < ApplicationRecord
  belongs_to :post, dependent: :destroy
  belongs_to :user, optional: true
  

  def self.ransackable_attributes(auth_object = nil)
    ["id"]
  end
end
