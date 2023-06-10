class RemoveBrandFromPost < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :brand, :string
  end
end
