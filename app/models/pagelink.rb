class Pagelink < ApplicationRecord
  belongs_to :user
  belongs_to :post

   validates :web_link, format: { with: /\Ahttps:\/\//, message: "should start with 'https://" }, length:{maximum:80}
   validates :body, length:{maximum:25}, allow_blank: false
   validates :price, format: { with: /\A\d+\z/, message: "should only contain numbers" }
end
