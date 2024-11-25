class CreateStyleables < ActiveRecord::Migration[7.0]
  def change
    create_table :styleables do |t|
      t.belongs_to :brand, null: false, foreign_key: true
      t.belongs_to :style, null: false, foreign_key: true

      t.timestamps
    end
  end
end
