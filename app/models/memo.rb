class Memo < ApplicationRecord
  belongs_to :user
  validates :title,
            presence: true,
            length: { maximum: 25, message: '25文字以内で入力してください' }
  validates :edit_flag,
            presence: true

  # メモの所持者もしくは2なら編集可能とし、is_editableにtrueをセット
  def editable?(current_user)
    user = User.find_by(id: user_id)
    (user == current_user || edit_flag == 2)
  end
end
