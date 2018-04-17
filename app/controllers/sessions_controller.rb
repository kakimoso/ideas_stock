# ログイン系の処理を行う
class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user_path(user)
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render 'new'
    end
  end

  # ヘルパーのログアウトメソッドを呼ぶ
  def destroy
    log_out if logged_in_user?
    redirect_to root_path
  end

end
