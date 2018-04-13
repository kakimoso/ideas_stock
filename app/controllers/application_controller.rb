class ApplicationController < ActionController::Base
  # ログイン系のメソッド群
  def login(user)
    @user = User.find(:id, user.name)

  end
end
