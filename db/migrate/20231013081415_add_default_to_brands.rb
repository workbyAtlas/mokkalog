class AddDefaultToBrands < ActiveRecord::Migration[7.0]
  def change
    change_column :brands, :brand_text, :string, default: '#654321;'
    change_column :users, :text_color, :string, default: '#654321;'
  end
end
