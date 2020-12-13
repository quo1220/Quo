class CreateSuggests < ActiveRecord::Migration[6.0]
  def change
    create_table :suggests do |t|
      t.references :post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :suggest_type
      t.string :name
      t.string :about

      t.timestamps
    end
    add_index :suggests, :suggest_type
  end
end
