class Collectible < ApplicationRecord
  belongs_to :post
  belongs_to :collection
end
