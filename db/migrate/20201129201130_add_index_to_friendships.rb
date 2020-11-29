class AddIndexToFriendships < ActiveRecord::Migration[6.0]
  def change
  	 add_index :friendships, [:user_id, :receiver_id], unique: true
  end
end
