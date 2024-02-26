class AddStateToBrand < ActiveRecord::Migration[7.0]
  def change
    add_column :brands, :state, :string
  end
end
