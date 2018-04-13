# ログイン系の処理を行う
class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      debugframe 'ユーザ判別成功'
      log_in user
      redirect_to user_path(@user)
    else
      debugframe 'ユーザ判別失敗'
      flash.now[:danger] = 'ログインに失敗しました。'
      render 'new'
    end
  end

end
