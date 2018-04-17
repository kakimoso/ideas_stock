class Memo < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 25, message: '25文字以内で入力してください' }
end
