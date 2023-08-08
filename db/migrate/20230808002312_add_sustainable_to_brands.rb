class AddSustainableToBrands < ActiveRecord::Migration[7.0]
  def change
    add_column :brands, :sustainable, :string
    add_column :brands, :x_twitter, :string
  end
end
