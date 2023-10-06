class AddBadgeToBrand < ActiveRecord::Migration[7.0]
  def change
    add_column :brands, :badge, :string
    add_column :brands, :metadesc, :text
  end
end
