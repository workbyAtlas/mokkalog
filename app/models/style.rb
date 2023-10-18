class Style < ApplicationRecord
  has_many :styleables, dependent: :destroy
  has_many :brands, through: :styleables
end
