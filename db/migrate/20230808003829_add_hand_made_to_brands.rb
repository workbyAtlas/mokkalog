class AddHandMadeToBrands < ActiveRecord::Migration[7.0]
  def change
    add_column :brands, :hand_made, :string
    add_column :brands, :concept, :string
    add_column :brands, :start_up, :string
    
  end
end
