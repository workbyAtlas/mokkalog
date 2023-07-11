class AddBrandIdToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :brand, foreign_key: true
  end
end
