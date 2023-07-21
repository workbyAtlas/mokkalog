class AddStyleToBrand < ActiveRecord::Migration[7.0]
  def change
    add_column :brands, :style, :string
    add_column :brands, :verification, :string
    add_column :brands, :location, :string
  end
end
