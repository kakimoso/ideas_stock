# ログイン系のロジックをもつ
module SessionsHelper

  # ログインする
  def login(user)
    session[:user_id] = user.id
  end

  # 現在のユーザを返す
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    end
  end

  # ログイン中のユーザか
  def logged_in_user?
    !current_user.nil?
  end
end
