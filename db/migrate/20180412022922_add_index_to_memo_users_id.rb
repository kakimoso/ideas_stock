class AddIndexToMemoUsersId < ActiveRecord::Migration[5.2]
  def change
    add_index :memos, %i[user_id updated_at]
  end
end
