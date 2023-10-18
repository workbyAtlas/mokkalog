class RemoveStyleFromBrand < ActiveRecord::Migration[7.0]
  def change
    remove_column :brands, :style, :string
  end
end
