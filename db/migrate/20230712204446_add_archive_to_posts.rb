class AddArchiveToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :archive, :string
  end
end
