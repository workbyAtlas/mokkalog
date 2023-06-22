class AddColumnsToUserstwo < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :integer, default:0
    add_column :users, :link1_title, :string
    add_column :users, :link2_title, :string
    add_column :users, :description, :text
  end
end
