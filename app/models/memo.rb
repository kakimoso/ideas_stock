class Memo < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 50, message: '50文字以内で入力してください' }
end
