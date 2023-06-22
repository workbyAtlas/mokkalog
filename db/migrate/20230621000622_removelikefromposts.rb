class Removelikefromposts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :edited_by, :string

  end
end
