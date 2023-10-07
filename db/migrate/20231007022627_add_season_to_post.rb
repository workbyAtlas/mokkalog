class AddSeasonToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :season, :string
  end
end
