class DropBrandablesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :brandables
  end
end
