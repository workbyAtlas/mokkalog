class AddLocationToActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :location, :string
  end
end
