class Collection < ApplicationRecord
	has_many :collectibles, dependent: :destroy
	has_many :posts, through: :collectibles
end
