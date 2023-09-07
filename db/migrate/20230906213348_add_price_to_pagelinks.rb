class AddPriceToPagelinks < ActiveRecord::Migration[7.0]
  def change
    add_column :pagelinks, :price, :string
  end
end
