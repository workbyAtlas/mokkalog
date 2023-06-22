class AddLinkToBrand < ActiveRecord::Migration[7.0]
  def change
    add_column :brands, :link, :string
    add_column :brands, :brand_color, :string, default:0
    add_column :brands, :brand_text, :string, default:0

  end
end
