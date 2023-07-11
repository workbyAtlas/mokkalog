class AddHeaderToBrands < ActiveRecord::Migration[7.0]
  def change
    add_column :brands, :header, :text
    add_column :brands, :ig_link, :string
    add_column :brands, :last_edited, :string
  end
end
