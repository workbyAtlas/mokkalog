class CreatePagelinks < ActiveRecord::Migration[7.0]
  def change
    create_table :pagelinks do |t|
      t.string :web_link
      t.text :body
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
