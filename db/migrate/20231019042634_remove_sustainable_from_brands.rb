class RemoveSustainableFromBrands < ActiveRecord::Migration[7.0]
  def change
    remove_column :brands, :sustainable, :string
    remove_column :brands, :hand_made, :string
  end
end
