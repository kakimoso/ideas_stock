class ApplicationController < ActionController::Base
  include SessionsHelper

  # デバッグ用メッセージフレーム
  def debugframe(message)
    puts "[debug_message] : #{message}"
  end

  # ユーザーのログインを確認する
  def logged_in_user
    if current_user.nil?
      flash[:danger] = 'ログインしてください'
      redirect_to login_url
    end
  end
end
