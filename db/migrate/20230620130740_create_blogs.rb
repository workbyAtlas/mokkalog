class CreateBlogs < ActiveRecord::Migration[7.0]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :text
      t.string :blog_type
      t.string :pinned

      t.timestamps
    end
  end
end
