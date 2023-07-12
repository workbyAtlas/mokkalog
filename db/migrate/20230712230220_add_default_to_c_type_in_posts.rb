class AddDefaultToCTypeInPosts < ActiveRecord::Migration[7.0]
  def change
    change_column_default :posts, :c_type, "neutral"
    add_column :posts, :grailed, :text
  end
end
