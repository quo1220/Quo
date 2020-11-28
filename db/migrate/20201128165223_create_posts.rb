class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :detail
      t.integer :post_type

      t.timestamps
    end
  end
end
