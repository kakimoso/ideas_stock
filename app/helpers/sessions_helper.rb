module SessionsHelper
  # ログインする
  def log_in(user)
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

  # セッションからuser_idを消す
  def log_out
    session[:user_id] = nil
  end
end
