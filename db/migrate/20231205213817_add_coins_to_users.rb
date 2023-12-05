class AddCoinsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :coins, :integer, default: 40
  end
end
