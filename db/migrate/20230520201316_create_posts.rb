class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.float :price
      t.string :color
      t.string :brand
      t.string :category
      t.string :sub_category
      t.string :web_link
      t.integer :likes

      t.timestamps
    end
  end
end
