class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :chat, foreign_key: true
      t.text :content
      t.string :role

      t.timestamps
    end
  end
end
