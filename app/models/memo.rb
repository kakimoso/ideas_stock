class Memo < ApplicationRecord
  belongs_to :book
  delegate :user, to: :book
  validates :title,
            presence: true,
            length: { maximum: 25 }
  VALID_EDFLAG_REGEX = /[1-3]/
  validates :edit_flag,
            presence: true,
            format: { with: VALID_EDFLAG_REGEX }

  # 1.非公開 2.編集不可 3.公開

  # メモの所持者もしくは3なら編集可能とする
  def editable?(current_user = true)
    user = User.find_by(id: user_id)
    (user == current_user || edit_flag == 3)
  end

  # メモが閲覧可能ならtrueを返す
  def visible?(current_user)
    user = User.find_by(id: user_id)
    (user == current_user || edit_flag != 1)
  end
end
