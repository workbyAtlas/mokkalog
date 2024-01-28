class RemoveForeignKeyFromLikeables < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :likeables, :posts
  end
end
