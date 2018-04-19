class Book < ApplicationRecord
  has_one :memos, foreign_key: 'memo_id'
  belongs_to :user
  validates :name, presence: true,
                   length: { maximum: 25 }
end
