class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true,
                   length: { maximum: 20 },
                   uniqueness: true
  validates :password, presence: true
  validates :password, length: { minimum: 6 },
                       allow_blank: true
  has_many :memos

  private

  def user_params
    params.require(:user).parmit(:name, :password, :password_confirmation)
  end
end
