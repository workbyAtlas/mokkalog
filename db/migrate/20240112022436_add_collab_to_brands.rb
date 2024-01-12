class AddCollabToBrands < ActiveRecord::Migration[7.0]
  def change
    add_column :brands, :collab, :string
    add_column :brands, :influencer, :string
    add_column :brands, :apparel, :string
    add_column :brands, :influencer_rating, :integer
    add_column :brands, :apparel_rating, :integer    
    add_column :brands, :tiktok, :string

    change_column_default :users, :coins, from: 40, to: 10
  end
end
