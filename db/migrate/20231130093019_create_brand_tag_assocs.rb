class CreateBrandTagAssocs < ActiveRecord::Migration[7.0]
  def change
    create_table :brand_tag_assocs do |t|
      t.belongs_to :brand, null: false, foreign_key: true
      t.belongs_to :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
