class CreateBrandables < ActiveRecord::Migration[7.0]
  def change
    create_table :brandables do |t|
      t.belongs_to :post, null: false, foreign_key: true
      t.belongs_to :brand, null: false, foreign_key: true

      t.timestamps
    end
  end
end
