class AddUserToBrands < ActiveRecord::Migration[7.0]
  def change
    add_column :brands, :body, :text
    add_column :brands, :views, :integer, default: 0
    add_reference :brands, :user, null: false, foreign_key: true
  end
end
