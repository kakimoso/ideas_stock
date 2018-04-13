class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true,
                   length: { maximum: 20,
                             message: '20文字以内で入力してください' },
                   uniqueness: true
  validates :password, presence: true
  validates :password, length: { minimum: 6,
                                 message: '6文字以上で入力してください' },
                       allow_blank: true

  private

  def user_params
    params.require(:user).parmit(:name, :password, :password_confirmation)
  end
end
