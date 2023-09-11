class AddSubcatsToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :subcats, :string
  end
end
