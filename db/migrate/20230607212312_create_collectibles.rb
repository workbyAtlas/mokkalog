class CreateCollectibles < ActiveRecord::Migration[7.0]
  def change
    create_table :collectibles do |t|
      t.belongs_to :post, null: false, foreign_key: true
      t.belongs_to :collection, null: false, foreign_key: true

      t.timestamps
    end
  end
end
