class CreateFavoritables < ActiveRecord::Migration[7.0]
  def change
    create_table :favoritables do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
