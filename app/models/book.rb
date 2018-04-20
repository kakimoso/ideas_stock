class Book < ApplicationRecord
  has_many :memos
  belongs_to :user
  validates :name, presence: true,
                   length: { maximum: 25 }
end
