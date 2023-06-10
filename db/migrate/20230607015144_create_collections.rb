class CreateCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :collections do |t|
      t.integer :likes, default: 0
      t.integer :views, default: 0
      t.text :body

      t.timestamps
    end
  end
end
