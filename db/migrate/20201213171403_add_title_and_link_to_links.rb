class AddTitleAndLinkToLinks < ActiveRecord::Migration[6.0]
  def change
  	add_column :links, :url, :string, null: false
  	add_column :links, :title, :string, null: false
  end
end
