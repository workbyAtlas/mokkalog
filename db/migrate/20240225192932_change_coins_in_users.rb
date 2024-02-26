class ChangeCoinsInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :coins, 0
  end
end
