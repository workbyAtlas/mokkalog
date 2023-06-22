class AddColumnsToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :c_type, :string
    add_column :posts, :material, :string
    add_column :posts, :amazon_link, :text
  end
end
