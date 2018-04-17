class AddEditflagMemos < ActiveRecord::Migration[5.2]
  def change
    add_column :memos, :edit_flag, :integer
  end
end
