class Brandable < ApplicationRecord
  belongs_to :post
  belongs_to :brand
end
