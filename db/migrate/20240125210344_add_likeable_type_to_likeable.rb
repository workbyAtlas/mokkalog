class AddLikeableTypeToLikeable < ActiveRecord::Migration[7.0]
  def change
    rename_column :likeables, :post_id, :likeable_id
    add_column :likeables, :likeable_type, :string

    # Ensure existing records have the correct type
    Likeable.update_all(likeable_type: 'Post')
  end
end
