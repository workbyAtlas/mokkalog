class RemoveSlugFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_index :users, :slug, unique: true
    remove_column :users, :slug, :string
  end
end
