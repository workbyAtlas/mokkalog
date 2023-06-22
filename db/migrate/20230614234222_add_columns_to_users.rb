class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :last_name, :string
    add_column :users, :link1, :text
    add_column :users, :link2, :text
    add_column :users, :primary_color, :string, default: "#cbb595;"
    add_column :users, :secondary_color, :string, default: "#654321;"
    add_column :users, :text_color, :string, default: "black"
  end
end
