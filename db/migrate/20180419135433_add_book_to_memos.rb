class AddBookToMemos < ActiveRecord::Migration[5.2]
  def change
    add_reference :memos, :book, foreign_key: true
  end
end
