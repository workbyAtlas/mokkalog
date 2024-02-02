class AddVisitsToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :visits, :integer
    add_column :brands, :visits, :integer
  end
end
